import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/list_items.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelfGeneratedResourcesMonitoringUnit extends StatefulWidget {
  final String title;
  const SelfGeneratedResourcesMonitoringUnit({required this.title});

  @override
  State<SelfGeneratedResourcesMonitoringUnit> createState() =>
      _SelfGeneratedResourcesMonitoringUnitState();
}

class _SelfGeneratedResourcesMonitoringUnitState
    extends State<SelfGeneratedResourcesMonitoringUnit> {
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
              title: 'الهدف العام',
              subtitle:
    "الإشراف على الحسابات المالية للموارد الذاتية لجميع الوحدات التنظيمية في الجامعة التي لديها حسابات مستقلة حسب اللوائح والتعليمات المنظمة.",),
          ListItems(
            title: 'المهام: ',
            items: const [
              "إعداد خطط نشاطات الوحدة ومتابعة تنفيذها بعد اعتمادها.",
            "تنفيذ توصيات اللجنة المالية لإدارة المصروفات من خارج الميزانية العامة للجامعة المتعلقة بآلية الصرف على احتياجات الجامعة.",
"تدقيق ومراجعة إيرادات ومصروفات جميع الحسابات المستقلة في الجامعة في ضوء أسس ومعايير المحاسبة.",
"مراجعة أذون الصرف والقيود المحاسبية اللازمة لإثبات عمليات الصرف والإيراد.",
"تدقيق القوائم المالية والحسابات الختامية وعرضها على رئيس الجامعة.",
"إثبات الملاحظات المالية التي لم يتم تسويتها وإبداء الرأي في معالجتها.",
"تحليل القوائم المالية بشكل دوري لاكتشاف نقاط القوة والضعف ومعرفة الموقف المالي للموارد الذاتية.",
"إبداء الرأي بشأن الاستثمارات التي ترغب الجامعة الدخول بها.",
 "المشاركة في تحديد احتياجات الوحدة من الموارد البشرية والأجهزة والمواد ومتابعة توفيرها.",
"المشاركة في تحديد الاحتياجات التدريبية لموظفي الوحدة لترشيحهم للبرامج التدريبية الملائمة.",
"إعداد تقارير دورية عن نشاطات الوحدة وإنجازاتها ومقترحات تطوير الأداء فيها.",
 "أية مهام أخرى تكلف بها في حدود الاختصاص.",
            ],
          ),
        ],
      ),
    );
  }
}
