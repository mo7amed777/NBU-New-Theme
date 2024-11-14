import 'dart:io';
import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/data/models/users/student.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/print_card.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:eservices/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/routes/app_pages.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/custom_loading_overlay.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

bool isDark = false;

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/settings_card.png',
          height: Get.height * 0.9,
          width: Get.width,
          fit: BoxFit.fill,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: Get.height * 0.05,
          child: Column(
            children: [
              CustomRow(
                  icon: isDark
                      ? FontAwesomeIcons.solidSun
                      : FontAwesomeIcons.solidMoon,
                  title: !isDark ? 'الوضع اللـيـلـي' : 'الـوضع الـعـادي',
                  color: colorWhite,
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  onTap: () {
                    setState(() {
                      isDark = !isDark;
                      MySharedPref.setIsGrayScale(
                          !MySharedPref.getIsGrayscale());
                      RestartWidget.restartApp(context);
                    });
                  }),
              SizedBox(height: 24.h),
              CustomRow(
                icon: FontAwesomeIcons.share,
                color: colorWhite,
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                title: 'مشاركة التطبيق',
                onTap: () {
                  if (Platform.isIOS) {
                    _shareApp(
                      link:
                          'https://apps.apple.com/sa/app/nbu-services/id6476774772',
                    );
                  } else {
                    _shareApp(
                      link:
                          'https://play.google.com/store/apps/details?id=com.nbu.eservices',
                    );
                  }
                },
              ),
              SizedBox(height: 24.h),
              CustomRow(
                icon: FontAwesomeIcons.signOut,
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                color: colorWhite,
                title: 'تسجيل الخروج',
                onTap: () async {
                  await logoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _shareApp({required String link}) async {
    try {
      await showLoadingOverlay(asyncFunction: () async {
        final box = context.findRenderObject() as RenderBox?;

        await Share.share(
          "Check out Northern Borders University app 🎓staying connected and accessing important information📚. Download it now:"
          '\n\n$link',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      });
    } catch (e) {
      CustomSnackBar.showCustomErrorToast(
          message: 'حدث خطأ في المشاركة برجاء المحاولة في وقت لاحق');
    }
  }

  Future logoutDialog(context) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('تسجيل الخروج',
                  style: mediumTitleStyle.copyWith(color: colorPrimary)),
              SizedBox(height: 10.h),
              Text('هل تريد تسجيل الخروج؟',
                  style: appSubTextStyle.copyWith(fontSize: 15.sp)),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      callBack: () => Get.back(closeOverlays: true),
                      fontSize: 16.sp,
                      label: 'لا',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                        label: 'نعم',
                        fontSize: 16.sp,
                        color: colorBlackLight,
                        callBack: () async {
                          MySharedPref.setIsAuthenticated(false);

                          await CookieManager().clearCookies();
                          Get.offAllNamed(Routes.LOGIN);
                        }),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
