import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/list_items.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/list_tile.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisionandGoals extends StatefulWidget {
  final String title;
  const VisionandGoals({required this.title});

  @override
  State<VisionandGoals> createState() => _VisionandGoalsState();
}

class _VisionandGoalsState extends State<VisionandGoals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Appbar(
              title: widget.title,
            ),
          ),
          MyListTile(
            title: 'الرؤية',
            subtitle:
                "نطمح إلى أن نصبح جامعة متميزة،​ذات مصداقية،​تتسم بتقديم برامج اكاديمة قائمة على بناء الكفاءات، والبحث، والابتكار،​ و تقديم خدماتها على مستوى المنطقة و المملكة .",
          ),
          MyListTile(
            title: 'الرسالة',
            subtitle:
                "نحن جامعة شاملة تخدم الأهداف المحلية للمنطقة, مع الالتزام بتحقيق التميز التعليمي . وانطلاقاً من قيمنا الرئيسية​ و تراثنا ​التاريخي و موقعنا الجغرافي , نقدم برامج تعليمية مبتكرة تتسم بمخرجاتها التي تزيد من فعالية الموارد البشرية , والاقتصادية، والثقافية , والطبيعية لمنطقة الحدود الشمالية و خارجها .​",
          ),
          ListItems(
            title: 'الأهداف',
            items: const [
              "تقديم تعليم متميز يعزز الفكر والمهنية",
              "تعزيز بيئة البحث والإبتكار بما يحقق أولويات الجامعة البحثية",
              "تعزيز الشراكة المجتمعية",
              "تطوير نظام إداري ومالي يعزز كفاءة الإدارة وتنويع مصادر الدخل",
            ],
          ),
        ],
      ),
    );
  }
}
