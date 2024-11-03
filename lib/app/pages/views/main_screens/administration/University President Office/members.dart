import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficeMembers extends StatefulWidget {
  const OfficeMembers({Key? key}) : super(key: key);

  @override
  State<OfficeMembers> createState() => _OfficeMembersState();
}

class _OfficeMembersState extends State<OfficeMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: ListView(
          children: <Widget>[
            Appbar(
              title: 'المنسوبون',
            ),
            ExpandedTile(
              mainTitle: 'د.مفضي بن رطيان الشراري',
              title: "المشرف العام على مكتب رئيس الجامعة",
              TwoItemsRow: const [
                '​mufadhi.alsharari@nbu.edu.sa',
                '0146614001',
              ],
              onEyeTapped: () {
                callByPhoneOrEmail(
                    name: 'د.مفضي بن رطيان الشراري',
                    phoneNumber: '0146614001',
                    email: "​mufadhi.alsharari@nbu.edu.sa");
              },
            ),
            ExpandedTile(
              mainTitle: '​حمود بن ملفي العنزي',
              title: "مدير مكتب رئيس الجامعة",
              TwoItemsRow: const [
                '​hmod.alenazi@nbu.edu.sa',
                '0146614002',
              ],
              onEyeTapped: () {
                callByPhoneOrEmail(
                    name: '​حمود بن ملفي العنزي',
                    phoneNumber: '0146614001',
                    email: "​mufadhi.alsharari@nbu.edu.sa");
              },
            ),
            ExpandedTile(
              mainTitle: 'عادل بن عبد الله الأحمري',
              title: "مدير المكتب السري",
              TwoItemsRow: const [
                '​aalahmary@nbu.edu.sa',
                '0146614007',
              ],
              onEyeTapped: () {
                callByPhoneOrEmail(
                    name: 'عادل بن عبد الله الأحمري',
                    phoneNumber: '0146614001',
                    email: "​aalahmary@nbu.edu.sa");
              },
            ),
            ExpandedTile(
              mainTitle: 'ريان بن عبد الوهاب الشريف',
              title: "سكرتير رئيس الجامعة",
              TwoItemsRow: const [
                '​Rayan.Alsharif@nbu.edu.sa',
                '0146614005',
              ],
              onEyeTapped: () {
                callByPhoneOrEmail(
                    name: 'ريان بن عبد الوهاب الشريف',
                    phoneNumber: '0146614005',
                    email: "​Rayan.Alsharif@nbu.edu.sa");
              },
            ),
            ExpandedTile(
              mainTitle: 'عيسى بن محمد شريف',
              title: "​وحدة الإتصالات الإدارية",
              TwoItemsRow: const [
                '​Sharif@nbu.edu.sa',
                '0146614008',
              ],
              onEyeTapped: () {
                callByPhoneOrEmail(
                    name: 'عيسى بن محمد شريف',
                    phoneNumber: '0146614008',
                    email: "​Sharif@nbu.edu.sa");
              },
            ),
            ExpandedTile(
              mainTitle: '​صالح بن راشد البناقي',
              title: "​وحدة الإتصالات الإدارية",
              TwoItemsRow: const [
                '​Saleh.Albannagi@nbu.edu.sa',
                '0144615453',
              ],
              onEyeTapped: () {
                callByPhoneOrEmail(
                    name: '​صالح بن راشد البناقي',
                    phoneNumber: '0144615453',
                    email: '​Saleh.Albannagi@nbu.edu.sa');
              },
            ),
            ExpandedTile(
              mainTitle: '​موسى بن حطاب الحازمي',
              title: "​وحدة الإتصالات الإدارية",
              TwoItemsRow: const [
                'Not Available',
                '0144614006',
              ],
              onEyeTapped: () {
                callByPhoneOrEmail(
                    name: '​موسى بن حطاب الحازمي',
                    phoneNumber: '0144614006',
                    email: "Not Available");
              },
            ),
            ExpandedTile(
              mainTitle: 'علي بن سكران العنزي',
              title: "​وحدة الإتصالات الإدارية",
              TwoItemsRow: const [
                'Not Available',
                'Not Available',
              ],
              onEyeTapped: () {
                CustomSnackBar.showCustomToast(
                  message: "لا يوجد بيانات اتصال خاصة به",
                );
              },
            ),
            ExpandedTile(
              mainTitle: '​بدر  بن عايد الهزيمي',
              title: "​وحدة الإتصالات الإدارية",
              TwoItemsRow: const [
                'Not Available',
                'Not Available',
              ],
              onEyeTapped: () {
                CustomSnackBar.showCustomToast(
                  message: "لا يوجد بيانات اتصال خاصة به",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void callByPhoneOrEmail({
    required String name,
    required String email,
    required String phoneNumber,
  }) async {
    Get.defaultDialog(
      title: 'اتصال...',
      titleStyle: TextStyle(color: colorPrimary),
      content: Text(name, style: TextStyle(color: colorPrimary)),
      actions: [
        phoneNumber != 'Not Available'
            ? TextButton(
                child: Text('الهاتف'),
                onPressed: () async {
                  Get.back();
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: phoneNumber,
                  );
                  await launchUrl(launchUri);
                },
              )
            : Container(),
        email != 'Not Available'
            ? TextButton(
                child: Text('البريد'),
                onPressed: () async {
                  Get.back();
                  final Uri launchUri = Uri(
                    scheme: 'mailto',
                    path: email,
                  );
                  await launchUrl(launchUri);
                },
              )
            : Container(),
      ],
    );
  }
}
