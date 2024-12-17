import 'package:eservices/app/components/custom_button.dart';

import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
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

  const PresidentAgreement(
      {super.key, required this.formBody, required this.presidentName});

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
            Text('* إقرار *'),
            Icon(FontAwesomeIcons.handsClapping),
            CheckboxListTile(
              title: Text(
                'أقر بأني قرأت وأطلعت على شروط البرنامج وأصادق على صحة البيانات المسجلة أعلاه و أتحمل كافة المسؤولية في حال ظهر خلاف ذلك',
                style: appTitleStyle.copyWith(
                  color: isChecked ? colorLightGreen : colorBlack,
                ),
              ),
              checkColor: isChecked ? colorLightGreen : colorBlack,
              value: isChecked,
              onChanged: (value) {
                if (value != null && value) {
                  isChecked = value;
                }
                setState(() {});
              },
            ),
            if (isChecked) ...[
              Row(
                children: [
                  Text(
                    'تحويل الطلب الي : ',
                    style: appSubTextStyle,
                  ),
                  Text(
                    widget.presidentName,
                    style: appTextStyle.copyWith(
                      color: colorPrimary,
                    ),
                  ),
                ],
              ),
              CustomButton(
                callBack: submitForm,
                label: 'تأكيد',
              )
            ],
          ],
        ),
      ),
    );
  }

  void submitForm() async {
    await showLoadingOverlay(asyncFunction: () async {
      APIController controller = APIController(
        url:
            'https://researchtest.nbu.edu.sa/api/FinanceRequest/AddFinanceRequest',
        body: widget.formBody,
        requestType: RequestType.post,
      );

      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        Get.back();
        CustomSnackBar.showCustomSnackBar(
            title: 'نجاح', message: 'تم اضافة الطلب بنجاح');
      }
    });
  }
}
