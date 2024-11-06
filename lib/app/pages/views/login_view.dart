import 'dart:io';
import 'package:eservices/app/pages/views/main_screens/home_screen.dart';
import 'package:eservices/app/pages/views/webview.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:lottie/lottie.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/users/student.dart';
import 'package:eservices/app/data/models/users/user.dart';
import 'package:eservices/app/routes/app_pages.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:upgrader/upgrader.dart';
import 'package:uuid/uuid.dart';
import '../controllers/api_controller.dart';
import 'package:http/io_client.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  //late AnimationController _iconController;
  // late Animation<double> _iconAnimation;
  //late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    // Initialize GIF controller for the background GIF
    // _videoController =
    //     VideoPlayerController.asset('assets/images/background.mp4',
    //         videoPlayerOptions: VideoPlayerOptions(
    //           mixWithOthers: true,
    //           allowBackgroundPlayback: true,
    //         ));
//    play();

    // Initialize icon animation controller
    // _iconController = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 1),
    // )..repeat(reverse: true); // Loop with reverse for a bouncing effect

    // _iconAnimation = Tween<double>(begin: 0.5, end: 0.9).animate(
    //   CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
    // );
  }

  @override
  void dispose() {
    //  _iconController.dispose();
    // _videoController.dispose();
    super.dispose();
  }

  void _getUserData(
      {required String userID,
      required String userType,
      required String encID,
      required String email,
      required String encEmail,
      required String encRole}) async {
    if (userID.isEmpty || userType.isEmpty) {
      MySharedPref.setIsAuthenticated(false);
      return;
    }

    //User Types => academic contract emp-contract emp-cont emp employee emp-nbu nbu-employee student
    userType = userType.toLowerCase().removeAllWhitespace;
    showLoadingOverlay(asyncFunction: () async {
      APIController controller;
      if (userType == "student") {
        controller = APIController(
            //1106354903
            url:
                'https://mobileapi.nbu.edu.sa/api/NBUExternalApi/GetStudentData?StudentNID=$userID');
        await controller.getData();
        if (controller.data != null && controller.data != "null") {
          Map<String, dynamic> data = controller.data["data"];
          Student student = Student.fromJson(data);
          MySharedPref.setUserData({
            'user': student.toJson(),
            'userType': userType,
            'encID': encID,
            'email': email,
            'encRole': encRole,
            'encemail': encEmail,
          });
          try {
            APIController countController = APIController(
                url: "https://mobileapi.nbu.edu.sa/api/SurveyExternalApi/"
                    "GetSurveyCount?NID=$userID&title=$userType&collegeCode=${student.collegeCode}&sectionCode=${student.departmentCode}");
            await countController.getData();
            if (countController.apiCallStatus == ApiCallStatus.success) {
              MySharedPref.setSurveyCount(controller.data);
            } else {
              MySharedPref.setSurveyCount(0);
            }
            Get.toNamed(Routes.HOME);
          } catch (e) {
            MySharedPref.setSurveyCount(0);
            Get.toNamed(Routes.HOME);
          }
        } else {
          Get.back();
          MySharedPref.setIsAuthenticated(false);
          CustomSnackBar.showCustomErrorSnackBar(
              message: "حدث خطأ في عملية الدخول برجاء المحاولة مرة أخرى!",
              title: 'خطأ في الدخول');
        }
      } else {
        controller = APIController(
            //1001015799 1065516807
            url:
                'https://mobileapi.nbu.edu.sa/api/NBUExternalApi/GetEmpInfo?nid=$userID');
        await controller.getData();
        if (controller.data != null && controller.data != "null") {
          User user = User.fromMap(controller.data);
          MySharedPref.setUserData({
            'user': user.toJson(),
            'userType': userType,
            'email': user.emailAddress,
            'image': user.imageBody ?? "",
            'encID': encID,
            'encRole': encRole,
            'encemail': encEmail,
          });

          APIController countController = APIController(
              url: "https://mobileapi.nbu.edu.sa/api/SurveyExternalApi/"
                  "GetSurveyCount?NID=$userID&title=$userType&collegeCode=${user.levelOneDepartmentID}&sectionCode=${user.levelTwoDepartmentID}");
          await countController.getData();
          if (countController.apiCallStatus == ApiCallStatus.success) {
            MySharedPref.setSurveyCount(countController.data);
          } else {
            MySharedPref.setSurveyCount(0);
          }
          Get.toNamed(Routes.HOME);
        } else {
          MySharedPref.setIsAuthenticated(false);
          CustomSnackBar.showCustomErrorSnackBar(
              message: "حدث خطأ في عملية الدخول برجاء المحاولة مرة أخرى!",
              title: 'خطأ في الدخول');
        }
      }
    });
  }

  void _loginWithSSO() async {
    showLoadingOverlay(asyncFunction: () async {
      String guid = Uuid().v4();
      final connection = HubConnectionBuilder()
          .withUrl(
              'https://ssobasic.nbu.edu.sa/SakrHub?subscriberId=$guid',
              HttpConnectionOptions(
                client: IOClient(
                    HttpClient()..badCertificateCallback = (x, y, z) => true),
                withCredentials: true,
              ))
          .build();

      await connection.start();

      connection.on('ReceiveMessage', (message) async {
        Map<String, String> extractedData = {};

        RegExp regex = RegExp(r'(\w+)=(.*?)(?:&|$)');

        Iterable<RegExpMatch> matches = regex.allMatches(message.toString());
        for (RegExpMatch match in matches) {
          extractedData[match.group(1)!] = match.group(2)!;
        }
        MySharedPref.setIsAuthenticated(true);
        String id = extractedData['id']!;
        String role = extractedData['role']!;
        String encID = extractedData['nId']!;
        String encRole = extractedData['userType']!;
        String email = extractedData['email']!;
        String encEmail = extractedData['encemail']!;
        if (encRole[encRole.length - 1] == ']') {
          encRole = encRole.substring(0, encRole.length - 1);
        }
        await connection.stop();
        Get.back();
        _getUserData(
            userID: id,
            userType: role,
            email: email,
            encEmail: encEmail,
            encID: encID,
            encRole: encRole);
      });

      Get.to(() => WebViewScreen(
          url:
              "https://ssobasic.nbu.edu.sa/api/Login/SSODeeplinkRedirect?subscriberId=$guid"));
    });
  }

  void _loginWithNafath() async {
    showLoadingOverlay(
      asyncFunction: () async {
        String guid = Uuid().v4();
        final connection = HubConnectionBuilder()
            .withUrl(
                'https://ssonafath.nbu.edu.sa/SakrHub?subscriberId=$guid',
                HttpConnectionOptions(
                  client: IOClient(
                      HttpClient()..badCertificateCallback = (x, y, z) => true),
                  withCredentials: true,
                ))
            .build();

        await connection.start();

        connection.on('ReceiveMessage', (message) async {
          Map<String, String> extractedData = {};

          RegExp regex = RegExp(r'(\w+)=(.*?)(?:&|$)');

          Iterable<RegExpMatch> matches = regex.allMatches(message.toString());
          for (RegExpMatch match in matches) {
            extractedData[match.group(1)!] = match.group(2)!;
          }
          MySharedPref.setIsAuthenticated(true);
          String id = extractedData['id']!;
          String role = extractedData['role']!;
          String encID = extractedData['nId']!;
          String encRole = extractedData['userType']!;
          String email = extractedData['email']!;
          String encEmail = extractedData['encemail']!;

          if (encRole[encRole.length - 1] == ']') {
            encRole = encRole.substring(0, encRole.length - 1);
          }
          await connection.stop();
          Get.back();

          _getUserData(
              userID: id,
              userType: role,
              email: email,
              encEmail: encEmail,
              encID: encID,
              encRole: encRole);
        });
        Get.to(() => WebViewScreen(
            url:
                "https://ssonafath.nbu.edu.sa/api/Login/SSODeeplinkRedirect?subscriberId=$guid"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background GIF
          Image.asset(
            'assets/images/back.gif',
            height: Get.height,
            width: Get.width,
            fit: BoxFit.fill,
          ),

          Positioned(
            top: 25.h,
            left: 1,
            right: 1,
            child: Image.asset(
              'assets/images/welcome_text.png',
              height: 95.h,
              width: 95.w,
            ),
          ),

          Positioned(
            bottom: 25.h,
            right: 1,
            left: 1,
            child: Image.asset(
              'assets/images/login_card.png',
              height: Get.height * 0.55,
              width: Get.width,
            ),
          ),
          Positioned(
            top: 140.h,
            right: 1,
            left: 1,
            child: Image.asset(
              'assets/images/logo.png',
              height: 165.h,
              width: 165.w,
            ),
          ),
          Positioned(
            top: Get.height * 0.45,
            right: 1,
            left: 1,
            child: Text(
              'تسجيل الدخول',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorWhite,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'NeoSans',
              ),
            ),
          ),
          buttonJson(
            jsonFile: 'sso',
            bottom: 200.h,
            onTap: () => _loginWithSSO(),
          ),
          buttonJson(
            jsonFile: 'nafath',
            bottom: 135.h,
            onTap: () => _loginWithNafath(),
          ),
          Positioned(
            bottom: 107.h,
            right: 1,
            left: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150.w,
                  child: Divider(
                    color: colorWhite,
                    thickness: 1.sp,
                    indent: 85.w,
                    endIndent: 5.w,
                  ),
                ),
                Text(
                  'أو',
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NeoSans',
                  ),
                ),
                SizedBox(
                  width: 150.w,
                  child: Divider(
                    color: colorWhite,
                    thickness: 1.sp,
                    indent: 5.w,
                    endIndent: 85.w,
                  ),
                ),
              ],
            ),
          ),
          buttonJson(
            jsonFile: 'guest',
            bottom: 40.h,
            onTap: () => Get.to(Home()),
          ),

          UpgradeAlert(
            dialogStyle: UpgradeDialogStyle.cupertino,
            showIgnore: false,
            upgrader: Upgrader(
              languageCode: 'ar',
              messages: UpgraderMessages(
                code: 'ar',
              ),
            ),
            showReleaseNotes: false,
            showLater: false,
          ),
        ],
      ),
    );
  }

  Widget buttonJson(
      {required String jsonFile,
      required double bottom,
      required VoidCallback onTap}) {
    return Positioned(
      bottom: bottom,
      right: 1,
      left: 1,
      child: InkWell(
        onTap: onTap,
        child: Lottie.asset(
          'assets/images/$jsonFile.json',
          height: 55.h,
        ),
      ),
    );
  }
}
