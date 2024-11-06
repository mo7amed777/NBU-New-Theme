import 'dart:typed_data';

import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/bottom_navbar.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/components/services_functions.dart';
import 'package:eservices/app/data/models/users/student.dart';
import 'package:eservices/app/pages/views/academic/academic.dart';
import 'package:eservices/app/pages/views/academic/timeline.dart';
import 'package:eservices/app/pages/views/healthcare/healthcare.dart';
import 'package:eservices/app/pages/views/hr/hr_home.dart';
import 'package:eservices/app/pages/views/main_services.dart';
import 'package:eservices/app/pages/views/profile_screen.dart';
import 'package:eservices/app/pages/views/settings.dart';
import 'package:eservices/config/const.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

List<String> allServices = [];

class HomeBody extends StatelessWidget {
  final String userID;
  final String userType;
  final Uint8List? image;
  final dynamic user;
  final int index;

  HomeBody({
    super.key,
    required this.image,
    required this.user,
    required this.userID,
    required this.index,
    required this.userType,
  });

  // final TextEditingController _searchController = TextEditingController();

  void getAllServices() {
    for (List<String> appService in appServicesChips) {
      for (String service in appService) {
        allServices.add(service);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getAllServices();

    return SingleChildScrollView(
        child: switch (index) {
      0 => Column(
          children: [
            appBarSection(image, user),
            SizedBox(height: 10.h),
            homeContent(),
          ],
        ),
      1 => ProfileScreen(
          user: user,
          userType: userType,
          image: image,
        ),
      2 => Settings(

        ),
      int() => Container(),
    });
  }

  Widget homeContent() {
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(
            title: "الخدمات الرئيسية",
            onViewAll: () => Get.to(MainServices(userID: userID)),
          ),
          SizedBox(height: 5.h),
          servicesCards(userID),
          SizedBox(height: 16.h),
          sectionTitle(
            title: "الخدمات الاكاديمية",
            onViewAll: () => Get.to(Academic(userID: userID)),
          ),
          SizedBox(height: 5.h),
          academicCards(userID, academicServices, false),
          SizedBox(height: 16.h),
          if (userType != "student") ...[
            sectionTitle(
              title: "الموارد البشرية",
              onViewAll: () => Get.to(Hr(userID: userID)),
            ),
            SizedBox(height: 5.h),
            academicCards(userID, hrServices, true),
          ] else ...[
            Text('خدمات أخرى', style: appTextStyle),
            SizedBox(height: 5.h),
            MyCard(
              title: 'طباعة البطاقة',
              subTitle: 'طباعة بطاقة الطالب الجامعي',
              desc: 'طباعة بطاقة بيانات الطالب الجامعي',
              icon: FontAwesomeIcons.solidIdCard,
              chips: const [
                'طباعة',
                'البطاقة',
                'الطالب',
              ],
              onTap: () => printCard(user),
              margin: EdgeInsets.all(8.sp),
              fullWidth: true,
            )
          ],
        ],
      ),
    );
  }

  Widget appBarSection(image, user) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      width: Get.width,
      color: colorPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: image == null
                      ? CircleAvatar(
                          backgroundImage: AssetImage(((user is Student)
                                  ? user.gender == "F"
                                  : user.sexTypeName != "ذكر")
                              ? 'assets/images/female.png'
                              : 'assets/images/male.png'),
                          radius: 30.sp,
                        )
                      : CircleAvatar(
                          backgroundImage: MemoryImage(
                            image,
                          ),
                          radius: 30.sp,
                        ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isMorningDate() ? "صباح الخير " : "مساء الخير ",
                      style: appTextStyle.copyWith(color: colorWhite),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      (user is Student)
                          ? '${user.firstNameAr ?? ''} ${user.midNameAr ?? ''} ${user.lastNameAr ?? ''}'
                          : user?.arabicName ?? "مستخدم غير معروف",
                      style: mediumTitleStyle.copyWith(color: colorWhite),
                    ),
                  ],
                ),
                // Spacer(),
                // IconButton(
                //   onPressed: () {
                //     // Get.to(const NotificationScreen());
                //   },
                //   icon: Icon(
                //     FontAwesomeIcons.solidBell,
                //     color: colorWhite,
                //     size: 20.sp,
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          // GetBuilder<SearchingController>(
          //   init: SearchingController(),
          //   builder: (controller) => Container(
          //     height: 45.h,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         color: colorBlackLighter,
          //       ),
          //       borderRadius: BorderRadius.circular(50).r,
          //     ),
          //     child: Center(
          //       child: TextField(
          //         controller: _searchController,
          //         style: appTextStyle.copyWith(
          //           color: colorWhite,
          //         ),
          //         decoration: InputDecoration(
          //           hintText: " بـحــث",
          //           contentPadding: EdgeInsets.only(right: 12.w, top: 8.h),
          //           hintStyle: appTextStyle.copyWith(
          //             color: colorWhiteLight,
          //           ),
          //           border: InputBorder.none,
          //           suffixIcon: IconButton(
          //             onPressed: () =>
          //                 controller.onSearch(_searchController.text),
          //             icon: Icon(FontAwesomeIcons.magnifyingGlass,
          //                 color: colorWhite, size: 18.sp),
          //           ),
          //         ),
          //         onChanged: (value) =>
          //             controller.onSearch(value, isChanged: true),
          //       ),
          //     ),
          //   ),
          // ),
          // GetBuilder<SearchingController>(
          //     init: SearchingController(),
          //     builder: (controller) => controller.showResults.value
          //         ? ListView.builder(
          //             itemCount: controller.searchList.length,
          //             padding: EdgeInsets.all(8.sp),
          //             shrinkWrap: true,
          //             scrollDirection: Axis.vertical,
          //             itemBuilder: (context, index) => InkWell(
          //               onTap: () => controller
          //                   .onSearchResult(controller.searchList[index]),
          //               child: Padding(
          //                 padding: EdgeInsets.all(8.sp),
          //                 child: Center(
          //                   child: Text(
          //                     controller.searchList[index],
          //                     style: appTextStyle.copyWith(
          //                       color: colorWhite,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //         : SizedBox.shrink())
        ],
      ),
    );
  }

  Widget sectionTitle(
      {required String title, required VoidCallback onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: appTextStyle),
        TextButton(
          onPressed: onViewAll,
          child: Text(
            "عرض الكل",
            style: appSubTextStyle.copyWith(
              color: colorPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget serviceCard(
      {EdgeInsetsGeometry? margin,
      VoidCallback? onTap,
      required String title,
      required IconData icon}) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap, // Use the onTap callback
      child: Container(
        margin: margin ?? EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.all(8.r).copyWith(right: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: colorPrimary.withOpacity(0.1), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   "assets/images/services/$icon.svg",
            //   height: 30.h,
            //   color: colorPrimary,
            // ),
            Icon(icon, size: 25.sp, color: colorPrimary),
            SizedBox(height: 5.h),
            Text(title, style: smallTitleStyle),
            //Text(subTitle, style: appSubTextStyle.copyWith(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget servicesCards(userID) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: services.entries
            .map(
              (entry) => serviceCard(
                title: entry.key,
                icon: entry.value,
                onTap: () {
                  openMainService(title: entry.key, userID: userID);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  bool isMorningDate() {
    final now = DateTime.now();
    if (now.hour < 12) {
      return true;
    } else {
      return false;
    }
  }

  Widget academicCards(userID,
      Map<Map<String, String>, Map<String, IconData>> servicesList, bool isHR) {
    List<List<String>> list = isHR ? chipListHR : chipList;
    int index = 0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: servicesList.entries.map(
          (entry) {
            return MyCard(
              title: entry.key.keys.first,
              desc: entry.key.values.first,
              icon: entry.value.values.first,
              subTitle: entry.value.keys.first,
              chips: list[index++],
              onTap: () {
                if (isHR) {
                  openHRService(title: entry.key.keys.first);
                } else {
                  openAcademicService(title: entry.key.keys.first);
                }
              },
            );
          },
        ).toList(),
      ),
    );
  }

  void openAcademicService({required String title}) {
    switch (title) {
      case 'الفعاليات':
        getGraduatedServices();

        break;
      case 'الجدول الدراسي':
        getTimeTable(userID, userType);
        break;
      case 'التقويم الدراسي':
        Get.to(() => Timeline());
        break;
      case 'السجل المهاري':
        loginSkillsRecord();

        break;
    }
  }

  void openHRService({required String title}) {
    switch (title) {
      case 'الدورات التدريبية':
        showLoadingOverlay(
            asyncFunction: (() async => getCourses(userID: userID)));
        break;
      case 'الشهادات العلمية':
        showLoadingOverlay(
            asyncFunction: (() async => getQualifications(userID: userID)));
        break;
      case 'مسير الرواتب':
        showLoadingOverlay(
            asyncFunction: (() async => getEmpPayroll(userID: userID)));
        break;
      case 'كشف العهد':
        showLoadingOverlay(
            asyncFunction: (() async => getCovenants(userID: userID)));

        break;
      case 'القرارات المعتمدة':
        showLoadingOverlay(
            asyncFunction: (() async => getEmpDecisions(userID: userID)));
        break;
      case 'استعلام عن الطلبات':
        showLoadingOverlay(
            asyncFunction: (() async => getRequestStatus(userID: userID)));

        break;

      case 'الحضور والإنصراف':
        showLoadingOverlay(
            asyncFunction: (() async => getEmpLeaveRequest(userID: userID)));

        break;
      case 'طلبات الاستئذان':
        showLoadingOverlay(
            asyncFunction: (() async => getEmpAttendance(userID: userID)));

        break;
      case 'تعريف الراتب':
        showLoadingOverlay(
            asyncFunction: (() async => getEmpSalary(userID: userID)));
        break;
    }
  }
}

void openMainService({required String title, required String userID}) async {
  switch (title) {
    case 'المجالس واللجان':
      getMajales(userID: userID);
      break;

    case 'المركز الصحي':
      Get.to(HealthCare(userID: userID));
      break;

    case 'خدمة المستفيد':
      loginSupportMe(userID: userID);
      break;

    case 'الإجابة على الإستبيانات':
      getSurveys(userID: userID);
      break;
  }
}

class SearchingController extends GetxController {
  RxBool showResults = false.obs;
  RxList searchList = [].obs;

  void onSearch(String query, {bool isChanged = false}) {
    if (isChanged) {
      searchList.clear();
      showResults.value = false;
    }
    if (query.trim().isNotEmpty) {
      for (String service in allServices) {
        if (service.toLowerCase().contains(query.toLowerCase()) &&
            !searchList.contains(service)) {
          searchList.add(service);
          showResults.value = true;
          update();
        }
      }
    } else {
      showResults.value = false;
      update();
    }
  }

  void onSearchResult(String value) {}
}
