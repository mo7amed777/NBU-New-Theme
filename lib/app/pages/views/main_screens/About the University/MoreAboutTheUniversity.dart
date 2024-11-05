import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/ContactUS.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/FactsandFigures.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/UniversityCouncil.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/VisionandGoals.dart';
import 'package:eservices/config/const.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MoreAboutTheUniversity extends StatefulWidget {
  const MoreAboutTheUniversity({Key? key}) : super(key: key);

  @override
  State<MoreAboutTheUniversity> createState() => _MoreAboutTheUniversityState();
}

class _MoreAboutTheUniversityState extends State<MoreAboutTheUniversity> {
  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Scaffold(
      backgroundColor: colorWhite,
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
                    children: aboutUniversity.entries.map(
                      (entry) {
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
                              chips: chipAboutUniversity[index++],
                              onTap: () {
                                callBack(entry.key.keys.first);
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
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colorPrimary,
                ),
                child: Text(
                  'المزيد عن الجامعة',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void callBack(String key) async {
    switch (key) {
      case 'الرؤية والرسالة والأهداف':
        Get.to(() => VisionandGoals(title: 'الرؤية والرسالة والأهداف'));
        break;
      case 'مجلس الجامعة':
        Get.to(() => UniversityCouncil(title: 'مجلس الجامعة'));
        break;
      case 'المرصد الجامعي':
        Get.to(() => FactsandFigures(title: 'المرصد الجامعي'));
        break;
      case 'اتصل بنا':
        Get.to(() => ContactUS());
        break;
    }
  }
}
