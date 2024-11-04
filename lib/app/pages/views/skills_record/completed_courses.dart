import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:newton_particles/newton_particles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CompletedCourses extends StatelessWidget {
  CompletedCourses({required this.courses, required this.isCompleted});
  final List courses;
  final bool isCompleted;
  Widget hrCard = Card();

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
                    SizedBox(height: 32.h),
                    Text(
                      isCompleted
                          ? 'ليس لديك دورات مكتملة'
                          : 'ليس لديك دورات غير مكتملة',
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
                  child: SingleChildScrollView(
                    child: Column(
                        children: courses.map(
                      (req) {
                        return Card(
                          color: Color(
                            int.parse(
                              req['category']['color']
                                  .replaceFirst('#', '0xff'),
                            ),
                          ),
                          margin: EdgeInsets.all(8.sp),
                          // Change this color to the desired background color
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  15.0), // Adjust the top left border radius
                              // Adjust the bottom right border radius
                            ),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 30.h),
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 8.h),
                                      CustomRow(
                                        title: ' المجال :  ',
                                        trailing:
                                            req['category']['arabicName'] ?? '',
                                      ),
                                      CustomRow(
                                        title: ' تاريخ البداية :  ',
                                        trailing: req['fromDate'] ?? '',
                                      ),
                                      CustomRow(
                                        title: ' تاريخ الإنتهاء :  ',
                                        trailing: req['fromDate'] ?? '',
                                      ),
                                      if (!isCompleted) ...[
                                        if (req['levels'] != null) ...[
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 16.w),
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
                                                  children: (req['levels']
                                                          as List)
                                                      .map((level) => Chip(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            label: Text(
                                                              level[
                                                                  'arabicName'],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      8.sp),
                                                            ),
                                                          ))
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 16.w),
                                            child: Text(
                                              "المواعيد :",
                                              style: TextStyle(
                                                color: colorPrimary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: (req['termScheduleList']
                                                  as List)
                                              .map(
                                                (term) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${term['dayArabicName']}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: colorPrimary,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.sp,
                                                          overflow:
                                                              TextOverflow.fade,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    4.sp),
                                                        child: Icon(Icons
                                                            .trending_down),
                                                      ),
                                                      Text(
                                                        "${term['fromTime']} - ${term['toTime']}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13.sp,
                                                          overflow:
                                                              TextOverflow.fade,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 16.w),
                                            child: Text(
                                              "الوصف :",
                                              style: TextStyle(
                                                color: colorPrimary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.sp),
                                          child: HtmlWidget(
                                            req['description'] ?? '',
                                          ),
                                        ),
                                      ],
                                      if (isCompleted)
                                        CustomButton(
                                          label: 'إستعراض الشهادة',
                                          fontSize: 18,
                                          padding: 8,
                                          callBack: () {
                                            showLoadingOverlay(
                                                asyncFunction: () async =>
                                                    getCertificate(
                                                        req['certificate']));
                                          },
                                        ),
                                      SizedBox(height: 12.h),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6.sp),
                                child: Center(
                                  child: Text(
                                    req['course']['arabicName'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          req['course']['arabicName'].length >
                                                  17
                                              ? FontWeight.w900
                                              : FontWeight.bold,
                                      fontSize:
                                          req['course']['arabicName'].length >
                                                  35
                                              ? 12.sp
                                              : 14.sp,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                              ),
                              if (isCompleted)
                                SizedBox(
                                  height: Get.height * 0.3,
                                  width: Get.width,
                                  child: Newton(
                                    activeEffects: [
                                      RainEffect(
                                        particleConfiguration:
                                            ParticleConfiguration(
                                          shape: CircleShape(),
                                          size: const Size(8, 8),
                                          color:
                                              const LinearInterpolationParticleColor(
                                            colors: [
                                              Colors.black,
                                              Colors.blue,
                                              Colors.red,
                                              Colors.yellow,
                                              Colors.green,
                                              Colors.purple,
                                              Colors.orange,
                                              Colors.pink,
                                              Colors.brown,
                                              Colors.indigo,
                                            ],
                                          ),
                                        ),
                                        effectConfiguration:
                                            const EffectConfiguration(),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        );
                      },
                    ).toList()),
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
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colorPrimary,
                ),
                child: Text(
                  isCompleted ? 'الدورات المكتملة' : 'الدورات الغير المكتملة',
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

  void getCertificate(String code) async {
    final url = 'https://mahari.nbu.edu.sa/vertify-certificates/$code';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'خطأ', message: 'خطأ في الاتصال بالانترنت');
    }
  }
}
