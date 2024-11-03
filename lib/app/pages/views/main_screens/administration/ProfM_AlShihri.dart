import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfM_AlShihri extends StatefulWidget {
  const ProfM_AlShihri({Key? key}) : super(key: key);

  @override
  State<ProfM_AlShihri> createState() => _ProfM_AlShihriState();
}

class _ProfM_AlShihriState extends State<ProfM_AlShihri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Appbar(
          title: 'أ.د. أحمد بن علي بن صالح الرميح',
          
        ),
        Card(
          color: Colors.white,
          elevation: 0.0,
          margin: EdgeInsets.all(10.sp),

          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage:
                  AssetImage('assets/images/presedient.png'),

            ),
            title: Text(
              'أ.د. أحمد بن علي بن صالح الرميح',
              style: TextStyle(
                  fontWeight: FontWeight.bold, overflow: TextOverflow.fade),
            ),
            subtitle: Text(
              'رئيس الجامعة',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Column(
          children: [

            ListItems(title: 'المؤهلات العلمية', items: const [
              '2021    استاذ لغة إنجليزية .',
              '2014   استاذ مشارك لغة إنجليزية .',
              '2004    دكتوراه في تعليم اللغة الانجليزية بمساعدة الحاسب، جامعة ولاية  كانساس الحكومية في الولايات المتحدة الأمريكية، تقدير امتياز.',
              '1999    ماجستير في تخصص اللغويات النظرية، جامعة ولاية متشيغن، الولايات المتحدة الأمريكية، تقدير ممتاز.',
              '1994    بكالوريوس لغة انجليزية من جامعة الإمام محمد بن سعود الإسلامية, كلية اللغات والترجمة،  الرياض، تقدير: جيد جداً.',
            ]),
            ListItems(title: 'الخبرات الوظيفية', items: const [
              '1994 -1995     معيد في قسم اللغة الانجليزية والترجمة، جامعة الإمام، فرع القصيم (جامعة القصيم حالياً).',
              '1995 -2003     الدراسة في الولايات المتحدة الأمريكية للحصول على درجتي الماجستير والدكتوراه.',
            '2003 -2005     أستاذ مساعد في قسم اللغة الانجليزية والترجمة، جامعة القصيم.'
            ,'2005 -2007     رئيس قسم اللغة الانجليزية والترجمة، جامعة القصيم.',
            '2007- 2009     عميد عمادة الدراسات العليا جامعة القصيم.',
              '2009- 2010     مستشار متفرغ لدى ادارة التعاون الدولي- وزارة التعليم العالي.',
            '2010- 2014     عميد القبول والتسجيل بجامعة المجمعة و المشرف على عمادة السنة التحضيرية.',
            '2014- 2019     وكيل جامعة المجمعة للشؤون التعليمية  .',
            '2019- 2023        وكيل جامعة المجمعة للدراسات العليا والبحث العلمي .',
            '2023- حاليًا        رئيس جامعة الحدود الشمالية',
            ]),
            ListItems(title: 'البحوث المنشورة', items: const [
              'The  Use of English  in Dissertation and Thesis Writing Study of Need Importance , Difficulty , and Possibility .',
              'استخدام اللغة الإنجليزية في كتابة الرسائل والبحوث العلمية دراسة للاحتياجات  والأهمية والمعوقات والامتحانات .',
'Linguistic and Metalinguistic Implications for learner’ Reciprocity and Autonomy   in Online Discussions vs. Class Discussions ',
              'الأثار اللغوية والغير لغوية تجاه توافق المتعلمين وقدراتهم في المناقشات الإلكترونية مقابل مناقشة الفصل المدرسي',
            'NARRATIVE AS A TOOL  FOR LEXICON COMPREHENSION',
              'السرد القصصي كأداة لفهم مفردات النصوص',
              'Technology Enhanced Vocabulary Acquisition & Listening Comprehension',
           ' A Quantitative Study of Technology-Based Instruction vs . Traditional Instruction',
           'اكتساب المفردات اللغوية والاستماع والفهم المبني على استخدام التفكير: دراسة كمية للتعلم القائم على التكنولوجيا مقابل التعلم التقليدي .',
            ]),
            ListItems(title: 'اللجان', items: const [
              'رئيس اللجنة التنفيذية للاعتماد المؤسسي لجامعة المجمعة.',
              'رئيس اللجان العامة للاعتماد البرامجي لجامعة المجمعة .',
              'عضو اللجنة الرئيسية للخطة الاستراتيجية لجامعة المجمعة .',
              'رئيس لجنة تنفيذ مؤشرات خطة افاق لدى جامعة المجمعة .',
              'رئيس عدد من اللجان العاملة بجامعة المجمعة " كلجنة الخطط والنظام الدراسي ولجنة القبول ولجنة برامج التعليم الموازي ".',
          'رئيس المجلس العلمي بجامعة المجمعة وأمين مجلس جامعة المجمعة.',
            ]),
            ListItems(title: 'العضويات و المؤتمرات', items: const [
              'عضو عدد من المجالس كمجلس جامعة المجمعة والمجلس العلمي ومجلس الدراسات العليا.',
              'عضو جمعية الاتصالات وتقنية المعلومات العالمية منذ عام 2000.',
'عضو الجمعية الدولية لتقنيات التعليم منذ عام 2000',
              'عضو الجمعية الأمريكية للغويين منذ عام 2001',
              'عضو الجمعية السعودية اللغوية منذ عام 2002',
              'حضور المؤتمر السنوي لمتخصصي تدريس اللغة الانجليزية لغير الناطقين بها في مدين شيكاكو 2001 وفي مدينة نيويورك لعام 2002 وفي مدينة سياتل لعام 2003.',
            'حضور مؤتمر الجامعة الإسلامية العالمية حول تدريس اللغة الانجليزية كلغة ثانية في مدينة كولالمبور لعام 2005.',
            'حضور مؤتمر تيسول أريبيا TESOL Arabia في دبي، الإمارات العربية المتحدة للأعوام 2005، 2006، 2007, 2008¸2009¸2010¸2012',
            ]),
          ],
        ),
      ],
    ));
  }
}
