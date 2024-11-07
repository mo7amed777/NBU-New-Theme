import 'dart:io';
import 'package:delta_to_html/delta_to_html.dart';
import 'package:dio/dio.dart' as dio;
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/input_field.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

int deptID = 0,
    requestTypeID = 0,
    serviceID = 0,
    workBesidesID = 0,
    workBeside = 0,
    subWorkBesidesID = 0;
String date = '';
TextEditingController placeController = TextEditingController();

class NewSupportRequest extends StatelessWidget {
  final List workBesides;
  NewSupportRequest({super.key, required this.workBesides});

  TextEditingController titleController = TextEditingController();
  QuillController notesController = QuillController.basic();
  List<File> attatchments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.15, left: 10.w, right: 10.w),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: Card(
                elevation: 0.0,
                margin: EdgeInsets.all(8.sp),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)
                      // Adjust the bottom right border radius
                      ),
                  side: BorderSide(
                    color: Color(
                        0xff337c3d), // Change this color to the desired border color
                    // Change this value to the desired border width
                  ),
                ),
                shadowColor: Color(0xff9ab83d),
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RequestWorkBesideDropdown(),
                        SizedBox(height: 10.h),
                        WorkBesidesDropdown(workBesides: workBesides),
                        SizedBox(height: 10.h),
                        InputField(
                          label: 'عنوان التذكرة',
                          hint: 'ادخل عنوان التذكرة',
                          controller: titleController,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10.h),
                        QuillSimpleToolbar(
                          controller: notesController,
                          configurations: QuillSimpleToolbarConfigurations(
                            multiRowsDisplay: false,
                            showRedo: false,
                            showUndo: false,
                          ),
                        ),
                        Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xff337c3d)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: QuillEditor.basic(
                            controller: notesController,
                            configurations: const QuillEditorConfigurations(
                                showCursor: true,
                                expands: false,
                                scrollable: true,
                                maxHeight: 50,
                                padding: EdgeInsets.all(8.0)),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.image,
                                    allowMultiple: true,
                                  );

                                  if (result != null) {
                                    List<File> images = result.paths
                                        .map((path) => File(path!))
                                        .toList();
                                    attatchments.addAll(images);
                                  }
                                },
                                icon: Icon(FontAwesomeIcons.solidImage)),
                            IconButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf'],
                                    allowMultiple: true,
                                  );
                                  if (result != null) {
                                    List<File> pdfs = result.paths
                                        .map((path) => File(path!))
                                        .toList();
                                    attatchments.addAll(pdfs);
                                  }
                                },
                                icon: Icon(FontAwesomeIcons.solidFilePdf)),
                          ],
                        ),
                        Text(
                          '* مسموح فقط (3) مرفقات ولا يتعدى الحجم 3MB *',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          callBack: () {
                            final deltaJson =
                                notesController.document.toDelta().toJson();
                            String notesHtml = DeltaToHTML.encodeJson(
                              List.castFrom(deltaJson),
                            );

                            addRequest(
                              title: titleController.text,
                              place: placeController.text,
                              date: date,
                              notes: notesHtml,
                              deptID: deptID,
                              requestTypeID: requestTypeID,
                              workBesideID: workBesidesID,
                              subWorkBesideID: subWorkBesidesID,
                              serviceID: serviceID,
                              workBeside: workBeside,
                              attachments: attatchments,
                            );
                          },
                          label: 'حفظ',
                          fontSize: 18,
                          padding: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                child: Text(
                  'تذكرة جديدة',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addRequest(
      {required String title,
      required String place,
      required String date,
      required String notes,
      required int deptID,
      required int serviceID,
      required int workBeside,
      required int requestTypeID,
      required int workBesideID,
      required int subWorkBesideID,
      required List<File> attachments}) async {
    await showLoadingOverlay(asyncFunction: () async {
      List<dio.MultipartFile> attatchments = attachments
          .map((file) => dio.MultipartFile.fromFileSync(file.path,
              filename: file.path.split('/').last))
          .toList();
      Map<String, dynamic> data = {
        "Id": '0',
        "Title": title,
        "ExecutionPlace": place,
        "ExecutedDate": date,
        "Notes": notes,
        "ParentWorkBesideId": deptID,
        "RequestTypeId": requestTypeID,
        "WorkBesideId": workBesideID,
        "WorkBesideUserCreateRequestId": workBeside,
        "SubWorkBesideId": subWorkBesideID,
        "Attachment": attatchments,
        "ServiceId": serviceID,
      };
      dio.FormData formData = dio.FormData.fromMap(data);

      APIController controller = APIController(
        url: 'https://crm.nbu.edu.sa/api/Request/AddRequest',
        body: formData,
        requestType: RequestType.post,
      );

      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        Get.back();
        CustomSnackBar.showCustomSnackBar(
            title: 'نجاح', message: 'تم اضافة التذكرة بنجاح');
      }
    });
  }
}

class RequestWorkBesideDropdown extends StatefulWidget {
  const RequestWorkBesideDropdown({super.key});

  @override
  State<RequestWorkBesideDropdown> createState() =>
      _RequestWorkBesideDropdownState();
}

class _RequestWorkBesideDropdownState extends State<RequestWorkBesideDropdown> {
  List requestWorkBesides = [];
  String selectedWorkBeside = 'اختر الجهة';

  @override
  void initState() {
    super.initState();
    fetchRequestWorkBesides();
  }

  void fetchRequestWorkBesides() async {
    APIController controller = APIController(
      url:
          'https://crm.nbu.edu.sa/api/LKPWorkBesideUserCreateRequest/GetWorkBesideUserCreateRequests',
    );
    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success &&
        controller.data['returnObject'] != null) {
      setState(() {
        requestWorkBesides = controller.data['returnObject'];
        requestWorkBesides.insert(
          0,
          {
            'id': '-1',
            'nameAr': 'جهة عمل مقدم التذكرة',
            'nameEn': 'User WorkBeside',
          },
        );
        selectedWorkBeside = requestWorkBesides[0]['id'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      key: Key('request-work-beside'),
      value: selectedWorkBeside,
      isExpanded: true,
      underline: Container(height: 1, color: colorLightGreen),
      items: requestWorkBesides.map<DropdownMenuItem<String>>((workBeside) {
        return DropdownMenuItem<String>(
          value: workBeside['id'].toString(),
          enabled: workBeside['id'] != '-1',
          child: Text(
            workBeside['nameAr'],
            style: TextStyle(
              color: workBeside['id'] != '-1' ? colorPrimary : colorBlackLight,
            ),
          ),
        );
      }).toList(),
      iconEnabledColor: colorBlackLight,
      onChanged: (value) {
        setState(() {
          selectedWorkBeside = value.toString();
          workBeside = int.parse(selectedWorkBeside);
        });

        //fetchRequests(value!, 'type');
      },
    );
  }
}

class WorkBesidesDropdown extends StatefulWidget {
  final List workBesides;
  const WorkBesidesDropdown({super.key, required this.workBesides});

  @override
  _WorkBesidesDropdownState createState() => _WorkBesidesDropdownState();
}

class _WorkBesidesDropdownState extends State<WorkBesidesDropdown> {
  List departments = [],
      sections = [],
      services = [],
      issues = [],
      requestTypes = [];
  bool sectionDropdown = false, issueDropdown = false; // typeDropdown = false;
  bool isExecutedPlaceRequired = false, isExecutedDateRequired = false;
  String selectedDepartment = 'اختر الجهة';
  String selectedSection = 'اختر القسم';
  String selectedIssue = 'الوحدة الأساسية';
  String selectedType = 'اختر النوع';
  String selectedService = 'اختر الخدمة';
  String depNotes = '', secNotes = '', issNotes = ''; // typNotes = '';
  int parentID = 0;

  Future<void> fetchRequests(String requestID, String key) async {
    if (key == 'department') {
      deptID = int.parse(requestID);
      parentID = deptID;
      sectionDropdown = false;
      issueDropdown = false;
      //workBesidesID = int.parse(requestID);
    } else if (key == 'section') {
      issueDropdown = false;
      workBesidesID = int.parse(requestID);
      parentID = workBesidesID;
    } else if (key == 'issue') {
      //typeDropdown = false;
      subWorkBesidesID = int.parse(requestID);
      parentID = subWorkBesidesID;
    }
    // } else if (key == 'type') {
    //   workBesidesID = int.parse(requestID);
    // }

    APIController apicontroller = APIController(
        url:
            'https://crm.nbu.edu.sa/api/WorkBeside/GetWorkBesidesSelectedList?ParentId=$requestID');
    await apicontroller.getData();
    if (apicontroller.apiCallStatus == ApiCallStatus.success &&
        apicontroller.data != null) {
      APIController noteController = APIController(
          url:
              'https://crm.nbu.edu.sa/api/WorkBeside/GetWorkBesideNote?Id=$requestID');
      await noteController.getData();
      if (noteController.apiCallStatus == ApiCallStatus.success &&
          noteController.data['returnObject'] != null) {
        APIController serviceController = APIController(
            url:
                'https://crm.nbu.edu.sa/api/WorkBesideService/GetWorkBesideServiceAfterCheck?WorkBesideId=$parentID&ParentWorkBesideId=$requestID');
        await serviceController.getData();
        if (serviceController.apiCallStatus == ApiCallStatus.success &&
            serviceController.data['returnObject'] != null) {
          setState(() {
            services = serviceController.data['returnObject'];
            services.insert(
              0,
              {
                'id': '-1',
                'serviceId': '-1',
                'nameAr': 'اختر الخدمة',
                'nameEn': 'Select Service',
              },
            );
            selectedService = services[0]['id'].toString();
          });
        }
        APIController typeController = APIController(
          url:
              'https://crm.nbu.edu.sa/api/LKPRequestType/GetRequestTypesAfterCheck?ParentWorkBesideId=$requestID',
        );
        await typeController.getData();
        if (typeController.apiCallStatus == ApiCallStatus.success &&
            typeController.data['returnObject'] != null) {
          setState(() {
            requestTypes = typeController.data['returnObject'];
            requestTypes.insert(
              0,
              {
                'id': '-1',
                'nameAr': 'اختر النوع',
                'nameEn': 'Select Type',
              },
            );
            selectedType = requestTypes[0]['id'].toString();
          });
        }
        setState(() {
          if (key == 'department') {
            depNotes = noteController.data['returnObject'];
            secNotes = '';
            issNotes = '';
            //typNotes = '';
          } else if (key == 'section') {
            secNotes = noteController.data['returnObject'];
            issNotes = '';
            //typNotes = '';
          } else if (key == 'issue') {
            issNotes = noteController.data['returnObject'];
            //typNotes = '';
          }
          // else if (key == 'type') {
          //   typNotes = noteController.data['returnObject'];
          // }
        });
      }

      APIController reqcontroller = APIController(
          url:
              'https://crm.nbu.edu.sa/api/WorkBeside/GetWorkBesidesPalaceAndDateIsRequired?Id=$requestID');
      await reqcontroller.getData();
      if (reqcontroller.apiCallStatus == ApiCallStatus.success &&
          reqcontroller.data != null) {
        setState(() {
          isExecutedDateRequired =
              reqcontroller.data['returnObject']['isExecutedDateRequired'];
          isExecutedPlaceRequired =
              reqcontroller.data['returnObject']['isExecutedPlaceRequired'];
          List requests = apicontroller.data['returnObject'];

          if (requests.isNotEmpty) {
            if (key == 'department') {
              sections = requests;
              sectionDropdown = true;
              requests.insert(
                0,
                {
                  'id': '-1',
                  'workBesideNameAr': 'اختر القسم',
                  'workBesideNameEn': 'Select Section'
                },
              );
              selectedSection = requests[0]['id'];
            } else if (key == 'section') {
              issues = requests;
              issueDropdown = true;
              requests.insert(
                0,
                {
                  'id': '-1',
                  'workBesideNameAr': 'الوحدة الأساسية',
                  'workBesideNameEn': 'Select Main Unit'
                },
              );
              selectedIssue = requests[0]['id'];
            }
            // else if (key == 'issue') {
            //   types = requests;
            //   typeDropdown = true;
            //   requests.insert(
            //     0,
            //     {
            //       'id': '-1',
            //       'workBesideNameAr': 'الوحدة الفرعية',
            //       'workBesideNameEn': 'Select Sub Unit'
            //     },
            //   );
            //   selectedType = requests[0]['id'];
            // }
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    departments = widget.workBesides;
    departments.insert(
      0,
      {
        'id': '-1',
        'workBesideNameAr': 'اختر الجهة',
        'workBesideNameEn': 'Select workbeside'
      },
    );
    selectedDepartment = departments[0]['id'].toString();
    services.insert(
      0,
      {
        'id': '-1',
        'serviceId': '-1',
        'nameAr': 'اختر الخدمة',
        'nameEn': 'Select Service',
      },
    );
    selectedService = services[0]['serviceId'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DropdownButton<String>(
        key: Key('department'),
        value: selectedDepartment,
        isExpanded: true,
        underline: Container(height: 1, color: colorLightGreen),
        items: departments.map<DropdownMenuItem<String>>((request) {
          return DropdownMenuItem<String>(
            value: request['id'].toString(),
            enabled: request['id'] != '-1',
            child: Text(
              request['workBesideNameAr'],
              style: TextStyle(
                color: request['id'] != '-1' ? colorPrimary : colorBlackLight,
                fontSize: 12.sp,
              ),
            ),
          );
        }).toList(),
        hint: Text('اختر الجهة التابعه له :'),
        iconEnabledColor: colorBlackLight,
        onChanged: (value) async {
          selectedDepartment = value.toString();

          fetchRequests(value!, 'department');
        },
      ),
      Text(depNotes,
          style: TextStyle(
            color: colorRed,
            fontSize: 9.sp,
            fontWeight: FontWeight.bold,
          )),
      if (sectionDropdown) ...[
        DropdownButton<String>(
          value: selectedSection,
          key: Key('section'),
          isExpanded: true,
          underline: Container(height: 1, color: colorLightGreen),
          items: sections.map<DropdownMenuItem<String>>((request) {
            return DropdownMenuItem<String>(
              value: request['id'].toString(),
              enabled: request['id'] != '-1',
              child: Text(
                request['workBesideNameAr'],
                style: TextStyle(
                  color: request['id'] != '-1' ? colorPrimary : colorBlackLight,
                  fontSize: 12.sp,
                ),
              ),
            );
          }).toList(),
          iconEnabledColor: colorBlackLight,
          onChanged: (value) {
            selectedSection = value.toString();

            fetchRequests(value!, 'section');
          },
        ),
        Text(secNotes,
            style: TextStyle(
              color: colorRed,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
            )),
      ],
      if (issueDropdown) ...[
        DropdownButton<String>(
          key: Key('issue'),
          value: selectedIssue,
          isExpanded: true,
          underline: Container(height: 1, color: colorLightGreen),
          items: issues.map<DropdownMenuItem<String>>((request) {
            return DropdownMenuItem<String>(
              value: request['id'].toString(),
              enabled: request['id'] != '-1',
              child: Text(
                request['workBesideNameAr'],
                style: TextStyle(
                  color: request['id'] != '-1' ? colorPrimary : colorBlackLight,
                  fontSize: 12.sp,
                ),
              ),
            );
          }).toList(),
          iconEnabledColor: colorBlackLight,
          onChanged: (value) {
            selectedIssue = value.toString();
            if (selectedIssue == '-1') {
              setState(() {});
            } else {
              fetchRequests(value!, 'issue');
            }
          },
        ),
        Text(issNotes,
            style: TextStyle(
              color: colorRed,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
            )),
      ],
      SizedBox(height: 10.h),
      DropdownButton<String>(
        key: Key('serviceType'),
        value: selectedService,
        isExpanded: true,
        underline: Container(height: 1, color: colorLightGreen),
        items: services.map<DropdownMenuItem<String>>((service) {
          return DropdownMenuItem<String>(
            value: service['serviceId'].toString(),
            enabled: service['serviceId'] != '-1',
            child: Text(
              service['nameAr'],
              style: TextStyle(
                color: service['serviceId'] != '-1'
                    ? colorPrimary
                    : colorBlackLight,
              ),
            ),
          );
        }).toList(),
        iconEnabledColor: colorBlackLight,
        onChanged: (value) {
          setState(() {
            selectedService = value.toString();
            serviceID = int.parse(selectedService);
          });

          //fetchRequests(value!, 'type');
        },
      ),
      if (selectedDepartment != '-1') ...[
        SizedBox(height: 10.h),
        DropdownButton<String>(
          key: Key('request-type'),
          value: selectedType,
          isExpanded: true,
          underline: Container(height: 1, color: colorLightGreen),
          items: requestTypes.map<DropdownMenuItem<String>>((requestType) {
            return DropdownMenuItem<String>(
              value: requestType['id'].toString(),
              enabled: requestType['id'] != '-1',
              child: Text(
                requestType['nameAr'],
                style: TextStyle(
                  color: requestType['id'] != '-1'
                      ? colorPrimary
                      : colorBlackLight,
                ),
              ),
            );
          }).toList(),
          hint: Text('اختر نوع الطلب'),
          iconEnabledColor: colorBlackLight,
          onChanged: (value) {
            selectedType = value.toString();
            requestTypeID = int.parse(selectedType);

            setState(() {});
          },
        ),
      ],
      SizedBox(height: 10.h),
      if (isExecutedPlaceRequired)
        InputField(
          label: 'مكان التنفيذ',
          hint: 'ادخل مكان التنفيذ',
          controller: placeController,
          keyboardType: TextInputType.streetAddress,
        ),
      SizedBox(height: 10.h),
      if (isExecutedDateRequired)
        SizedBox(
          height: 100.h,
          width: Get.width,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            backgroundColor: colorWhite,
            mode: CupertinoDatePickerMode.dateAndTime,
            dateOrder: DatePickerDateOrder.dmy,
            onDateTimeChanged: (selectedDate) async {
              date = selectedDate.toString();
            },
          ),
        ),
    ]);
  }
}
