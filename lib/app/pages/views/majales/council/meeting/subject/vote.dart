import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';

import '../../../../../../services/api_call_status.dart';

class SubjectVote extends StatefulWidget {
  const SubjectVote(
      {Key? key, required this.data, this.voteOptions, required this.subjectNo})
      : super(key: key);
  final List data;
  final List? voteOptions;
  final int subjectNo;
  @override
  State<SubjectVote> createState() => _SubjectVoteState();
}

class _SubjectVoteState extends State<SubjectVote> {
  int? _vote;

  bool _visibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.data.isEmpty
          ? Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                Center(
                  child: Card(
                    margin: EdgeInsets.all(8.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                          padding: EdgeInsets.all(8.sp),
                          items: widget.voteOptions!
                              .map(
                                (vote) => DropdownMenuItem(
                                    value: vote['id'],
                                    alignment: Alignment.center,
                                    child: Text(vote['nameAr'])),
                              )
                              .toList(),
                          elevation: 15,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          value: _vote,
                          hint: Text(' اختر التصويت'),
                          onChanged: (vote) {
                            setState(() {
                              _vote = vote! as int?;
                              setState(() {
                                _visibility = true;
                              });
                            });
                          }),
                    ),
                  ),
                ),
                !_visibility
                    ? Container()
                    : Positioned(
                        bottom: 16.h,
                        width: Get.width * 0.75,
                        height: 35.h,
                        child: CustomButton(
                          color: colorPrimary,
                          callBack: () async {
                            String token = MySharedPref.getMajalesToken();
                            var headers = 'Bearer $token';
                            var data = {
                              "voteOptNo": _vote,
                              "subjectId": widget.subjectNo,
                              "token": headers,
                            };
                            APIController controller = APIController(
                              url:
                                  'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/AddSubjectVote',
                              requestType: RequestType.post,
                              body: data,
                            );

                            await controller.getData();
                            if (controller.apiCallStatus ==
                                ApiCallStatus.success) {
                              Get.back();
                              CustomSnackBar.showCustomSnackBar(
                                  title: 'نجاح', message: 'تم الحفظ بنجاح');
                            }
                          },
                          label: 'حفظ',
                          padding: 10,
                          fontSize: 20,
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
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: colorPrimary,
                      ),
                      child: Text(
                        'التصويت',
                        style: largeTitleStyle.copyWith(color: colorWhite),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                Positioned(
                  top: Get.height * 0.065,
                  left: 8.w,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () => Get.back(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/vote.png',
                    ),
                    Text(
                      'تم التصويت :    ${widget.data[0]['voteOpt']['nameAr']}',
                      style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: colorPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
