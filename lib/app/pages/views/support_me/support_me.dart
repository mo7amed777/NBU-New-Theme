import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/support_me/chat/chat_home.dart';
import 'package:eservices/app/pages/views/support_me/new_requests.dart';
import 'package:eservices/app/pages/views/support_me/requests.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/config/const.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SupportMe extends StatelessWidget {
  final int chatUserID;
  final bool showFromUser;
  SupportMe({Key? key, required this.chatUserID, required this.showFromUser})
      : super(key: key);

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
                    children: supportServices.entries.map(
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
                                if (entry.key.keys.first == 'تذكرة جديدة') {
                                  newRequest();
                                } else {
                                  Get.to(() => SupportRequests());
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
                child: Text(
                  'خدمة المستفيد',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getChats(),
        backgroundColor: colorPrimary,
        foregroundColor: Colors.white,
        tooltip: 'اتصل بنا',
        elevation: 5,
        splashColor: Colors.white,
        shape: CircleBorder(),
        highlightElevation: 0,
        child: Icon(Icons.support_agent),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  void newRequest() async {
    await showLoadingOverlay(asyncFunction: () async {
      try {
        APIController controller = APIController(
          url:
              'https://crm.nbu.edu.sa/api/WorkBeside/GetWorkBesidesSelectedList',
        );
        await controller.getData();
        if (controller.apiCallStatus == ApiCallStatus.success &&
            controller.data['returnObject'] != null) {
          List workBesides = controller.data['returnObject'];

          Get.to(() => NewSupportRequest(
                workBesides: workBesides,
              ));
        }
      } catch (e) {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'خطأ في الاتصال',
            message: "حدث خطأ في الاتصال بالسيرفر يرجى المحاولة مرة أخرى!");
      }
    });
  }

  void getChats() async {
    await showLoadingOverlay(asyncFunction: () async {
      APIController controller = APIController(
        url: 'https://crm.nbu.edu.sa/api/Chat/GetChats',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        List chats = controller.data['returnObject'] ?? [];

        Get.to(() =>
            Chats(data: chats, userID: chatUserID, showFromUser: showFromUser));
      }
    });
  }
}
