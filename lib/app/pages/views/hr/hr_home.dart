import 'dart:io';
import 'dart:typed_data';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/data/models/salary.dart';
import 'package:eservices/config/const.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/hr/attendances.dart';
import 'package:eservices/app/pages/views/hr/courses.dart';
import 'package:eservices/app/pages/views/hr/covenants.dart';
import 'package:eservices/app/pages/views/hr/decisions.dart';
import 'package:eservices/app/pages/views/hr/leave_requests.dart';
import 'package:eservices/app/pages/views/hr/payrolls.dart';
import 'package:eservices/app/pages/views/hr/qualifications.dart';
import 'package:eservices/app/pages/views/hr/request_status.dart';
import 'package:eservices/app/pages/views/hr/salary_def.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdf;

class Hr extends StatelessWidget {
  final String userID;
  Hr({Key? key, required this.userID}) : super(key: key);
  int CardsCount = 7;
  Map<String, dynamic> userData = MySharedPref.getUserData();

  @override
  Widget build(BuildContext context) {
    CardsCount = userData['userType'] == 'academic' ? 7 : 9;
    int index = -1;

    hrServices.addAllIf(userData['userType'] == 'academic', {
      {'الحضور والإنصراف': "كشف الحضور والانصراف الخاص بالموظف"}: {
        'تفاصيل الحضور والانصراف الخاصة بالموظف': FontAwesomeIcons.personBooth
      },
      {'طلبات الاستئذان': "طلبات الاستئذان الخاصة بالموظف"}: {
        'تفاصيل طلبات الاستئذان الخاصة بالموظف': FontAwesomeIcons.personRunning
      },
    });

    chipListHR.addAllIf(userData['userType'] == 'academic', [
      ["الإنصراف", "الحضور"],
      ["الاستئذان", "طلبات"],
    ]);

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.15, left: 8.w, right: 8.w),
              child: SizedBox(
                height: Get.height,
                child: AnimationLimiter(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 5.sp,
                        crossAxisCount: 1),
                    physics: BouncingScrollPhysics(),
                    children: hrServices.entries.map(
                      (entry) {
                        index++;
                        return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 600),
                            columnCount: 2,
                            child: ScaleAnimation(
                                child: FadeInAnimation(
                                    child: MyCard(
                              title: entry.key.keys.first,
                              desc: entry.key.values.first,
                              icon: entry.value.values.first,
                              subTitle: entry.value.keys.first,
                              chips: chipListHR[index],
                              onTap: () {
                                openHRService(title: entry.key.keys.first);
                              },
                            ))));
                      },
                    ).toList(),
                  ),
                ),
              )),
          Positioned(
            top: Get.height * 0.065,
            left: 8.w,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            top: Get.height * 0.07,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorPrimary,
                ),
                child: Text(
                  'الموارد البشرية',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openHRService({required String title}) {
    switch (title) {
      case 'الدورات التدريبية':
        showLoadingOverlay(
            asyncFunction: (() async => getCourses(userID: userID)));
        break;
      case 'الشهادات العلمية':
        showLoadingOverlay(
            asyncFunction: (() async => getQualifications(userID: userID)));
        break;
      case 'مسير الرواتب':
        showLoadingOverlay(
            asyncFunction: (() async => getEmpPayroll(userID: userID)));
        break;
      case 'كشف العهد':
        showLoadingOverlay(
            asyncFunction: (() async => getCovenants(userID: userID)));

        break;
      case 'القرارات المعتمدة':
        showLoadingOverlay(
            asyncFunction: (() async => getEmpDecisions(userID: userID)));
        break;
      case 'استعلام عن الطلبات':
        showLoadingOverlay(
            asyncFunction: (() async => getRequestStatus(userID: userID)));

        break;

      case 'الحضور والإنصراف':
        showLoadingOverlay(
            asyncFunction: (() async => getEmpLeaveRequest(userID: userID)));

        break;
      case 'طلبات الاستئذان':
        showLoadingOverlay(
            asyncFunction: (() async => getEmpAttendance(userID: userID)));

        break;
      case 'تعريف الراتب':
        showLoadingOverlay(
            asyncFunction: (() async => getEmpSalary(userID: userID)));
        break;
    }
  }
}

void getQualifications({required String userID}) async {
  APIController controller = APIController(
      url:
          "https://mobileapi.nbu.edu.sa/api/NBUExternalApi/GetEmpQualifications?nid=$userID");
  await controller.getData();
  if (controller.data == null ||
      controller.data == "null" ||
      controller.data == []) {
    Get.to(() => Qualifications(qualifications: const []));
  } else {
    Get.to(() => Qualifications(qualifications: controller.data));
  }
}

void getCourses({required String userID}) async {
  APIController controller = APIController(
      url:
          "https://mobileapi.nbu.edu.sa/api/NBUExternalApi/GetEmpCourse?nid=$userID");
  await controller.getData();
  if (controller.data == null ||
      controller.data == "null" ||
      controller.data == []) {
    Get.to(() => Courses(courses: const []));
  } else {
    ((controller.data) as List)
        .sort((a, b) => a['courseDate'].compareTo(b['courseDate']));
    Get.to(() => Courses(courses: controller.data));
  }
}

//Retrieve employee covenant data
void getCovenants({required String userID}) async {
  APIController controller = APIController(
      url:
          "https://mobileapi.nbu.edu.sa/api/NBUExternalApi/GetEmpCustody?nid=$userID");
  await controller.getData();
  if (controller.data == null ||
      controller.data == "null" ||
      controller.data == []) {
    Get.to(() => Covenants(covenants: const []));
  } else {
    Get.to(() => Covenants(covenants: controller.data));
  }
}

//Retrieve employee Payroll data
void getEmpPayroll({required String userID}) async {
  APIController controller = APIController(
      url:
          "https://mobileapi.nbu.edu.sa/api/NBUExternalApi/GetEmployeeePayrollInfo?nid=$userID");
  await controller.getData();
  if (controller.data == null ||
      controller.data == "null" ||
      controller.data == []) {
    Get.to(() => Payrolls(payrolls: const []));
  } else {
    Get.to(() => Payrolls(payrolls: controller.data));
  }
}

//Retrieve employee Leave Requests data
void getEmpLeaveRequest({required String userID}) async {
  APIController controller = APIController(
      url:
          "https://mobileapi.nbu.edu.sa/api/NBUExternalApi/GetEmpLeaveRequest?nid=$userID");
  await controller.getData();
  if (controller.data == null ||
      controller.data == "null" ||
      controller.data == []) {
    Get.to(() => LeaveRequests(requests: const []));
  } else {
    ((controller.data) as List)
        .sort((a, b) => a['leaveDate'].compareTo(b['leaveDate']));
    Get.to(() => LeaveRequests(requests: controller.data));
  }
}

//Retrieve employee Attendance data
void getEmpAttendance({required String userID}) async {
  APIController controller = APIController(
      url:
          "https://mobileapi.nbu.edu.sa/api/NBUExternalApi/GetEmployeeAttendance?nid=$userID");
  await controller.getData();
  if (controller.data == null ||
      controller.data == "null" ||
      controller.data == []) {
    Get.to(() => Attendances(attendances: const []));
  } else {
    Get.to(() => Attendances(attendances: controller.data));
  }
}

//Retrieve employee Approved Decisions data
void getEmpDecisions({required String userID}) async {
  APIController controller = APIController(
      url:
          "https://mobileapi.nbu.edu.sa/api/NBUExternalApi/EmployeeDecisions?nid=$userID");
  await controller.getData();
  if (controller.data == null ||
      controller.data == "null" ||
      controller.data == []) {
    Get.to(() => Decisions(decisions: const []));
  } else {
    Get.to(() => Decisions(decisions: controller.data));
  }
}

//Retrieve employee Status Request data
void getRequestStatus({required String userID}) async {
  APIController controller = APIController(
      url: //1071734295
          "https://mobileapi.nbu.edu.sa/api/NBUExternalApi/EmployeeOrders?nid=$userID");
  await controller.getData();
  if (controller.data == null ||
      controller.data == "null" ||
      controller.data == []) {
    Get.to(() => RequestStatus(requests: const []));
  } else {
    Get.to(() => RequestStatus(requests: controller.data));
  }
}

//Retrieve employee Salary data
void getEmpSalary({required String userID}) async {
  // String selected = salaryTypes[0];
  APIController controller = APIController(
      url:
          "https://mobileapi.nbu.edu.sa/api/NBUExternalApi/GetSalaryDefinition?nid=$userID");
  await controller.getData();
  if (controller.data == null ||
      controller.data == "null" ||
      controller.data == []) {
    CustomSnackBar.showCustomErrorSnackBar(
        title: 'لا يوجد بيانات',
        message: 'الرجاء التحقق من بوابة الخدمة الذاتية');
  } else {
    SalaryDefinition salaryDefinition =
        SalaryDefinition.fromJson(controller.data[0]);

    Get.defaultDialog(
      title: 'نموذج الطباعه',
      confirm: CustomButton(
        callBack: () async {
          // if(data['nationality'] != 'سعودي' && selected == salaryTypes[1]){
          // if (data['years'] < 5) return; }

          pdf.Document pdfile = await createPDF(
              nationality: salaryDefinition.nationalityName ?? '',
              salaryDefinition: salaryDefinition);
          Uint8List binary = await pdfile.save();
          String dateTime = DateTime.now().microsecondsSinceEpoch.toString();
          final qr = await generateQRCode("$userID/$dateTime");
          pdfile = await createPDF(
              // selected: selected,
              nationality: salaryDefinition.nationalityName ?? '',
              salaryDefinition: salaryDefinition,
              qr: qr);
          binary = await pdfile.save();
          final output = await getDownloadsDirectory();
          final file = File('${output!.path}/salary.pdf');
          await file.writeAsBytes(binary);
          await OpenAppFile.open(
            file.path,
          );
        },
        label: '   عرض   ',
        fontSize: 14.sp,
        padding: 8.sp,
      ),
      content: Center(
        child: Text('نموذج طباعه شهادة تعريف الراتب'),
      ),
      // content: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15),
      //   ),
      //   margin: const EdgeInsets.all(8.0),
      //   height: 100,
      //   child: GetBuilder<SalaryTypeController>(
      //     init: SalaryTypeController(),
      //     builder: (salaryType) => DropdownButtonHideUnderline(
      //       child: DropdownButtonFormField(
      //           items: salaryTypes
      //               .map(
      //                 (type) => DropdownMenuItem(
      //                     value: type,
      //                     alignment: Alignment.center,
      //                     child: Text(type)),
      //                 //Text(salaryTypes.indexOf(type) == 2 ? "$typeمفصل" : type)),
      //               )
      //               .toList(),
      //           elevation: 15,
      //           decoration: InputDecoration(
      //             border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(50),
      //               borderSide: BorderSide.none,
      //             ),
      //           ),
      //           value: salaryType.type,
      //           hint: Text('نموذج الطباعه'),
      //           onChanged: (newType) {
      //             salaryType.changeType(newType.toString());
      //             selected = newType.toString();
      //           }),
      //     ),
      //   ),
      // ),
    );
  }
}
