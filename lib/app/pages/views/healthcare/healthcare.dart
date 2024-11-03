import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/pages/views/healthcare/reservation.dart';
import 'package:eservices/app/pages/views/healthcare/user_reservations.dart';
import 'package:eservices/config/const.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/services/api_call_status.dart';

class HealthCare extends StatelessWidget {
  final String userID;
  HealthCare({required this.userID});

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
                    children: healthCareServices.entries.map(
                      (entry) {
                        index++;
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          columnCount: 1,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: MyCard(
                                title: entry.key.keys.first,
                                desc: entry.key.values.first,
                                icon: entry.value.values.first,
                                subTitle: entry.value.keys.first,
                                margin: EdgeInsets.all(8.sp),
                                onTap: () {
                                  getHealthCareService(
                                      title: entry.key.keys.first);
                                },
                              ),
                            ),
                          ),
                        );
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
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorPrimary,
                ),
                child: Text(
                  'المركز الصحي',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getHealthCareService({required String title}) {
    switch (title) {
      case 'حجز موعد':
        showLoadingOverlay(asyncFunction: () async {
          APIController controller = APIController(
              url:
                  'https://mobileapi.nbu.edu.sa/api/HealthExternalApi/GetClinics');
          await controller.getData();
          if (controller.apiCallStatus == ApiCallStatus.success &&
              controller.data['res']) {
            Get.to(Reservation(
              userID: userID,
              clinics: controller.data['responseObject'],
            ));
          }
        });

        break;
      case 'حجوزاتي':
        showLoadingOverlay(asyncFunction: () async {
          APIController controller = APIController(
            url:
                'https://mobileapi.nbu.edu.sa/api/HealthExternalApi/GetAppointmentsByUserID?UserID=$userID',
          );
          await controller.getData();
          if (controller.apiCallStatus == ApiCallStatus.success &&
              controller.data['res']) {
            List data = controller.data['responseObject'];
            Get.to(() => UserReservations(data: data));
          }
        });

        break;
    }
  }
}
