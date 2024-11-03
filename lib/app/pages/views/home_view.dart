import 'dart:convert';
import 'package:eservices/app/components/home_body.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/bottom_navbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/users/student.dart';
import 'package:eservices/app/data/models/users/user.dart';
import 'package:upgrader/upgrader.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData = MySharedPref.getUserData();
    String userType = userData['userType'];
    dynamic user = userType == "student"
        ? Student.fromJson(userData['user'])
        : User.fromJson(userData['user']);
    dynamic image =
        userType == "student" ? null : base64Decode(userData['image']);
    dynamic userID =
        userType == "student" ? user.nid : user.assignmentCivilRecordNumber!;

    return Scaffold(
      bottomNavigationBar: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
          return buildBottomNavBar(
            controller: homeController,
            firstLabel: 'الرئيسية',
            secondlabel: 'الملف الشخصي',
            thirdLabel: 'الاعدادات',
            firstIcon: FontAwesomeIcons.house,
            secondIcon: FontAwesomeIcons.user,
            thirdIcon: FontAwesomeIcons.gear,
          );
        },
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) => Stack(
          children: [
            HomeBody(
              image: image,
              user: user,
              userID: userID,
              userType: userType,
              index: homeController.index,
            ),
            UpgradeAlert(
              dialogStyle: UpgradeDialogStyle.cupertino,
              showIgnore: false,
              showReleaseNotes: false,
              upgrader: Upgrader(
                languageCode: 'ar',
                messages: UpgraderMessages(
                  code: 'ar',
                ),
              ),
              showLater: false,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeController extends GetxController {
  int index = 0;

  void changeIndex(int newValue) {
    index = newValue;
    update();
  }
}
