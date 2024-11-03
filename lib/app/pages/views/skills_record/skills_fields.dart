import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/skills_record/field_details.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SkillsRecordCourses extends StatelessWidget {
  SkillsRecordCourses({required this.courses});
  final List courses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          courses.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/no-data.gif'),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'لا يوجد لديك دورات',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 25.sp,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.15, left: 8.w, right: 8.w),
                  child: SizedBox(
                    height: Get.height,
                    child: AnimationLimiter(
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.0, crossAxisCount: 2),
                        physics: BouncingScrollPhysics(),
                        children: List.generate(
                          courses.length,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              columnCount: 2,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: HRCard(
                                    title: courses[index]['arabicName'],
                                    color: courses[index]['color']
                                        .toString()
                                        .replaceFirst('#', '0xff'),
                                    callBack: () => Get.to(
                                      FieldDetails(
                                        id: courses[index]['id'],
                                        title: courses[index]['arabicName'],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorPrimary,
                ),
                child: Text(
                  'اختر المجال',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget HRCard(
          {required String title,
          required String color,
          required Function callBack}) =>
      Card(
          margin: EdgeInsets.all(8.sp),
          color: Color(int.parse(
              color)), // Change this color to the desired background color
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0), // Adjust the top left border radius
              // Adjust the bottom right border radius
            ),
            side: BorderSide(
              color: Color(int.parse(
                  color)), // Change this color to the desired border color
              width: 1.0, // Change this value to the desired border width
            ),
          ),
          shadowColor: Color(0xff9ab83d),
          child: InkWell(
            onTap: () => callBack(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.w),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.h,

                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(
                              0xffd1dfd9), // Change this color to the desired border color
                          width:
                              1.9, // Change this value to the desired border width
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ), // Optional: Add border radius for rounded corners
                      child: Icon(
                        FontAwesomeIcons.bookOpenReader,
                        size: 25.sp,
                        color: Color(int.parse(color)),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(int.parse(color)),
                          fontWeight: title.length > 17
                              ? FontWeight.w900
                              : FontWeight.bold,
                          fontSize: title.length > 17 ? 8.sp : 10.sp,
                          overflow: TextOverflow.fade),
                    ),
                  ],
                ),
              ),
            ),
          ));
}
