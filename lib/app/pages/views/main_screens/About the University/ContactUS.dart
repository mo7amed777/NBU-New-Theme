import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/list_items.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({Key? key}) : super(key: key);

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhiteLight,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Appbar(
              title: 'اتصل بنا',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child:
                ListItems(title: 'معلومات الاتصال:', padding: 16, items: const [
              'البريد الالكتروني: info@nbu.edu.sa',
              'الهاتف الموحد: 920000540',
              'فاكس: 6146620771',
              'الصندوق البريدي: ص.ب 1321,',
              'الرمز البريدي: 91431 عرعر',
              'المرشدة النفسية : Sadafabdulrehman@nbu.edu.sa',
              'للمزيد من المعلومات يمكنكم زيارة موقعنا في تويتر https://twitter.com/mednbu ',
            ]),
          ),
        ],
      ),
    );
  }
}
