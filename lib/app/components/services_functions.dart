import 'dart:async';
import 'dart:convert';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/data/models/users/student.dart';
import 'package:eservices/app/pages/views/academic/schedule.dart';
import 'package:eservices/app/pages/views/majales/majales_home.dart';
import 'package:eservices/app/pages/views/majales/pdf_viewer.dart';
import 'package:eservices/app/pages/views/print_card.dart';
import 'package:eservices/app/pages/views/skills_record/skills_record.dart';
import 'package:eservices/app/pages/views/support_me/support_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/student_event.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/Surveys/surveys.dart';
import 'package:eservices/app/pages/views/graduated_services/graduated_services_home.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void getSurveys({required String userID}) async {
  showLoadingOverlay(asyncFunction: () async {
    Map<String, dynamic> userData = MySharedPref.getUserData();
    var collegeCode, sectionCode;
    Map user = {};
    if (userData['userType'] == 'student') {
      user = userData['user'];
    } else {
      user = jsonDecode(userData['user']);
    }
    if (userData['userType'] != 'student') {
      collegeCode = user['levelOneDepartmentID'];
      sectionCode = user['levelTwoDepartmentID'];
    } else {
      collegeCode = user['collegeCode'];
      sectionCode = user['departmentCode'];
    }
    APIController controller = APIController(
        url: "https://mobileapi.nbu.edu.sa/api/SurveyExternalApi/"
            "GetSurveyPeriod?NID=$userID&title=${userData['userType']}&"
            "collegeCode=$collegeCode&sectionCode=$sectionCode");
    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success) {
      List surveys = controller.data['surveyList'];
      MySharedPref.setSurveyCount(surveys.length);
      Get.to(() => Surveys(surveys: surveys, userData: {
            'NID': controller.data['nid'],
            'TargetTypeId': controller.data['targetTypeId'],
            'Gender': controller.data['genderId'],
            'CollegeCode': controller.data['collegeCode'],
            'SectionCode': controller.data['sectionCode'],
          }));
    }
  });
}

Future<void> getMajales({required String userID}) async {
  showLoadingOverlay(asyncFunction: () async {
    Map<String, dynamic> userData = MySharedPref.getUserData();
    APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/UserLogin?UserId=$userID&Email=${userData['email']}');
    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success &&
        controller.data['returnObject'] != null) {
      MySharedPref.setMajalesToken(controller.data['returnObject']);
      Get.to(() => MajalesHome());
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'خطأ في الاتصال', message: "هذا المستخدم غير موجود");
    }
  });
}

Future<void> scanQRCode() async {
  Get.dialog(
    Stack(
      children: [
        MobileScanner(onDetect: (capture) {
          final Barcode barcode = capture.barcodes.first;
          if (barcode.rawValue != null) {
            String token = MySharedPref.getGraduatedServicesToken();

            var headers = 'Bearer $token';
            int code = int.parse(barcode.rawValue!);
            showLoadingOverlay(asyncFunction: () async {
              APIController controller = APIController(
                url:
                    'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/TakeAttendance',
                requestType: RequestType.post,
                body: {
                  "token": headers,
                  "attendanceId": code,
                  "adminId": 0,
                },
              );
              try {
                await controller.getData();

                if (controller.apiCallStatus == ApiCallStatus.success &&
                    controller.data['success']) {
                  CustomSnackBar.showCustomSnackBar(
                      title: 'نجاح', message: 'تم تسجيل الحضور بنجاح');
                  return;
                } else {
                  CustomSnackBar.showCustomErrorSnackBar(
                      title: 'فشل!',
                      message: controller.data['arabicMessage'] ??
                          'حدث خطأ في التسجيل برجاء إعادة المحاولة');
                  return;
                }
              } catch (e) {
                CustomSnackBar.showCustomErrorSnackBar(
                    title: 'فشل!',
                    message: controller.data['arabicMessage'] ??
                        'حدث خطأ في التسجيل برجاء إعادة المحاولة');
                return;
              }
            });
          }
        }),
        Positioned(
          top: 32.h,
          left: 0.w,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.circleXmark,
              color: Colors.red,
            ),
            onPressed: () => Get.back(),
          ),
        ),
      ],
    ),
  );
}

void getGraduatedServices() async {
  showLoadingOverlay(asyncFunction: () async {
    Map<String, dynamic> userData = MySharedPref.getUserData();
    var loginBody = {
      "nId": userData['encID'],
      "userType": userData['encRole'],
    };

    String abayaCode = '';
    List<Event> invites = [];
    List<Event> relInvites = [];
    List<Map<String, dynamic>> codes = [];

    //Login to GradServices and get Token
    APIController controller = APIController(
      url: 'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/Login',
      requestType: RequestType.post,
      body: loginBody,
    );
    await controller.getData();

    if (controller.apiCallStatus == ApiCallStatus.success &&
        controller.data['returnObject'] != null) {
      String token = controller.data['returnObject']['token'];
      MySharedPref.setGraduatedServicesToken(token);
      var headers = 'Bearer $token';

      if (controller.data['returnObject']['type'] == 2) {
        //Get Invitations For Student
        APIController stdController = APIController(
          url:
              'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/GetInvitationsForStudent?token=$headers',
        );
        await stdController.getData();
        if (stdController.apiCallStatus == ApiCallStatus.success) {
          List returnedInvites = stdController.data['returnObject'];
          if (returnedInvites.isEmpty) {
            CustomSnackBar.showCustomSnackBar(
                message: 'لا يوجد دعوات لحضور الحدث', title: 'لا يوجد');
            return;
          }
          for (var invite in returnedInvites) {
            invites.add(Event.fromJson(invite));
          }
        }

        //Get Basic Info and Abaya QRCode Text
        APIController abaaController = APIController(
          url:
              'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/GetBasicInfo?token=$headers',
        );
        await abaaController.getData();
        if (abaaController.apiCallStatus == ApiCallStatus.success) {
          abayaCode = abaaController.data['returnObject']['abaya'];
        }

        //Get Invitations For Student Relatives
        APIController stdrelController = APIController(
          url:
              'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/GetInvitedInvitationsForStudent?token=$headers',
        );
        await stdrelController.getData();
        if (stdrelController.apiCallStatus == ApiCallStatus.success) {
          List returnedInvites = stdrelController.data['returnObject'];
          for (var invite in returnedInvites) {
            relInvites.add(Event.fromJson(invite));
          }
        }
        //Get QRCodes For Students
        APIController codesController = APIController(
          url:
              'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/GetAllMyQRCodes?token=$headers',
        );
        await codesController.getData();
        if (codesController.apiCallStatus == ApiCallStatus.success) {
          List returnedCodes = codesController.data['returnObject'];
          for (var code in returnedCodes) {
            codes.add(code);
          }
        }

        Get.to(() => GraduatedServices(
              invites: invites,
              relInvites: relInvites,
              codes: codes,
              code: abayaCode,
            ));
      } else {
        scanQRCode();
      }
    } else {
      if (controller.data['message'] == "user not found") {
        CustomSnackBar.showCustomErrorToast(
            message: 'المستخدم غير موجود بنظام الفعاليات!');
      } else {
        CustomSnackBar.showCustomErrorToast(
            message: controller.data['arabicMessage']);
      }
      return;
    }
  });
}

void loginSupportMe({required String userID}) async {
  showLoadingOverlay(asyncFunction: () async {
    Map<String, dynamic> userData = MySharedPref.getUserData();
    APIController controller = APIController(
        url: 'https://crm.nbu.edu.sa/api/Account/LoginSSO',
        requestType: RequestType.post,
        body: {
          "email": userData['encemail'],
          "nid": userData['encID'],
          "role": userData['encRole'],
        });
    // body: {
    //   'email': 'UrrLNFmXvaqMgTDtwhGI7w,,',
    //   'nid': 'y5QL51sVSxtNrXFCpJobAg,,',
    //   'role': 'HvmQH9ie_P6SA5jU9o2oeA,,',
    // });
    try {
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success &&
          controller.data['returnObject'] != null) {
        MySharedPref.setSupportMeToken(
            controller.data['returnObject']['token']);
        Get.to(() => SupportMe(
              chatUserID: controller.data['returnObject']['id'],
              showFromUser: controller.data['returnObject']['isAdmin'] ?? false,
            ));
      } else {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'خطأ في الدخول', message: controller.data['arabicMessage']);
      }
    } catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'خطأ في الدخول', message: 'حدث خطأ في الاتصال يرجى المحاولة');
    }
  });
}

void loginSkillsRecord() async {
  showLoadingOverlay(asyncFunction: () async {
    Map<String, dynamic> userData = MySharedPref.getUserData();
    String nId = userData['encID'];
    String userType = userData['encRole'];

    APIController controller = APIController(
      url:
          'https://mahari.nbu.edu.sa/api/Account/LoginSSO?key1=$nId&key2=$userType',
    );
    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success &&
        controller.data['returnObject'] != null) {
      MySharedPref.setSkillsRecordToken(
          controller.data['returnObject']['token']);

      Get.to(() =>
          SkillsRecord(userID: controller.data['returnObject']['userId']));
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'خطأ في الدخول', message: controller.data['arabicMessage']);
    }
  });
}

int getBranchId(List branches, String branch) {
  for (int i = 0; i < branches.length; i++) {
    if (branches[i]['name'] == branch) {
      return branches[i]['id'];
    }
  }
  return 0;
}

void printCard(Student user) async {
  List bloodTypes = [];
  List branches = [];
  Map userData = {};
  int branchId = 0;
  await showLoadingOverlay(asyncFunction: () async {
    APIController controller = APIController(
      url: "https://apptest2.nbu.edu.sa/api/StudentMobile/GetBloodType",
    );
    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success) {
      bloodTypes = controller.data['returnObject'];
      controller = APIController(
        url:
            "https://apptest2.nbu.edu.sa/api/StudentMobile/GetStudentByNid?nid=${user.nid}",
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        if (controller.data['returnObject'] != null) {
          userData = controller.data['returnObject'];
        } else {
          controller = APIController(
            url: "https://apptest2.nbu.edu.sa/api/StudentMobile/GetBranches",
          );
          await controller.getData();
          if (controller.apiCallStatus == ApiCallStatus.success) {
            branches = controller.data['returnObject'];
            branchId = getBranchId(branches, user.campName!);
          } else {
            CustomSnackBar.showCustomErrorSnackBar(
                title: 'فشل', message: controller.data['arabicMessage']);
            return;
          }
        }
      } else {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'فشل', message: controller.data['arabicMessage']);
        return;
      }

      Get.to(
        PrintCard(branchId: branchId, bloodTypes: bloodTypes, user: userData),
      );
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'فشل', message: controller.data['arabicMessage']);
      return;
    }
  });
}
