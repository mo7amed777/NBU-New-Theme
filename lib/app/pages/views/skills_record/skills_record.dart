import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/skills_record/completed_courses.dart';
import 'package:eservices/app/pages/views/skills_record/skills_fields.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/config/const.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SkillsRecord extends StatelessWidget {
  final String userID;
  SkillsRecord({super.key, required this.userID});

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
                height: Get.height,
                child: AnimationLimiter(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 5.sp,
                        crossAxisCount: 1),
                    physics: BouncingScrollPhysics(),
                    children: skillsRecordServices.entries.map(
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
                                onTap: () {
                                  openSkillService(
                                    title: entry.key.keys.first,
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
                  'السجل المهاري',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openSkillService({required String title}) {
    switch (title) {
      case 'الدورات':
        showLoadingOverlay(asyncFunction: (() async => getCourses()));
        break;

      case 'جدول السجل المهاري':
        showLoadingOverlay(asyncFunction: (() async => getRecordTable()));
        break;
      case 'الدورات المكتملة':
        showLoadingOverlay(
            asyncFunction: (() async => getCompletedCourses(true)));
        break;
      case 'الدورات الغير المكتملة':
        showLoadingOverlay(
            asyncFunction: (() async => getCompletedCourses(false)));
        break;
    }
  }

  void getCourses() async {
    String token = MySharedPref.getSkillsRecordToken();
    var headers = 'Bearer $token';
    APIController controller = APIController(
        url: "https://mahari.nbu.edu.sa/api/Lookups/GetAllCategories",
        headers: {'Authorization': headers});

    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success &&
        controller.data['returnObject'] != null) {
      Get.to(
          () => SkillsRecordCourses(courses: controller.data['returnObject']));
    }
  }

  void getCompletedCourses(bool isCompleted) async {
    String token = MySharedPref.getSkillsRecordToken();
    var headers = 'Bearer $token';
    APIController controller = APIController(
        url:
            "https://mahari.nbu.edu.sa/api/Student/GetMyCourse?isCompeleted=$isCompleted",
        headers: {'Authorization': headers});

    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success &&
        controller.data['returnObject'] != null) {
      Get.to(() => CompletedCourses(
          courses: controller.data['returnObject'], isCompleted: isCompleted));
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'خطأ', message: controller.data['arabicMessage']);
    }
  }

  void getRecordTable() async {
    final url = 'https://mahari.nbu.edu.sa/vertify-skill-record/$userID';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'خطأ', message: 'خطأ في الاتصال بالانترنت');
    }
  }
}
