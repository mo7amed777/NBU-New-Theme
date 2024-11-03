import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/pages/views/majales/council/documents.dart';
import 'package:eservices/config/const.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/meeting.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/majales/council/meeting/subject/subjects.dart';
import 'package:eservices/app/pages/views/majales/council/members.dart';
import 'package:eservices/app/services/api_call_status.dart';

class MeetingDetails extends StatelessWidget {
  MeetingDetails({Key? key, required this.meeting}) : super(key: key);
  MeetingModel meeting;
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
                  top: Get.height * 0.17, left: 8.w, right: 8.w),
              child: SizedBox(
                height: Get.height,
                child: AnimationLimiter(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 5.sp,
                        crossAxisCount: 1),
                    physics: BouncingScrollPhysics(),
                    children: meetingDetails.entries.map(
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
                                  if (entry.key.keys.first == 'مواضيع أساسية') {
                                    getSubjects();
                                  } else if (entry.key.keys.first ==
                                      'ما يستجد من أعمال') {
                                    getNewSubjects();
                                  } else if (entry.key.keys.first ==
                                      'المرفقات') {
                                    getAttachments();
                                  } else if (entry.key.keys.first ==
                                      'الأعضاء') {
                                    getMembers();
                                  }
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
            top: meeting.titleAr!.length >= 44
                ? Get.height * 0.08
                : Get.height * 0.066,
            left: 0.0,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            top: Get.height * 0.07,
            right: 12.w,
            left: 32.w,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorPrimary,
                ),
                child: Text(
                  meeting.titleAr ?? '',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getSubjects() async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetMeetingSubjects?meetingNo=${meeting.id}&type=1&token=$headers',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        List data = controller.data['returnObject'];
        Get.to(() => MeetingSubjects(data: data, meeting: meeting));
      }
    });
  }

  void getMembers() async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetUsersByMeetId?MeetingId=${meeting.id}&token=$headers',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        List data = controller.data['returnObject'];
        Get.to(() => CouncilMembers(data: data));
      }
    });
  }

  void getNewSubjects() async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetMeetingSubjects?meetingNo=${meeting.id}&type=2&token=$headers',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        List data = controller.data['returnObject'];
        Get.to(() =>
            MeetingSubjects(data: data, meeting: meeting, isSubject: false));
      }
    });
  }

  void getAttachments() async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetMeetingAttachments?MeetingId=${meeting.id}&token=$headers',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        List data = controller.data['returnObject'];
        Get.to(() => CouncilDocuments(data: data, headers: headers));
      }
    });
  }
}
