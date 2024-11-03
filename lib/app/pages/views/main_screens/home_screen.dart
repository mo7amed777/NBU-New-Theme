import 'package:eservices/app/pages/views/main_screens/About%20the%20University/AboutTheUniversity.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/ContactUS.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/Administration/administration_sections.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 6),
              child: Appbar(
                title: 'الصفحة الرئيسية'.tr,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: _buildDashboardGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      {Widget? icon, String? label, required Function callback}) {
    return InkWell(
      onTap: () => callback(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: colorPrimary,
              child: icon,
            ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Text(
                label!,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardGrid() {
    return GridView.count(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 8.h,
      ),
      crossAxisSpacing: 5,
      childAspectRatio: 16 / 9,
      crossAxisCount: 1,
      mainAxisSpacing: 10.h,
      children: [
        _buildButton(
          icon: Icon(
            FontAwesomeIcons.buildingColumns,
            size: 30.sp,
            color: colorWhiteLight,
          ),
          label: 'إدارة الجامعة',
          callback: () {
            Get.to(Administrations());
          },
        ),
        _buildButton(
          icon: Icon(
            FontAwesomeIcons.message,
            size: 30.sp,
            color: colorWhiteLight,
          ),
          label: 'عن الجامعة'.tr,
          callback: () {
            Get.to(AboutTheUniversity());
          },
        ),
        _buildButton(
          icon: Icon(
            FontAwesomeIcons.phoneFlip,
            size: 30.sp,
            color: colorWhiteLight,
          ),
          label: 'اتصل بنا'.tr,
          callback: () {
            Get.to(ContactUS());
          },
        ),
      ],
    );
  }
}
