import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/term_course.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/academic/schedule.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class TermCourseDetails extends StatelessWidget {
  final TermCourse termCourse;
  const TermCourseDetails({super.key, required this.termCourse});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.15, left: 8.w, right: 8.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      color: Color(
                        int.parse(
                          termCourse.category!.color!.replaceFirst('#', '0xff'),
                        ),
                      ),
                      margin: EdgeInsets.all(8.sp),
                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      shadowColor: Color(0xff9ab83d),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 27.h),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(height: 4.h),
                                  CustomRow(
                                    title: ' المجال: ',
                                    trailing:
                                        termCourse.category?.arabicName ?? '',
                                  ),
                                  // buildLine(),
                                  CustomRow(
                                    title: ' عدد الساعات : ',
                                    trailing: termCourse.hours.toString(),
                                  ),
                                  // buildLine(),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 16.w),
                                        child: Text(
                                          'المستويات:',
                                          style: TextStyle(
                                            color: colorPrimary,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Wrap(
                                          children: termCourse.levels!
                                              .map((level) => Chip(
                                                    padding: EdgeInsets.zero,
                                                    label: Text(
                                                      ' ${level.arabicName} ',
                                                      style: TextStyle(
                                                          fontSize: 8.sp),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // buildLine(),
                                  CustomRow(
                                    title: ' تاريخ البداية :  ',
                                    trailing: termCourse.fromDate ?? '',
                                  ),
                                  // buildLine(),
                                  CustomRow(
                                    title: ' تاريخ الإنتهاء :  ',
                                    trailing: termCourse.toDate ?? '',
                                  ),
                                  // buildLine(),
                                  if (termCourse.beforeUndoDays! &&
                                      termCourse.registeredBefore!)
                                    CustomButton(
                                        callBack: requestLeave,
                                        label: 'إنسحاب',
                                        padding: 8,
                                        fontSize: 16,
                                        color: Colors.red),
                                  if (!termCourse.maximumCapacity! &&
                                      !termCourse.registeredBefore!)
                                    CustomButton(
                                      callBack: requestJoin,
                                      label: 'طلب الإنضمام',
                                      padding: 8,
                                      fontSize: 16,
                                    ),
                                  SizedBox(height: 8.h),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.sp),
                            child: Center(
                              child: Text(
                                'الإنضمام',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      color: Color(
                        int.parse(
                          termCourse.category!.color!.replaceFirst('#', '0xff'),
                        ),
                      ),
                      margin: EdgeInsets.all(8.sp),
                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      shadowColor: Color(0xff9ab83d),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 30.h),
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(8.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('الوصف :',
                                      style: TextStyle(
                                        color: colorPrimary,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Padding(
                                    padding: EdgeInsets.all(8.sp),
                                    child: HtmlWidget(
                                      termCourse.description ?? '',
                                    ),
                                  ),
                                  // buildLine(),
                                  Text('تفاصيل الدورة :',
                                      style: TextStyle(
                                        color: colorPrimary,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  CustomRow(
                                    title: ' نوع الحضور :  ',
                                    trailing:
                                        termCourse.attendance!.arabicName ?? '',
                                  ),
                                  // buildLine(),
                                  Text(' المحاضرين :  ',
                                      style: TextStyle(
                                        color: colorPrimary,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Column(
                                      children: termCourse.termInstructors!
                                          .map(
                                            (instractor) => Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  instractor.arabicName ?? '',
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: colorLightGreen,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList()),
                                  // buildLine(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 4.sp),
                                        child: Text('المواعيد :',
                                            style: TextStyle(
                                              color: colorPrimary,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      ...termCourse.termSchedules!.map(
                                        (schedule) => Center(
                                          child: Text(
                                            '${schedule.arabicName ?? ''} ${schedule.fromTime ?? ''} - ${schedule.toTime ?? ''}',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(6.sp),
                            child: Center(
                              child: Text(
                                termCourse.course!.arabicName ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                      termCourse.course!.arabicName!.length > 17
                                          ? FontWeight.w900
                                          : FontWeight.bold,
                                  fontSize:
                                      termCourse.course!.arabicName!.length > 35
                                          ? 12.sp
                                          : 14.sp,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: Get.height * 0.065,
              left: 4.w,
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
                    'تفاصيل الدورة',
                    style: largeTitleStyle.copyWith(color: colorWhite),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  void requestJoin() {
    showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getSkillsRecordToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
          url:
              "https://mahari.nbu.edu.sa/api/Student/RegisterOnTermCourse?id=${termCourse.id}",
          requestType: RequestType.post,
          headers: {
            'Authorization': headers,
          });
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        Get.back();
        CustomSnackBar.showCustomSnackBar(
            title: 'نجاح', message: 'تم الإنضمام بنجاح');
      } else {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'فشل', message: controller.data['arabicMessage']);
      }
    });
  }

  void requestLeave() {
    showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getSkillsRecordToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
          url:
              "https://mahari.nbu.edu.sa/api/Student/UndoRegisterOnTermCourse?id=${termCourse.id}",
          requestType: RequestType.post,
          headers: {
            'Authorization': headers,
          });
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        Get.back();
        CustomSnackBar.showCustomSnackBar(
            title: 'نجاح', message: 'تم الإنسحاب بنجاح');
      } else {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'فشل', message: controller.data['arabicMessage']);
      }
    });
  }
}
