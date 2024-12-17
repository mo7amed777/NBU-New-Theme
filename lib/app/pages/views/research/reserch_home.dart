import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/users/academic_research.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/research/finance_request/applicant_data.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/config/const.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class Research extends StatelessWidget {
  const Research({super.key, required this.userID});
  final String userID;
  @override
  Widget build(BuildContext context) {
    int index = -1;

    return Scaffold(
      backgroundColor: colorWhite,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
              padding: EdgeInsets.only(
                top: Get.height * 0.15,
                left: 8.w,
                right: 8.w,
              ),
              child: SizedBox(
                height: Get.height,
                child: AnimationLimiter(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 5.sp,
                        crossAxisCount: 1),
                    physics: BouncingScrollPhysics(),
                    children: researchHome.entries.map(
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
                                onTap: () {
                                  if (entry.key.keys.first == 'طلب تمويل') {
                                    getFinanceRequestData();
                                  } else {
                                    getFinanceRequests();
                                  }
                                },
                              ),
                            ),
                          ),
                        );
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
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colorPrimary,
                ),
                child: Center(
                  child: Text(
                    "البحث العلمي",
                    style: largeTitleStyle.copyWith(color: colorWhite),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getFinanceRequestData() async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getResearchToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url: 'https://researchtest.nbu.edu.sa/api/FinanceRequestType/GetAll',
        headers: {'Authorization': headers},
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success &&
          controller.data['returnObject'] != null) {
        List data = controller.data['returnObject'];
        Map<String, dynamic> selectedType = {};
        Get.defaultDialog(
          title: "اختر نوع الطلب",
          content: Column(
            children: [
              StatefulBuilder(
                builder: (context, setState) => Wrap(
                  children: data
                      .map((type) => InkWell(
                            onTap: () {
                              setState(() {
                                if (!selectedType.containsKey(type['id'])) {
                                  selectedType = type;
                                }
                              });
                            },
                            splashColor: colorPrimary,
                            child: Center(
                              child: Card(
                                elevation: 5,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 16.h,
                                ),
                                color: selectedType.isNotEmpty &&
                                        selectedType['id'] == type['id']
                                    ? colorPrimary
                                    : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    type['nameAr'],
                                    style: appSubTextStyle.copyWith(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w800,
                                      color: selectedType.isNotEmpty &&
                                              selectedType['id'] == type['id']
                                          ? colorWhite
                                          : colorBlackLight,
                                    ),
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          confirm: CustomButton(
            padding: 8,
            fontSize: 16,
            callBack: () async {
              if (selectedType.isNotEmpty) {
                //Get.back();
                try {
                  showApplicantData(type: selectedType['id'], headers: headers);
                } catch (e) {
                  CustomSnackBar.showCustomErrorToast(
                      message:
                          'حدث خطأ في الاتصال بالانترنت يرجى المحاولة في وقت لاحق');
                  return;
                }
              } else {
                CustomSnackBar.showCustomErrorToast(message: 'اختر نوع الطلب');
              }
            },
            label: 'تأكيد',
          ),
        );
      }
    });
  }

  void getFinanceRequests() async {}

  void showApplicantData({required int type, required String headers}) async {
    String projectId = '';
    Map<String, dynamic> presidentData = {};

    await showLoadingOverlay(asyncFunction: () async {
      APIController controller = APIController(
        url:
            'https://researchtest.nbu.edu.sa/api/Employee/GetByNid?nid=$userID',
        headers: {'Authorization': headers},
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success &&
          controller.data['returnObject'] != null) {
        AcademicResearch academicResearch =
            AcademicResearch.fromJson(controller.data['returnObject']);
        if (type != 4) {
          controller = APIController(
            url:
                'https://researchtest.nbu.edu.sa/api/FinanceRequest/CreateProjectId?EmpId=${academicResearch.id}&JobCode=${academicResearch.jobCode}&RequestType=${type}',
            headers: {'Authorization': headers},
          );
          await controller.getData();
          if (controller.apiCallStatus == ApiCallStatus.success &&
              controller.data['returnObject'] != null) {
            projectId = controller.data['returnObject'];
          }
        }
        controller = APIController(
          url: type == 4
              ? 'https://researchtest.nbu.edu.sa/api/FinanceRequest/GetScholarshipDepartmentPresidenttData'
              : 'https://researchtest.nbu.edu.sa/api/FinanceRequest/GetPresidentData?Nid=${academicResearch.nid}&SecCode=${academicResearch.sectionCode}&ColCode=${academicResearch.collegeCode}',
          headers: {'Authorization': headers},
        );
        await controller.getData();
        if (controller.apiCallStatus == ApiCallStatus.success &&
            controller.data['returnObject'] != null) {
          presidentData = type == 4
              ? controller.data['returnObject'][0]
              : controller.data['returnObject'];
          Get.to(() => ApplicantData(
                projectId: type == 4 ? '' : projectId,
                presidentData: presidentData,
                userData: academicResearch,
                type: type.toString(),
              ));
        }
      }
    });
  }
}
