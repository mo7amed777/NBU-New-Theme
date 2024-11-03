import 'dart:convert';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:eservices/app/data/models/mahdar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../signature/signature_draw.dart';

class Mahder extends StatelessWidget {
  const Mahder({Key? key, required this.mahderModel}) : super(key: key);
  final MahderModel mahderModel;

  @override
  Widget build(BuildContext context) {
    if (mahderModel.users != null) {
      mahderModel.users!.sort((a, b) => a.order!.compareTo(b.order!));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                children: [
                  Image.asset('assets/images/mahder.jpg'),
                  mahderModel.meetingDedails != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: mahderText(
                              text: mahderModel.meetingDedails?.first.titleAr ??
                                  '',
                              fontSize: 12.0),
                        )
                      : Container(),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      mahderText(
                          text:
                              'المكان : ${mahderModel.meetingDedails?.first.place ?? ''}  ',
                          setFontFamily: false),
                      mahderText(
                          text:
                              'الوقت : ${mahderModel.meetingDedails?.first.startTime ?? ''}  ',
                          setFontFamily: false),
                      mahderText(
                          text:
                              'بتاريخ : ${mahderModel.meetingDedails?.first.date?.substring(0, 10) ?? ''}  ',
                          setFontFamily: false),
                      mahderText(
                          text:
                              'الموافق : ${mahderModel.meetingDedails?.first.hgDate?.substring(0, 10) ?? ''}   هـ ',
                          setFontFamily: false),
                    ],
                  ),
                  mahderModel.meetingDedails != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: mahderText(
                              text:
                                  mahderModel.meetingDedails?.first.intro ?? '',
                              fontSize: 12.0),
                        )
                      : Container(),
                  mahderModel.users != null
                      ? getTable(mahderModel, 3)
                      : Container(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: mahderText(
                        text:
                            mahderModel.meetingDedails?.first.startHeader ?? '',
                        fontSize: 12.0),
                  ),
                  mahderModel.mainMeetingSubject != null
                      ? Column(
                          children: mahderModel.mainMeetingSubject!
                              .map(((mainSubject) {
                          return SubjectContent(
                            title: mainSubject.titleAr ?? '',
                            order: mainSubject.orderName ?? '',
                            decision: mainSubject.decision,
                            decisionType: mainSubject.decisionTypeNameAr,
                            details: mainSubject.details,
                          );
                        })).toList())
                      : Container(),
                  Divider(
                    height: 8.h,
                    thickness: 2.sp,
                    indent: 0.w,
                    color: Colors.black26,
                  ),
                  mahderModel.users != null
                      ? getTable(mahderModel, 5)
                      : Container(),
                  Divider(
                    height: 8.h,
                    thickness: 2.sp,
                    indent: 0.w,
                    color: Colors.black26,
                  ),
                  (getSignNotesTable(mahderModel).users != null &&
                          getSignNotesTable(mahderModel).users!.isNotEmpty)
                      ? getTable(getSignNotesTable(mahderModel), 2)
                      : Container(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 32.h,
            left: 0.w,
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.circleXmark,
                color: Colors.red,
              ),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}

MahderModel getSignNotesTable(MahderModel mahderModel) {
  List<Users> noteUsers = [];
  for (var user in mahderModel.users!) {
    if (user.signNote != null && user.signNote!.isNotEmpty) noteUsers.add(user);
  }
  mahderModel.setUsers(noteUsers);
  return mahderModel;
}

Padding getTable(MahderModel mahderModel, int coulmns) {
  //Remove Not Attended Users from Mahder
  mahderModel.setUsers(mahderModel.users!
      .where(
        (user) => user.attendanceStatusId == 1 || user.attendanceStatusId == 0,
      )
      .toList());
  if (mahderModel.users!.isEmpty) return Padding(padding: EdgeInsets.all(0));
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Table(
        border: TableBorder(
          right: BorderSide(),
          left: BorderSide(),
          top: BorderSide(),
          bottom: BorderSide(),
          horizontalInside: BorderSide(),
          verticalInside: BorderSide(),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: mahderModel.users!.map((user) {
          Uint8List? base64Data;
          if ((user.isSigned ?? false)) {
            if (user.sign!.contains(base64Code)) {
              user.sign = user.sign!.replaceRange(0, 22, '');
            }
            base64Data = base64Decode(
              user.sign!,
            );
          }

          return TableRow(children: [
            Padding(
              padding: EdgeInsets.all(4.sp),
              child: mahderText(
                  text: user.userNameAr ?? '', textAlign: TextAlign.center),
            ),
            if (coulmns > 2)
              Padding(
                padding: EdgeInsets.all(4.sp),
                child: mahderText(
                    text: user.jobTitle ?? '', textAlign: TextAlign.center),
              ),
            if (coulmns > 2)
              Padding(
                padding: EdgeInsets.all(4.sp),
                child: mahderText(
                    text: user.privilegeNameAr ?? '',
                    textAlign: TextAlign.center),
              ),
            if (coulmns == 5)
              Padding(
                padding: EdgeInsets.all(4.sp),
                child: (user.isSigned ?? false)
                    ? Image.memory(base64Data!)
                    : Container(),
              ),
            if (coulmns == 5)
              Padding(
                padding: EdgeInsets.all(4.sp),
                child: mahderText(
                    text: (user.isSigned ?? false)
                        ? user.signDate!.substring(0, 10)
                        : '',
                    textAlign: TextAlign.center),
              ),
            if (coulmns == 2)
              Padding(
                padding: EdgeInsets.all(4.sp),
                child: mahderText(
                    text: user.signNote ?? '', textAlign: TextAlign.center),
              ),
          ]);
        }).toList()
          ..insert(
            0,
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.sp),
                  child: mahderText(
                      text: 'اسم العضو', textAlign: TextAlign.center),
                ),
                if (coulmns > 2)
                  Padding(
                    padding: EdgeInsets.all(4.sp),
                    child:
                        mahderText(text: 'المسمى', textAlign: TextAlign.center),
                  ),
                if (coulmns > 2)
                  Padding(
                    padding: EdgeInsets.all(4.sp),
                    child:
                        mahderText(text: 'الصفة', textAlign: TextAlign.center),
                  ),
                if (coulmns == 5)
                  Padding(
                    padding: EdgeInsets.all(4.sp),
                    child: mahderText(
                        text: 'التوقيع', textAlign: TextAlign.center),
                  ),
                if (coulmns == 5)
                  Padding(
                    padding: EdgeInsets.all(4.sp),
                    child: mahderText(
                        text: 'تاريخ التوقيع', textAlign: TextAlign.center),
                  ),
                if (coulmns == 2)
                  Padding(
                    padding: EdgeInsets.all(4.sp),
                    child: mahderText(
                        text: 'التحفظات', textAlign: TextAlign.center),
                  ),
              ],
            ),
          ),
      ));
}

Widget SubjectContent(
        {required String title,
        required String order,
        String? details,
        String? decision,
        String? decisionType}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 8.h,
          thickness: 2.sp,
          indent: 0.w,
          color: Colors.black26,
        ),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "الموضوع $order :  ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontFamily: 'AL-MOHANAD_BOLD',
              ),
            ),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AL-MOHANAD_BOLD',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        details == null
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " التفاصيل : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontFamily: 'AL-MOHANAD_BOLD',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  HtmlWidget(details),
                ],
              ),
        SizedBox(height: 16.h),
        decision == null
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " $decisionType : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontFamily: 'AL-MOHANAD_BOLD',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  HtmlWidget(decision),
                ],
              ),
      ],
    );

Text mahderText(
        {required String text,
        double fontSize = 10,
        TextAlign textAlign = TextAlign.justify,
        bool setFontFamily = true}) =>
    Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize.sp,
        fontFamily: setFontFamily ? 'AL-MOHANAD_BOLD' : 'NeoSans-AR',
      ),
    );
