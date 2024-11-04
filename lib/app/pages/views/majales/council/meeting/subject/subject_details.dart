import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/pages/views/majales/council/documents.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/meeting.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/majales/council/meeting/subject/comment.dart';
import 'package:eservices/app/pages/views/majales/council/meeting/subject/vote.dart';
import 'package:eservices/app/services/api_call_status.dart';

import '../../../../../../../config/theme/app_colors.dart';

class SubjectDetails extends StatelessWidget {
  final int subjectNo;
  final MeetingModel meeting;
  final String subjectTitle, details, decision;
  SubjectDetails(
      {Key? key,
      required this.subjectNo,
      required this.meeting,
      required this.subjectTitle,
      required this.details,
      required this.decision})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(meeting.titleAr!.length);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.17, left: 25.w, right: 25.w),
            child: SizedBox(
              height: Get.height,
              child: AnimationLimiter(
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          details.isEmpty && decision.isEmpty ? 2 : 0.75,
                      crossAxisCount: 1),
                  children: List.generate(
                    1,
                    (int index) {
                      getCard();
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 600),
                        columnCount: 1,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: getCard(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: subjectTitle.length >= 44
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
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colorPrimary,
                ),
                child: Text(
                  subjectTitle,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 64.h,
            right: 24.w,
            left: 24.w,
            child: CustomRow(
              padding: EdgeInsets.all(8.sp),
              onTap: () => getAttachments(),
              icon: FontAwesomeIcons.fileContract,
              color: colorPrimary,
              iconColor: colorLightGreen,
              title: 'عرض المرفقات',
            ),
          ),
          Positioned(
            bottom: 4.h,
            child: Row(
              children: [
                if (canDo(meeting.commentsCloseDate ?? "Not Valid",
                    meeting.allowComments ?? false))
                  CustomButton(
                    label: 'التعليق',
                    fontSize: 16.sp,
                    padding: 8,
                    icon: FontAwesomeIcons.comment,
                    callBack: () => comment(),
                  ),
                SizedBox(width: 32.w),
                if (canDo(meeting.voteCloseDate ?? "Not Valid",
                    meeting.allowVote ?? false))
                  CustomButton(
                    label: 'التصويت',
                    icon: FontAwesomeIcons.voteYea,
                    padding: 8,
                    fontSize: 16.sp,
                    callBack: () => vote(),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void comment() async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetSubjectComments?subjectNo=$subjectNo&token=$headers',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        List data = controller.data['returnObject'];
        Get.to(() => SubjectComment(data: data, subjectNo: subjectNo));
      }
    });
  }

  void vote() async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetSubjectVotes?subjectNo=$subjectNo&token=$headers',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        List data = controller.data['returnObject'];
        List voteOptions = [];
        if (data.isEmpty) {
          APIController controller = APIController(
            url:
                'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetSubjectVoteOptions?token=$headers',
          );
          await controller.getData();
          if (controller.apiCallStatus == ApiCallStatus.success) {
            voteOptions = controller.data['returnObject'];
            Get.to(() => SubjectVote(
                data: data, voteOptions: voteOptions, subjectNo: subjectNo));
          }
        } else {
          Get.to(() => SubjectVote(
              data: data, voteOptions: const [], subjectNo: subjectNo));
        }
      }
    });
  }

  void getAttachments() async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetSubjectAttachments?MeetingSubjectId=${subjectNo}&token=$headers',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        List data = controller.data['returnObject'];
        Get.to(() => CouncilDocuments(data: data, headers: headers));
      }
    });
  }

  bool canDo(String closeDate, bool allow) {
    if (closeDate == "Not Valid") {
      if (allow) {
        return true;
      } else {
        return false;
      }
    } else {
      if (DateTime.now().isBefore(DateTime.parse(closeDate))) {
        return true;
      } else {
        return false;
      }
    }
  }

  Widget bottomButton(
          {required String title,
          required IconData icon,
          required Function callBack}) =>
      InkWell(
        onTap: () => callBack(),
        child: Card(
          margin: EdgeInsets.all(8.sp),
          color: colorPrimaryLighter,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colorWhite,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  icon,
                  color: colorWhite,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      );

  Widget getCard() {
    if (details.isEmpty && decision.isEmpty) {
      return Container();
    }
    return Card(
      elevation: 0.0,
      color: colorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0), // Adjust the top left border radius
          topRight: Radius.circular(25.0), // Adjust the top right border radius
          bottomLeft:
              Radius.circular(25.0), // Adjust the bottom left border radius
          bottomRight:
              Radius.circular(25.0), // Adjust the bottom right border radius
        ),
        side: BorderSide(
          color: Color.fromRGBO(
              7, 45, 88, 0.42), // Change this color to the desired border color
          width: 1.0, // Change this value to the desired border width
        ),
      ),
      shadowColor: Color(0xff9ab83d),
      child: Center(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              details,
              textStyle: TextStyle(color: colorPrimary),
            ),
          ),
          decision.isEmpty
              ? Container()
              : Divider(
                  height: 16.h,
                  thickness: 2.sp,
                  indent: 4.w,
                  endIndent: 8.w,
                  color: Colors.black12,
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              decision,
              textStyle: TextStyle(color: colorPrimary),
            ),
          ),
        ],
      ))),
    );
  }
}
