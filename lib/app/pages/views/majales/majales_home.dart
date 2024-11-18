import 'dart:convert';
import 'package:eservices/app/components/input_field.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/config/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/majales/council/councils.dart';
import 'package:eservices/app/pages/views/majales/signature/signature_draw.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';

class MajalesHome extends StatelessWidget {
  int CardsCount = 3;
  Widget majalesCard = Card();

  MajalesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = -1;

    return Scaffold(
      backgroundColor: colorWhite,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.15, left: 8.w, right: 8.w),
              child: SizedBox(
                height: Get.height,
                child: AnimationLimiter(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 5.sp,
                        crossAxisCount: 1),
                    physics: BouncingScrollPhysics(),
                    children: majalesHome.entries.map(
                      (entry) {
                        index++;
                        return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 600),
                            columnCount: 2,
                            child: ScaleAnimation(
                                child: FadeInAnimation(
                                    child: MyCard(
                              title: entry.key.keys.first,
                              desc: entry.key.values.first,
                              icon: entry.value.values.first,
                              subTitle: entry.value.keys.first,
                              onTap: () {
                                if (entry.key.keys.first == "المجالس") {
                                  getCouncils(true, 1);
                                } else if (entry.key.keys.first == "اللجان") {
                                  getCouncils(false, 2);
                                } else if (entry.key.keys.first == "التوقيع") {
                                  getSignature();
                                }
                              },
                            ))));
                      },
                    ).toList(),
                  ),
                ),
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
                child: Center(
                  child: Text(
                    "مجالس",
                    style: largeTitleStyle.copyWith(color: colorWhite),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getCouncils(bool isMajales, int type) async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetCouncils?type=$type&token=$headers',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        List data = controller.data['returnObject']['data'];
        Get.to(() => Council(
              data: data,
              isMajales: isMajales,
            ));
      }
    });
  }

  void getSignature() async {
    String token = MySharedPref.getMajalesToken();
    var headers = 'Bearer $token';
    APIController controller = APIController(
      url:
          'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetCurrentSign?token=$headers',
    );
    await showLoadingOverlay(asyncFunction: () async {
      await controller.getData();
    });
    //Get.back();
    if (controller.apiCallStatus == ApiCallStatus.success) {
      String data = controller.data['returnObject'] ?? "";
      //Check if base64 starting with base64 pattern and replace it

      if (data.isNotEmpty) {
        if (data.contains(base64Code)) {
          data = data.replaceRange(0, 22, '');
        }
        Uint8List base64Data = base64Decode(
          data,
        );

        await Get.dialog(Card(
          margin:
              EdgeInsets.only(top: 20.h, right: 28.w, left: 28.w, bottom: 25.h),
          child: Padding(
            padding: EdgeInsets.only(
                top: 20.h, right: 20.w, left: 20.w, bottom: 10.h),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorPrimary,
                    border: Border.all(color: colorPrimaryLighter, width: 1.5),
                  ),
                  child: Text(
                    'لديك توقيع بالفعل هل تريد انشاء جديد ؟',
                    style: appTextStyle.copyWith(color: colorWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child: RepaintBoundary(child: Image.memory(base64Data))),
                CustomButton(
                  callBack: () {
                    Get.back();
                    Get.to(() => Signature());
                  },
                  label: '   توقيع جديد   ',
                  fontSize: 14.sp,
                  padding: 8.sp,
                ),
              ],
            ),
          ),
        ));
      } else {
        Get.to(() => Signature());
      }
    }
  }
}
