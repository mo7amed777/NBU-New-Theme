import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/comment.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:timelines/timelines.dart';

class SubjectComment extends StatefulWidget {
  SubjectComment({Key? key, required this.data, required this.subjectNo})
      : super(key: key);
  late List data;
  final int subjectNo;

  @override
  State<SubjectComment> createState() => _SubjectCommentState();
}

class _SubjectCommentState extends State<SubjectComment> {
  final TextEditingController _commentController = TextEditingController();

  FocusNode fNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          widget.data.isEmpty
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.25, left: 8.w, right: 8.w),
                  child: Timeline.tileBuilder(
                    shrinkWrap: true,
                    builder: TimelineTileBuilder.fromStyle(
                      contentsAlign: ContentsAlign.alternating,
                      connectorStyle: ConnectorStyle.dashedLine,
                      contentsBuilder: (context, index) {
                        CommentModel comment =
                            CommentModel.fromJson(widget.data[index]);
                        return Card(
                          elevation: 20,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    comment.user?.nameAr ??
                                        comment.user?.nameEn ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: appTitleStyle.copyWith(
                                      color: colorLightGreen,
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/male.png',
                                    ),
                                    radius: 20,
                                  ),
                                  subtitle: Text(
                                    comment.creationDate?.substring(0, 10) ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: appSubTextStyle,
                                  ),
                                ),
                                comment.comment == null
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(comment.comment!,
                                            style: mediumTitleStyle.copyWith(
                                              color: colorPrimary,
                                            )),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: widget.data.length,
                    ),
                  ),
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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    gradient: LinearGradient(
                      colors: [
                        colorPrimaryLighter.withOpacity(0.9),
                        colorPrimaryLight.withOpacity(0.9),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    )),
                child: Text(
                  ' التعليقات ',
                  style: TextStyle(
                      fontSize: 19.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.15,
            left: 16.0,
            right: 16.0,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(55),
                side: BorderSide(color: colorBlackLighter, width: 1),
              ),
              child: TextField(
                textInputAction: TextInputAction.send,
                focusNode: fNode,
                controller: _commentController,
                onSubmitted: (comment) => addNewComment(comment: comment),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                    ),
                    onPressed: () {
                      addNewComment(comment: _commentController.text);
                    },
                  ),
                  filled: true,
                  hintText: ' اضافة تعليق جديد ... ',
                  fillColor: colorWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addNewComment({required String comment}) async {
    //Remove keyboard focus
    fNode.unfocus();
    _commentController.clear();

    await showLoadingOverlay(asyncFunction: () async {
      //check if comment is not empty then send to API & setState if success
      final commentText = comment.trim();
      if (commentText.isNotEmpty) {
        String token = MySharedPref.getMajalesToken();
        var headers = 'Bearer $token';
        var data = {
          "comment": commentText,
          "subjectId": widget.subjectNo,
          "token": headers,
        };
        APIController controller = APIController(
          url:
              'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/AddSubjectComment',
          requestType: RequestType.post,
          body: data,
        );

        await controller.getData();
        if (controller.apiCallStatus == ApiCallStatus.success) {
          APIController controller = APIController(
            url:
                'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/GetSubjectComments?subjectNo=${widget.subjectNo}&token=$headers',
          );
          await controller.getData();
          if (controller.apiCallStatus == ApiCallStatus.success) {
            setState(() {
              widget.data = controller.data['returnObject'];
            });
          }
        }
      }
    });
  }
}
