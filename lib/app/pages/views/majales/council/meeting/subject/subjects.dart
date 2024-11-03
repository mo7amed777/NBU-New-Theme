import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/data/models/meeting.dart';
import 'package:eservices/app/data/models/subject.dart';
import 'package:eservices/app/pages/views/majales/council/meeting/subject/subject_details.dart';
import 'package:eservices/config/theme/app_colors.dart';

class MeetingSubjects extends StatelessWidget {
  const MeetingSubjects(
      {Key? key,
      required this.data,
      this.isSubject = true,
      required this.meeting})
      : super(key: key);
  final List data;
  final bool isSubject;
  final MeetingModel meeting;
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
                          'لا يوجد مواضيع',
                          style: TextStyle(
                            color: colorPrimary,
                            fontSize: 25.sp,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: data.map(
                        ((meetSubject) {
                          SubjectModel subject =
                              SubjectModel.fromJson(meetSubject);

                          return MyCard(
                            title: subject.titleAr ?? '',
                            subTitle: subject.creationDate != null
                                ? subject.creationDate!.substring(0, 10)
                                : '',
                            fullWidth: true,
                            desc: '',
                            onTap: () {
                              Get.to(() => SubjectDetails(
                                    subjectTitle: subject.titleAr!,
                                    subjectNo: subject.id!,
                                    details: subject.details ?? '',
                                    meeting: meeting,
                                    decision: subject.decision ?? '',
                                  ));
                            },
                            icon: FontAwesomeIcons.asymmetrik,
                            margin: EdgeInsets.all(8.sp),
                          );
                        }),
                      ).toList(),
                    ),
            ),
          ),
          Positioned(
            top: Get.height * 0.066,
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
                  isSubject ? ' المواضيع الأساسية ' : ' ما يستجد من أعمال ',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
