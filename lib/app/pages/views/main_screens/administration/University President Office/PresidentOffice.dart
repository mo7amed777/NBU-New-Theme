import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/list_items.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/list_tile.dart';
import 'package:eservices/app/pages/views/main_screens/administration/University%20President%20Office/President%20Subordinating%20Units/PresidentSubordinatingUnits.dart';
import 'package:eservices/app/pages/views/main_screens/administration/University%20President%20Office/members.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UniversityPresidentOffice extends StatefulWidget {
  const UniversityPresidentOffice({Key? key}) : super(key: key);

  @override
  State<UniversityPresidentOffice> createState() =>
      _UniversityPresidentOfficeState();
}

class _UniversityPresidentOfficeState extends State<UniversityPresidentOffice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Appbar(
              title: 'مكتب رئيس الجامعة',
              onIconPressed: () {
                Get.to(() => OfficeMembers());
              },
              icon: FontAwesomeIcons.users,
            ),
          ),
          Stack(
            children: [
              Card(
                margin: EdgeInsets.all(8.sp),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 0.0,
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text('عن المكتب',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorBlackLight,
                            fontSize: 16.sp)),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(
                      bottom: 32.h,
                    ),
                    child: Text(
                      "يعتبر مكتب رئيس الجامعة حلقة الوصل بين الإدارة العليا وكافة قطاعات الجامعة الأكاديمية والإدارية والفنية. يتصل بالمكتب عدد من الإدارات والأقسام الفرعية التي يتكامل عملها لإنجاز معاملات قطاعات الجامعة المختلفة والمجتمع المحلي ومختلف الدوائر الرسمية في المملكة العربية السعودية والقطاع الخاص.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: colorBlackLight,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24.w,
                bottom: 16.h,
                child: InkWell(
                  onTap: () {
                    Get.to(() => PresidentSubordinatingUnits());
                  },
                  child: Row(
                    children: [
                      Text(
                        'عرض المزيد',
                        style: TextStyle(
                            color: colorPrimaryLight,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                      Icon(
                        Icons.keyboard_double_arrow_left,
                        color: colorPrimaryLight,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          MyListTile(
            title: 'الرؤية',
            subtitle: "الجودة والتميز في الخدمة الإدارية.",
          ),
          MyListTile(
            title: 'الرسالة',
            subtitle:
                "التميز بعمل إداري يعزز دور مكتب مدير الجامعة في التواصل مع قطاعات الجامعة المختلفة ومتلقي الخدمة بجودة وكفاءة إدارية.",
          ),
          ListItems(title: "الأهداف ", items: const [
            "تعزيز التواصل بين الإدارة العليا وقطاعات الجامعة المختلفة.",
            "تحقيق مستوى متميز من الخدمات المقدمة لمتلقي الخدمة.",
            "السرعة والدقة في إنجاز معاملات مكتب مدير الجامعة.",
            "دعم عملية صنع القرار لدى الإدارة العليا.",
            "تسهيل العمليات اللازمة لاستكمال معاملات متلقي الخدمة.",
            "تبسيط الإجراءات في عملية تنفيذ الخدمة الإدارية.",
            "تطوير وتأهيل مهارات وخبرات الكادر الإداري في مكتب مدير الجامعة.",
            "تعزيز استخدام التعاملات الإلكترونية بين المكتب وأقسامه ومتلقي الخدمة.",
            "التحديث المستمر لأنظمة وعمل المكتب بما يواكب متطلبات التطور الأكاديمي بالجامعة.",
          ]),
        ],
      ),
    );
  }
}
