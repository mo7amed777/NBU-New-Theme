import 'package:eservices/app/components/home_body.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/components/services_functions.dart';
import 'package:eservices/config/const.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/academic/schedule.dart';
import 'package:eservices/app/pages/views/academic/timeline.dart';

class Academic extends StatelessWidget {
  String userID;
  List<List<String>> list;
  Academic({required this.userID, required this.list});
  Map<String, dynamic> userData = MySharedPref.getUserData();

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
                  top: Get.height * 0.15, left: 8.w, right: 8.w),
              child: SizedBox(
                child: AnimationLimiter(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 5.sp,
                        crossAxisCount: 1),
                    physics: BouncingScrollPhysics(),
                    children: academicServices.entries.skipWhile((entry) {
                      final keyMap = entry.key;
                      // Extract the first key from the inner Map<String, String>
                      final firstKey = keyMap.entries.first.key;
                      return ((userData['userType'] != "student" &&
                              firstKey == 'السجل المهاري') ||
                          (userData['userType'] != "student" &&
                              userData['userType'] != 'academic' &&
                              firstKey == 'الجدول الدراسي'));
                    }).map(
                      (entry) {
                        index++;

                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          columnCount: 1,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: MyCard(
                                title: entry.key.keys.first,
                                desc: entry.key.values.first,
                                icon: entry.value.values.first,
                                subTitle: entry.value.keys.first,
                                chips: list[index],
                                onTap: () {
                                  openAcademicService(
                                    title: entry.key.keys.first,
                                    userID: userID,
                                    userType: userData['userType'],
                                  );
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
                child: Text(
                  'خدمات أكاديمية',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void getTimeTable(userID, userType) async {
  showLoadingOverlay(asyncFunction: (() async {
    String url =
        "https://mobileapi.nbu.edu.sa/api/BannerExternalApi/GetAcadmicTable?NID=$userID";
    if (userType == 'student') {
      url =
          "https://mobileapi.nbu.edu.sa/api/BannerExternalApi/GetStudentStudingTable?StudentNID=$userID";
    }
    APIController controller = APIController(
      url: url,
    );
    await controller.getData();

    if (controller.data == null ||
        controller.data == "null" ||
        controller.data == []) {
      Get.to(() => Schedule(data: const []));
    } else {
      List returnedCourses = [];
      if (userType == 'student') {
        returnedCourses = controller.data['resultData']['studentTable'];
        Get.to(() => Schedule(data: returnedCourses, isAcademic: false));
      } else {
        returnedCourses = controller.data['teacheR_TABLE_TEMP'];
        Get.to(() => Schedule(data: returnedCourses, isAcademic: true));
      }
    }
  }));
}
