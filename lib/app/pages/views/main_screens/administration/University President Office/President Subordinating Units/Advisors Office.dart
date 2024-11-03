import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/list_items.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvisorsOffice extends StatefulWidget {
  final String title;
  const AdvisorsOffice({required this.title});

  @override
  State<AdvisorsOffice> createState() => _AdvisorsOfficeState();
}

class _AdvisorsOfficeState extends State<AdvisorsOffice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Appbar(
              title: widget.title,
            ),
          ),
          MyListTile(
              title: 'الهدف العام:',
              subtitle:
    "تقديم الخدمات الاستشارية لرئيس الجامعة في التخصصات التي تهم الجامعة.",
          ),
          ListItems(
            title: 'المهام:',
            items: const [
              'إعداد خطط نشاطات المكتب ومتابعة تنفيذها بعد اعتمادها.',
              'تسهيل مهمة المستشارين في الحصول على البيانات والمعلومات من الوحدات المختصة.',
           'استقبال التقارير المعدة من المستشارين وطباعتها وتنظيمها وإخراجها تمهيداً لعرضها على رئيس الجامعة.',
           'متابعة عقود المستشارين وإخطار رئيس الجامعة بشأن ما يستجد بشأنها.',
'تنسيق الزيارات وعمل الحجوزات اللازمة للمستشارين بالتنسيق مع الوحدات ذات العلاقة.',
'عرض نتائج تقييم أداء المستشارين كل فترة زمنية وتقديم تقرير الأداء لرئيس الجامعة.',
'صرف مكافآت المستشارين ومتابعة جميع الأمور المالية مع إدارة الشؤون المالية.',
        'تحديد احتياجات المكتب من الموارد البشرية والأجهزة والمواد ومتابعة توفيرها.',
'تحديد الاحتياجات التدريبية لموظفي المكتب لترشيحهم للبرامج التدريبية الملائمة.',
'إعداد تقارير دورية عن نشاطات المكتب وإنجازاته ومقترحات تطوير الأداء فيه.',
'أية مهام أخرى يكلف بها في حدود الاختصاص.',

            ],
          ),
        ],
      ),
    );
  }
}
