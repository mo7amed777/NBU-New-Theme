import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/list_items.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RiskManagementUnit extends StatefulWidget {
  final String title;
  const RiskManagementUnit({required this.title}) ;

  @override
  State<RiskManagementUnit> createState() => _RiskManagementUnitState();
}

class _RiskManagementUnitState extends State<RiskManagementUnit> {
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
    "السعي لإدارة فعالة للمخاطر لتهيئة بيئة تعليمية وإدارية وخدمية آمنة.",),
          ListItems(
            title: 'المهام: ',
            items: const [
              "تنفيذ الخطط والبرامج المعتمدة.",
              "إعداد وتنفيذ خطة إدارة المخاطر (سجل المخاطر) في الجامعة وتحديثها بالمخاطر المحتملة بصفة دورية.",
            "رفع مستوى ثقافة إدارة المخاطر، والالتزام بالأنظمة واللوائح والتعليمات والقواعد السلوكية والأخلاقية داخل الجامعة.",
"قياس وتحليل تأثير المخاطر المتوقعة في الجامعة وإعداد خطط التحسين اللازمة للتخفيف من آثارها.",
"التأكد من تطبيق التعليمات والإرشادات المتعلقة بالسلامة والأمن، والصحة والبيئة بالتعاون مع إدارة الأمن والسلامة.",
"تفعيل التواصل الفعال بين مختلف مستويات الاستجابة الإدارية في الجامعة بهدف اتخاذ القرار المناسب والتعامل مع المخاطر والأزمات بالأسلوب المناسب وفي الوقت المناسب.",
"تحديد مستويات المخاطر بالتنس​يق مع الوحدات التنظيمية المعنية.",
"الإشراف على تطبيق الحد الأدنى من اشتراطات الحماية والسلامة للمنشآت الجامعية والتعليمية.",
"إعداد خطط الطوارئ العامة والتدريب عليها بشكل مستمر.",
"المشاركة في تحديد الاحتياجات من الموارد البشرية والأجهزة والمواد ومتابعة توفيرها.",
"المشاركة في تحديد الاحتياجات التدريبية لموظفي الوحدة لترشيحهم للبرامج التدريبية الملائمة.",
"إعداد تقارير دورية عن نشاطات الوحدة وإنجازاتها واقتراحات تطوير الأداء فيها.",
"أية مهام أخرى تكلف بها في حدود الاختصاص.​",
            ],
          ),
        ],
      ),
    );
  }
}
