import 'package:eservices/app/components/custom_button.dart';

import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/research/reserch_home.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PresidentAgreement extends StatefulWidget {
  final dynamic formBody;
  final String presidentName;
  final String userId;

  const PresidentAgreement(
      {super.key,
      required this.formBody,
      required this.presidentName,
      required this.userId});

  @override
  State<PresidentAgreement> createState() => _PresidentAgreementState();
}

class _PresidentAgreementState extends State<PresidentAgreement> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: Get.height * 0.15, left: 10.w, right: 10.w, bottom: 8.h),
        child: Column(
          children: [
            Text(
              '* إقرار *',
              style: mediumTitleStyle.copyWith(color: colorPrimary),
            ),
            SizedBox(height: 10.h),
            Icon(
              FontAwesomeIcons.solidHandshake,
              size: 50.sp,
              color: colorPrimary,
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.symmetric(vertical: 32.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: colorPrimaryLight,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: CheckboxListTile(
                title: Text(
                  'أقر بأني قرأت وأطلعت على شروط البرنامج وأصادق على صحة البيانات المسجلة أعلاه و أتحمل كافة المسؤولية في حال ظهر خلاف ذلك',
                  style: appTitleStyle.copyWith(
                    color: isChecked ? colorLightGreen : colorBlack,
                  ),
                ),
                checkColor: isChecked ? colorLightGreen : colorBlack,
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ),
            if (isChecked) ...[
              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    'تحويل الطلب الي : ',
                    style: appSubTextStyle,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    widget.presidentName,
                    style: appTextStyle.copyWith(
                      color: colorPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomButton(
                callBack: submitForm,
                label: 'تأكيد',
                fontSize: 18,
                padding: 8,
              )
            ],
          ],
        ),
      ),
    );
  }

  void submitForm() async {
    String token = MySharedPref.getResearchToken();
    var headers = 'Bearer $token';

    await showLoadingOverlay(asyncFunction: () async {
      APIController controller = APIController(
        url:
            'https://researchtest.nbu.edu.sa/api/FinanceRequest/AddFinanceRequest',
        body: widget.formBody,
        requestType: RequestType.post,
        headers: {'Authorization': headers},
      );

      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        Get.to(Research(userID: widget.userId));
        CustomSnackBar.showCustomSnackBar(
            title: 'نجاح', message: 'تم اضافة الطلب بنجاح');
      }
    });
  }
}
