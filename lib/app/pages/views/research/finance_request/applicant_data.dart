import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/research/finance_request/request_form.dart';
import 'package:eservices/app/pages/views/research/reserch_home.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ApplicantData extends StatelessWidget {
  const ApplicantData({
    super.key,
    required this.projectId,
    required this.userData,
    required this.presidentData,
  });
  final String projectId;
  final Map<String, dynamic> userData;
  final Map<String, dynamic> presidentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.17, left: 8.w, right: 8.w),
              child: Column(
                children: getChildern(),
              )),
          Positioned(
            top: Get.height * 0.065,
            left: 8.w,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            top: Get.height * 0.07,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colorPrimary,
                ),
                child: Text(
                  "بيانات عضو هيئة التدريس",
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getChildern() {
    List<Widget> list = [
      CustomRow(
        title: "الإسم",
        trailing: userData["name"],
        padding: EdgeInsets.all(8.sp),
      ),
      CustomRow(
        title: "رقم السجل / الهوية",
        trailing: userData["nid"],
        padding: EdgeInsets.all(8.sp),
      ),
      CustomRow(
        title: "الإيميل الشخصي",
        trailing: userData["personalEmail"],
        padding: EdgeInsets.all(8.sp),
      ),
      CustomRow(
        title: "الرقم الوظيفي",
        trailing: userData["jobCode"],
        padding: EdgeInsets.all(8.sp),
      ),
      CustomRow(
        title: "الكلية",
        trailing: userData["collegeName"],
        padding: EdgeInsets.all(8.sp),
      ),
      CustomRow(
        title: "القسم",
        trailing: userData["sectionName"],
        padding: EdgeInsets.all(8.sp),
      ),
      CustomRow(
        title: "الرتبة العلمية",
        trailing: userData["lastJobRankName"],
        padding: EdgeInsets.all(8.sp),
      ),
      CustomRow(
        title: "رقم الجوال",
        trailing: userData["mobileNo"],
        padding: EdgeInsets.all(8.sp),
      ),
      Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "رقم المشروع",
                style: appTextStyle.copyWith(
                  color: colorPrimary,
                ),
              ),
            ),
            Expanded(
              child: Text(
                projectId,
                style: smallTitleStyle.copyWith(
                  color: colorBlack,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16.h),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        CustomButton(
          callBack: () => getResearchData(),
          label: '\t\t\t\t \t\t التالي \t\t \t\t\t\t',
          fontSize: 13.sp,
          padding: 10.sp,
        ),
        SizedBox(
          width: 8.w,
        ),
        CustomButton(
          callBack: () => Get.back(),
          label: 'السابق',
          fontSize: 11.sp,
          padding: 8.sp,
          icon: Icons.arrow_forward_ios_outlined,
        ),
      ]),
    ];

    return list;
  }

  void getResearchData() async {
    try {
      List financePriorties = [], researcherRoles = [];
      showLoadingOverlay(
        asyncFunction: () async {
          String token = MySharedPref.getResearchToken();
          var headers = 'Bearer $token';
          APIController controller = APIController(
              url: 'https://researchtest.nbu.edu.sa/api/FinancePriorty/GetAll',
              headers: {'Authorization': headers});
          await controller.getData();
          if (controller.apiCallStatus == ApiCallStatus.success) {
            financePriorties = controller.data['returnObject'];
            controller = APIController(
                url:
                    'https://researchtest.nbu.edu.sa/api/ResearcherRole/GetAll',
                headers: {'Authorization': headers});
            await controller.getData();
            if (controller.apiCallStatus == ApiCallStatus.success) {
              researcherRoles = controller.data['returnObject'];
              Get.to(() => FinanceRequestForm(
                    financePriorties: financePriorties,
                    researcherRoles: researcherRoles,
                    projectId: projectId,
                    userData: userData,
                    presidentData: presidentData,
                  ));
            } else {
              CustomSnackBar.showCustomErrorToast(
                  message: controller.data['arabicMessage']);
            }
          } else {
            CustomSnackBar.showCustomErrorToast(
                message: controller.data['arabicMessage']);
          }
        },
      );
    } catch (e) {
      Get.back();
      CustomSnackBar.showCustomErrorToast(
          message: 'حدث خطأ في الاتصال بالانترنت يرجى المحاولة في وقت لاحق');
      return;
    }
  }
}
