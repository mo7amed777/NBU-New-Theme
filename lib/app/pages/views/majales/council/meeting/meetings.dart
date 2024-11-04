import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/details_dialog.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/mahdar.dart';
import 'package:eservices/app/data/models/meeting.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/majales/council/meeting/mahder.dart';
import 'package:eservices/app/pages/views/majales/council/meeting/meeting_details.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';

class Meetings extends StatelessWidget {
  Meetings({required this.data});
  final List data;
  TextEditingController signController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: Get.height * 0.17, left: 25.w, right: 25.w),
                child: data.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                'assets/images/no-data.gif',
                              )),
                          SizedBox(height: 32),
                          Text(
                            'لا يوجد',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: data.map(((userMeeting) {
                        MeetingModel meeting =
                            MeetingModel.fromJson(userMeeting);
                        return MyCard(
                          title: meeting.titleAr ?? meeting.place ?? '',
                          subTitle: meeting.date!.substring(0, 10),
                          fullWidth: true,
                          desc: meeting.place ??
                              meeting.meetingStatusNameAr ??
                              '',
                          onTap: () {
                            Get.to(() => MeetingDetails(
                                  meeting: meeting,
                                ));
                          },
                          icon: FontAwesomeIcons.meetup,
                          margin: EdgeInsets.all(8.sp),
                          showDetails: () => showDetails(
                            rows: [
                              CustomRow(
                                title: ' رقم الجلسة : ',
                                trailing: meeting.id.toString(),
                              ),
                              CustomRow(
                                title: ' حالة الجلسة : ',
                                trailing: meeting.meetingStatusNameAr ?? '',
                              ),
                              CustomRow(
                                title: ' تاريخ الجلسة : ',
                                trailing: meeting.date!.substring(0, 10),
                              ),
                              CustomRow(
                                title: ' مكان الجلسة :  ',
                                trailing: meeting.place!,
                              ),
                              CustomRow(
                                title: ' بداية الجلسة :  ',
                                trailing: meeting.startTime!,
                              ),
                              CustomRow(
                                title: ' نهاية الجلسة :  ',
                                trailing: meeting.endTime!,
                              ),
                              CustomRow(
                                onTap: () => openMahder(meeting.id),
                                title: 'عرض المحضر',
                                iconColor: colorLightGreen,
                                icon: FontAwesomeIcons.folderOpen,
                              ),
                              if (meeting.isigned!)
                                CustomRow(
                                  onTap: () => signMahder(meeting.id),
                                  title: 'توقيع المحضر',
                                  iconColor: colorLightGreen,
                                  icon: FontAwesomeIcons.signature,
                                ),
                              if (meeting.isigned!)
                                CustomRow(
                                  onTap: () => signMahderWithNotes(meeting.id),
                                  title: 'توقيع',
                                  iconColor: colorLightGreen,
                                  icon: FontAwesomeIcons.fileSignature,
                                ),
                            ],
                            title: meeting.titleAr ?? '',
                          ),
                          isMajales: true,
                          showNext: () {
                            Get.to(() => MeetingDetails(
                                  meeting: meeting,
                                ));
                          },
                        );
                      })).toList())),
          ),
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
                  'الاجتماعات و الجلسات',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openMahder(id) async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
          url:
              'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetMeetingDetails?MeetingId=$id&token=$headers');
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        Map<String, dynamic> data = controller.data['returnObject'];
        MahderModel mahderModel = MahderModel.fromJson(data);
        Get.to(() => Mahder(mahderModel: mahderModel));
      }
    });
  }

  void signMahder(id) async {
    Get.back();
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/SetMeetingUserSignature',
        body: {
          "meetingId": id,
          "token": headers,
        },
        requestType: RequestType.post,
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        Get.back();
        CustomSnackBar.showCustomSnackBar(
            title: 'نجاح', message: 'تم التوقيع بنجاح');
      }
    });
  }

  void signMahderWithNotes(id) async {
    await Get.defaultDialog(
      title: 'اضافة تحفظ مع توقيع المحضر',
      content: TextField(
        decoration: InputDecoration(
          hintText: 'اضافة ملاحظة...',
          border: InputBorder.none,
          filled: true,
          suffixIcon: Icon(Icons.comment, color: colorPrimaryLighter),
        ),
      ),
      confirm: TextButton(
        onPressed: () async {
          Get.back();
          await showLoadingOverlay(asyncFunction: () async {
            String token = MySharedPref.getMajalesToken();
            var headers = 'Bearer $token';
            APIController controller = APIController(
              url:
                  'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/SetMeetingUserSignature',
              body: {
                "meetingId": id,
                "signNote": signController.text,
                "token": headers,
              },
              requestType: RequestType.post,
            );
            await controller.getData();
            if (controller.apiCallStatus == ApiCallStatus.success) {
              Get.back();
              CustomSnackBar.showCustomSnackBar(
                  title: 'نجاح', message: 'تم التوقيع بنجاح');
            }
          });
        },
        child: Text(
          'توقيع',
          style: appTextStyle,
        ),
      ),
    );
  }
}
