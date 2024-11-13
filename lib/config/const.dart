import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const Map<Map<String, String>, Map<String, IconData>> hrServices = {
  {"الدورات التدريبية": "الدورات التدريبية وتفاصيل الحصول عليها"}: {
    'تفاصيل الحصول على الدورات التدريبية': FontAwesomeIcons.leanpub
  },
  {"الشهادات العلمية": "معلومات عن الحصول على الشهادات العلمية"}: {
    'الشهادات والمؤهلات العلمية': FontAwesomeIcons.certificate
  },
  {"مسير الرواتب": "كشف مسير الرواتب وتفاصيل الراتب"}: {
    'مسير الرواتب وكشف التفاصيل الخاصه': FontAwesomeIcons.moneyBill
  },
  {"كشف العهد": "كشف العهد الخاصة بالموظف"}: {
    'تفاصيل العهد الخاصة بالموظف': FontAwesomeIcons.couch
  },
  {"القرارات المعتمدة": "التفاصيل الخاصه بالقرارات المعتمده"}: {
    'تفاصيل القرارات المعتمدة': FontAwesomeIcons.personCircleCheck
  },
  {"استعلام عن الطلبات": "استعلام عن الطلبات الخاصة بالموظف"}: {
    'تفاصيل الاستعلام عن الطلبات': FontAwesomeIcons.magnifyingGlass
  },
  {'تعريف الراتب': "كشف تعريف مفصل للراتب الخاص بالموظف"}: {
    'تفاصيل الراتب الخاص بالموظف': FontAwesomeIcons.moneyCheckDollar
  },
};

const Map<Map<String, String>, Map<String, IconData>> aboutUniversity = {
  {'الرؤية والرسالة والأهداف': 'الرؤية والرسالة والأهداف لدى الجامعة'}: {
    'عرض الرؤية والرسالة والأهداف لجامعة الحدود الشمالية': FontAwesomeIcons.eye
  },
  {'مجلس الجامعة': 'مجلس جامعة الحدود الشمالية'}: {
    'عرض المجلس الجامعي لدى جامعة الحدود الشمالية': FontAwesomeIcons.peopleRoof
  },
  {'المرصد الجامعي': 'المرصد الجامعي لدى جامعة الحدود الشمالية'}: {
    'عرض  بيانات المرصد الجامعي لدى جامعة الحدود الشمالية':
        FontAwesomeIcons.chartLine
  },
  {'اتصل بنا': 'اتصل بنا للحصول على المزيد من المعلومات'}: {
    'تواصل معنا للإستفسار والمساعده في خدمات الجامعة': FontAwesomeIcons.phone
  },
};

const Map<Map<String, String>, Map<String, IconData>> homeUniversity = {
  {'إدارة الجامعة': 'إدارة جامعة الحدود الشمالية'}: {
    'عرض الإدارة لدى جامعة الحدود الشمالية': FontAwesomeIcons.landmark
  },
  {'عن الجامعة': 'المزيد عن جامعة الحدود الشمالية'}: {
    'عرض المزيد عن جامعة الحدود الشمالية': FontAwesomeIcons.houseLaptop
  },
  {'اتصل بنا': 'اتصل بنا للحصول على المزيد من المعلومات'}: {
    'تواصل معنا للإستفسار والمساعده في خدمات الجامعة':
        FontAwesomeIcons.phoneFlip
  },
};

const List<List<String>> chipAboutUniversity = [
  ["الرؤية", "الأهداف", "الرسالة"],
  ["مجلس", "الجامعة"],
  ["الجامعي", "المرصد"],
  ["الاتصال", "اتصل"],
];

const List<List<String>> chipHomeUniversity = [
  ["إدارة", "الجامعة"],
  ["الجامعة", "عن", "المزيد"],
  ["الاتصال", "اتصل"],
];

const List<List<String>> chipListHR = [
  ["التدريبية", "الدورات"],
  ["الشهادات", "العلمية", "المؤهلات"],
  ["الرواتب", "مسير"],
  ["الخاصة", "العهد", "كشف"],
  ["القرارات", "المعتمدة"],
  ["الاستعلام", "الطلبات"],
  ["الراتب", "تعريف"],
];

const List<List<String>> chipList = [
  ["الفعاليات", "التخرج", "الحفل"],
  ["الجدول", "الدراسي"],
  ["التقويم", "الجامعي"],
  ["السجل", "المهاري", "الدورات", "الشهادات"],
];

const List<List<String>> mainChipList = [
  ["المجالس", "اللجان", "المحضر", "التوقيع"],
  ["الدعم", "المستفيد", "الشكاوي", "الاستفسارات"],
  ["الإستبيانات", "الإجابة"],
  ["المركز", "الصحي", "العيادات", "الاطباء", "المواعيد"],

];

const Map<String, IconData> services = {
  'المجالس واللجان': FontAwesomeIcons.chalkboardUser,
  'خدمة المستفيد': FontAwesomeIcons.headset,
  'الإجابة على الإستبيانات': FontAwesomeIcons.question,
  'المركز الصحي': FontAwesomeIcons.heartCircleCheck,

};

const Map<Map<String, String>, Map<String, IconData>> mainServices = {
  {'المجالس واللجان': 'المجالس واللجان وعرض المحضر الخاص بكل مجلس'}: {
    'نظام المجالس واللجان واضافة التوقيع': FontAwesomeIcons.chalkboardUser
  },

  {'خدمة المستفيد': 'تقديم الدعم والمساعده من خلال خدمة المستفيد'}: {
    'خدمات الشكاوي والاستفسارات الخاصة بالمستفيد': FontAwesomeIcons.headset
  },
  {'الإجابة على الإستبيانات': 'استعراض وإجابة الاستبيانات الخاصة بالجامعة'}: {
    'تقديم الآراء المختلفة من خلال الإجابة على الإستبيانات':
        FontAwesomeIcons.question
  },
  {'المركز الصحي': 'المركز الصحي ومواعيد العيادات الخاصة والأطباء'}: {
    'حجز واستعراض مواعيد العيادات': FontAwesomeIcons.heartCircleCheck
  },
};

const Map<Map<String, String>, Map<String, IconData>> academicServices = {
  {'الفعاليات': 'نظام حضور الفعاليات الخاص بالخريجين '}: {
    'حضور حفلات الخريجين لدى الجامعة': FontAwesomeIcons.graduationCap
  },
  {'الجدول الدراسي': 'الجدول الدراسي للعام الجامعي 2024'}: {
    'الجدول الدراسي للعام الجامعي الحالي': FontAwesomeIcons.table
  },
  {'التقويم الدراسي': 'التقويم الدراسي لعام 2024 / 2025'}: {
    'التقويم الدراسي للعام الجامعي الحالي': FontAwesomeIcons.calendarDays
  },
  {'السجل المهاري': 'نظام مهارى لحضور الدورات العلمية'}: {
    'حضور الدورات العلمية والحصول على الشهادات': FontAwesomeIcons.userGraduate
  },
};

const Map<Map<String, String>, Map<String, IconData>> skillsRecordServices = {
  {'الدورات': 'الدورات المتاحه بنظام السجل المهاري'}: {
    'يمكنك التسجيل في الدورة والحصول على الشهادة بعد الإنتهاء':
        FontAwesomeIcons.graduationCap
  },
  {'جدول السجل المهاري': 'جدول السجل المهاري للعام الجامعي الحالي'}: {
    'جدول السجل المهاري الخاص بالطالب': FontAwesomeIcons.table
  },
  {'الدورات المكتملة': 'جميع الدورات المكتملة لدى المستخدم'}: {
    'عرض الشهادات التابعة للدورات المكتملة': FontAwesomeIcons.calendarDays
  },
  {'الدورات الغير المكتملة': 'الدورات الغير المكتملة لدى المستخدم'}: {
    'متابعة استكمال الدورة للحصول على الشهادة': FontAwesomeIcons.userGraduate
  },
};

const Map<Map<String, String>, Map<String, IconData>> supportServices = {
  {'التذاكر': 'طلبات الشكاوي والاستفسارات الخاصة بالمستفيد'}: {
    'متابعة حالة التذاكر الخاصة بالمستخدم': FontAwesomeIcons.database,
  },
  {'تذكرة جديدة': 'تقديم الدعم والمساعده من خلال تذكرة جديدة'}: {
    'إنشاء تذكرة خدمة مستفيد جديدة': FontAwesomeIcons.marker,
  },
};

const Map<Map<String, String>, Map<String, IconData>> healthCareServices = {
  {'حجز موعد': 'حجز موعد في المركز الطبي'}: {
    'حجز موعد للمريض أو المرافقين بالمركز الصحي':
        FontAwesomeIcons.solidHospital,
  },
  {'حجوزاتي': 'عرض الحجوزات الخاصة بالمستخدم'}: {
    'عرض الحجوزات السابقة والقادمة وامكانية حذف الحجوزات':
        FontAwesomeIcons.solidAddressBook,
  },
};

const Map<Map<String, String>, Map<String, IconData>> majalesHome = {
  {'المجالس': 'المجالس وعرض المحضر الخاص بكل مجلس'}: {
    'نظام مجالس وعرض المحضر واضافة التوقيع أو التعليق':
        FontAwesomeIcons.peopleGroup,
  },
  {'اللجان': ' اللجان وعرض المحضر الخاص بكل لجنة'}: {
    'نظام مجالس وعرض المحضر واضافة التوقيع أو التعليق':
        FontAwesomeIcons.peopleArrows,
  },
  {'التوقيع': 'التوقيع الخاص بالمستخدم'}: {
    'إضافة توقيع جديد عن طريق الرسم أو ادراج صورة التوقيع':
        FontAwesomeIcons.signature,
  },
};

const Map<Map<String, String>, Map<String, IconData>> councilDetails = {
  {'الإجتماعات و الجلسات': 'الإجتماعات و الجلسات وعرض المحضر الخاص بكل مجلس'}: {
    'إضافة تعليق أو توقيع وعرض محضر الجلسة أو الإجتماع':
        FontAwesomeIcons.handshake,
  },
  {'الأعضاء': 'عرض الأعضاء الحاضرين بالمجلس أو الإجتماع'}: {
    'عرض الأعضاء الحاضرين وصفة كل عضو داخل المحضر': FontAwesomeIcons.peopleLine,
  },
  {'المرفقات': 'عرض المرفقات الملحقة بالمجلس أو الإجتماع'}: {
    'ملفات المرفقات الملحقة بكل مجلس أو لجنة': FontAwesomeIcons.fileContract,
  },
};

const Map<Map<String, String>, Map<String, IconData>> meetingDetails = {
  {'مواضيع أساسية': 'عرض المواضيع الأساسية وإمكانية التعليق أو التصويت'}: {
    'إضافة تعليق أو تصويت على الموضوع وعرض التعليقات':
        FontAwesomeIcons.solidRectangleList,
  },
  {'ما يستجد من أعمال': 'عرض المواضيع الجديدة وإمكانية التعليق أو التصويت'}: {
    'إضافة تعليق أو تصويت على الموضوع وعرض التعليقات':
        FontAwesomeIcons.rectangleList,
  },
  {'الأعضاء': 'عرض الأعضاء الحاضرين الموضوع'}: {
    'عرض الأعضاء الحاضرين وصفة كل عضو داخل الموضوع':
        FontAwesomeIcons.peopleLine,
  },
  {'المرفقات': 'عرض المرفقات الملحقة بالموضوع'}: {
    'ملفات المرفقات الملحقة بكل موضوع': FontAwesomeIcons.fileContract,
  },
};

const List<List<String>> appServicesChips = [
  ...mainChipList,
  ...chipList,
  ...chipListHR
];
