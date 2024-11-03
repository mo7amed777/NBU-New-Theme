import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/list_items.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/list_tile.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DecisionSupport extends StatefulWidget {
  final String title;
  const DecisionSupport({required this.title});

  @override
  State<DecisionSupport> createState() => _DecisionSupportState();
}

class _DecisionSupportState extends State<DecisionSupport> {
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
          Padding(
            padding: EdgeInsets.only(right: 16.w, top: 8.h),
            child: Text('منسوبي الوحدة',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorBlackLight,
                    fontSize: 12.sp)),
          ),
          ExpandedTile(
            mainTitle: 'د. عبدالعزيز احمد العنزي',
            title: "رئيس وحدة دعم اتخاذ القرار",
            TwoItemsRow: const [
              'a.alenazi@nbu.edu.sa',
              '5006',
            ],
          ),
          ExpandedTile(
            mainTitle: 'د. سلطان منادي العنزي',
            title: "وحدة دعم اتخاذ القرار",
            TwoItemsRow: const [
              'Sultan.Malanazi@nbu.edu.sa',
              '5912',
            ],
          ),
          ExpandedTile(
            mainTitle: 'د. زكريا محمد صالح',
            title: "وحدة دعم اتخاذ القرار",
            TwoItemsRow: const [
              'zakariya@nbu.edu.sa',
              '',
            ],
          ),
          ExpandedTile(
            mainTitle: 'عبدالناصر صابر محمد',
            title: "وحدة دعم اتخاذ القرار",
            TwoItemsRow: const [
              'Abdelnasser.mohammed@nbu.edu.sa',
              '5840',
            ],
          ),
          ExpandedTile(
            mainTitle: 'احمد سالم العنزي',
            title: "وحدة دعم اتخاذ القرار",
            TwoItemsRow: const [
              'Ahmed.salemf@nbu.edu.sa',
              '',
            ],
          ),
          MyListTile(
            title: 'الارتباط التنظيمي:',
            subtitle:
                "ترتبط بالإدارة العامة للتخطيط الإستراتيجي وتحقيق الرؤية.",
          ),
          MyListTile(
            title: 'الهدف العام:',
            subtitle:
                "توفير البيانات والمعلومات لدعم ومساندة الإدارة العليا لاتخاذ القرار المناسب.",
          ),
          ListItems(
            title: 'المهام: ',
            items: const [
              "تنفيذ الخطط والبرامج المعتمدة.",
              "تطوير منظومة البيانات في الجامعة من خلال جمعها من مصادر داخلية وخارجية وتصنيفها وتبويبها تمهيداً لاستخدامها لأغراض التخطيط الإستراتيجي ودعم اتخاذ القرار.",
              "إجراء التحليل الإحصائي للبيانات وتحويل البيانات إلى معلومات يستفاد منها لخدمة أنشطة الجامعة بشكل مناسب يسهل فهمها.",
              "استخدام البرامج الحديثة والنماذج المناسبة لاستخراج نتائج دقيقة للتوصل إلى بدائل مختلفة لتمكين متخذي القرار من اختيار البديل المناسب.",
              "تزويد الوحدات التنظيمية المستفيدة بالبيانات الإحصائية اللازمة عند طلبها، أو وفقاً للتوقيتات المحددة.",
              "التنسيق مع الأطراف المرتبطة بتنفيذ القرار لمتابعة النتائج والتغيرات التي تطرأ عليه للتأكد من سلامة ودقة البيانات.",
              "تبادل المعلومات والخبرات والتعاون مع مراكز المعلومات الداخلية والخارجية.",
              "مواكبة احتياجات المستفيدين من المعلومات والوثائق والعمل على تلبيتها.",
              "جمع وتصنيف البيانات الخاصة بالمقارنات المرجعية مع جامعات مميزة في الجوانب التي تهم الجامعة للاستفادة منها عند اتخاذ القرار.",
              "المشاركة في تحديد الاحتياجات من الموارد البشرية والتجهيزات والمواد والعمل على توفيرها.",
              "المشاركة في تحديد الاحتياجات التدريبية لموظفي الوحدة لترشيحهم للبرامج التدريبية الملائمة.",
              "إعداد تقارير دورية عن نشاطات الوحدة وإنجازاتها واقتراحات تطوير الأداء فيها.",
              "أية مهام أخرى تكلف بها في حدود الاختصاص.",
            ],
          ),
        ],
      ),
    );
  }
}
