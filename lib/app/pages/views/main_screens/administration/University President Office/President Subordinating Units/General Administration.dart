import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/list_items.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralAdministration extends StatefulWidget {
  final String title;
  const GeneralAdministration({required this.title});

  @override
  State<GeneralAdministration> createState() => _GeneralAdministrationState();
}

class _GeneralAdministrationState extends State<GeneralAdministration> {
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
    "بناء الخطة الإستراتيجية والتشغيلية للجامعة وضمان تكامل وانسجام الخطط والأهداف الخاصة بالجامعة مع رؤية المملكة 2030 ومستهدفات التنمية.",),
          ListItems(
            title: 'المهام: ',
            items: const [
              "إعداد خطط نشاطات الإدارة العامة ومتابعة تنفيذها بعد اعتمادها.",
            "الإشراف الإداري والفني على الوحدات التنظيمية المرتبطة بالإدارة العامة والتنسيق فيما بينها بما يضمن التكامل بين نشاطاتها، والاستفادة القصوى من الإمكانات المتاحة.",
"الإشراف على إعداد الخطة الإستراتيجية ومتابعة تحديثها بالمستجدات بشكل دوري.",
"الإشراف على فرق العمل واللجان المكلفة بإعداد الخطط التشغيلية، وتقديم الدعم اللازم لها.",
"المشاركة في التخطيط السنوي لميزانية الجامعة وربطها بالمبادرات والأنشطة الموجودة في الخطة الإستراتيجية.",
"إدارة عملية تطوير مؤشرات الأداء الرئيسية بما يتوافق مع الأهداف والخطة الإستراتيجية للجامعة.",
"التنسيق مع جميع الوحدات المختصة من كليات وعمادات وإدارات لتحديد مؤشرات قياس الأداء والمستهدفات بهدف قياس أدائها.",
"الإشراف على تنفيذ خطط الجامعة السنوية وفقاً لتقارير المتابعة السنوي.",
"التنسيق والتعاون مع وزارة التعليم في استيفاء بيانات الأدلة والإحصائيات في مجال التخطيط الجامعي.",
"تطوير أوجه التعاون والتنسيق مع الجهات ذات العلاقة لتحقيق أهداف الجامعة في مجال التخطيط والتنمية.",
"توجيه مبادرات الجامعة لخدمة الاحتياج الوطني ومستهدفات رؤية المملكة والإسهام في تحقيق أهداف برامج الرؤية.",
"الإشراف على نتائج مؤشرات الأداء وعرضها على رئيس الجامعة ومجلس الجامعة.",
"التعاون مع الجهات المحلية والدولية فيما يتعلق بالتخطيط الجامعي.",
"تحديد مؤشرات قياس الأداء لجميع الأنشطة المتعلقة بالإدارة العامة ومراجعتها وتطويرها بصفة مستمرة بعد اعتمادها.",
"تحديد احتياجات الإدارة العامة من الموارد البشرية والأجهزة والمواد ومتابعة توفيرها.",
"تحديد الاحتياجات التدريبية لموظفي الإدارة العامة لترشيحهم للبرامج التدريبية الملائمة.",
"إعداد تقارير دورية عن نشاطات الإدارة العامة والوحدات التنظيمية المرتبطة بها وإنجازاتها ومقترحات تطوير الأداء فيها.",
"أية مهام أخرى تكلف بها في حدود الاختصاص.",
            ],
          ),
        ],
      ),
    );
  }
}
