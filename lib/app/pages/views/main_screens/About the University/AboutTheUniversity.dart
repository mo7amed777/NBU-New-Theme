import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import 'MoreAboutTheUniversity.dart';

class AboutTheUniversity extends StatefulWidget {
  const AboutTheUniversity({Key? key}) : super(key: key);

  @override
  State<AboutTheUniversity> createState() => _AboutTheUniversityState();
}

class _AboutTheUniversityState extends State<AboutTheUniversity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Appbar(title: 'عن الجامعة'),
          Stack(
            children: [
              Card(
                elevation: 0.0,
                margin: EdgeInsets.all(8.sp),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 32.h,
                    right: 8.w,
                    left: 8.w,
                    top: 8.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Text('نبذه عن الجامعة'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorPrimary,
                                fontSize: 16.sp)),
                      ),
                      Text(
                        'تتمتع جامعة الحدود الشمالية بموقعها الجغرافي الفريد الذي تبوأته بميدان التعليم العالي بالمملكة العربية السعودية كَوْنُهَا الجامعةَ الوحيدةَ بمنطقة الحدود الشمالية في شمال المملكة العربية السعودية، ولهذا تحمل الجامعة اسم هذه المنطقة الغالية من مناطق المملكة. وتستفيد في بناء خططها من قيم المنطقة الغنية، وثقافتها، وتاريخها، وموقعها. كما تنسجم خطتنا الإستراتيجية للأعوام 2020- 2025  مع ما تزخر به المنطقة من موارد طبيعية، وتتفق أيضاً مع رؤية المملكة 2030، و مع نظام الجامعات الجديد مسترشدة بالأولويات الإستراتيجية لإمارة منطقة الحدود الشمالية.​',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: colorBlackLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16.w,
                bottom: 12.h,
                child: InkWell(
                  onTap: () => Get.to(MoreAboutTheUniversity.new),
                  child: Row(
                    children: [
                      Text(
                        'المزيد'.tr,
                        style: TextStyle(
                            color: colorPrimaryLight,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp),
                      ),
                      Icon(
                        Icons.keyboard_double_arrow_left,
                        color: colorPrimaryLight,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w, top: 16.h),
            child: Text('تاريخ الجامعة'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorPrimary,
                  fontSize: 20.sp,
                )),
          ),
          Timeline(
            physics: NeverScrollableScrollPhysics(),
            iconSize: 25.sp,
            lineColor: colorBlackLight,

            shrinkWrap: true,
            //if itemCount increases, u also need to increase the height of the timeline
            children: [
              timelineModel(
                '1402هـ',
                'تأسيس الكلية المتوسطة للبنات، وكانت بمثابة النواة لهذا الصرح الحالي. ',
              ),
              timelineModel(
                '1408هـ',
                "تحويل الكلية المتوسطة للبنات إلى كلية للمعلمين، وتزامن ذلك مع منحها أول درجة بكالوريوس.",
              ),
              timelineModel(
                '1426هـ',
                "تأسيس كلية للعلوم بعرعر، وكلية للمجتمع برفحاء ليكونا فرعين تابعين لجامعة الملك عبد العزيز.",
              ),
              timelineModel(
                '1428هـ',
                "أعلن خادم الحرمين الشريفين الملك عبدالله بن عبد العزيز -رحمه الله- إبَّانَ زيارَتِهِ التاريخية إلى منطقة الحدود الشمالية،  تأسيسَ جامعة الحدود الشمالية بموجب مرسوم ملكي، حيث ضمت كليةُ المعلمين التي تأسست سابقاً إلى جانب فَرْعَيْ جامعة الملك عبدالعزيز بكل من عرعر ورفحاء. كما أعقب تأسيس جامعة الحدود الشمالية مباشرة إنشاء العديد من الكليات الجديدة، التي ضمت كليات الطب، والصيدلة، والتمريض، والعلوم الطبية التطبيقية، والهندسة، وعلوم الحاسوب، وإدارة الأعمال، وكلية المجتمع، التي تَوَزَّعَتْ جميعها حول حرمها الجامعي الرئيسي في عرعر، إلى جانب فروع الجامعة الثلاثة في كل من رفحاء وطريف والعويقيلة. وقد شهدت الجامعة الناشئة فترة تطور سريع، حتى شَكَّلَتْ مِحور تحول رئيسي للمعرفة، والتقدم الاجتماعي، والاقتصادي بالمنطقة ",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

TimelineModel timelineModel(String title, String subtitle) {
  return TimelineModel(
      Card(
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorPrimary,
                        fontSize: 18.sp)),
              ),
              Text(subtitle,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: colorBlackLight,
                      overflow: TextOverflow.fade)),
            ],
          ),
        ),
      ),
      icon: Icon(
        Icons.history,
        color: colorWhite,
      ),
      iconBackground: colorPrimaryLight);
}
