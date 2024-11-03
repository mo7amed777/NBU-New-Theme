import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/support_data.dart';
import 'package:eservices/app/pages/views/majales/council/documents.dart';
import 'package:eservices/app/pages/views/support_me/requests.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class RequestDetails extends StatelessWidget {
  final SupportData supportData;
  const RequestDetails({super.key, required this.supportData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.17, left: 10.w, right: 10.w),
              child: Column(
                children: [
                  buildHeadline(text: 'تفاصيل التذكرة'),
                  Card(
                      color: colorWhite,
                      elevation: 5,
                      margin: EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomRow(
                                title: ' رقم التذكرة: ',
                                trailing:
                                    supportData.requestInfo!.id.toString(),
                              ),
                              CustomRow(
                                title: ' عنوان التذكرة: ',
                                trailing: supportData.requestInfo!.title ?? '',
                              ),
                              if (supportData.requestInfo!.notes != null)
                                buildNotes(
                                    title: ' تفاصيل التذكرة: ',
                                    notes: supportData.requestInfo!.notes!),
                              CustomRow(
                                title: ' جهة عمل مقدم التذكرة: ',
                                trailing: supportData.requestInfo!
                                        .workBesideUserCreateRequestNameAr ??
                                    '',
                                hasDivider: true,
                              ),
                              CustomRow(
                                title: ' الجهة: ',
                                trailing: supportData
                                        .requestInfo!.parentWorkBesideNameAr ??
                                    '',
                              ),
                              CustomRow(
                                title: ' التاريخ: ',
                                trailing: supportData.requestInfo!.date ?? '',
                              ),
                              CustomRow(
                                title: ' النوع: ',
                                trailing: supportData
                                        .requestInfo!.requestTypeNameAr ??
                                    '',
                              ),
                              CustomRow(
                                title: ' الخدمة: ',
                                trailing:
                                    supportData.requestInfo!.serviceNameAr ??
                                        '',
                              ),
                              if (supportData.requestInfo!.executionPlace !=
                                  null)
                                CustomRow(
                                  title: ' مكان التنفيذ: ',
                                  trailing:
                                      supportData.requestInfo!.executionPlace ??
                                          '',
                                ),
                              if (supportData.requestInfo!.executedDate != null)
                                CustomRow(
                                  title: ' تاريخ الزيارة: ',
                                  trailing:
                                      supportData.requestInfo!.executedDate ??
                                          '',
                                ),
                              if (supportData.requestInfo!.executedTime != null)
                                CustomRow(
                                  title: ' وقت الزيارة: ',
                                  trailing:
                                      supportData.requestInfo!.executedTime ??
                                          '',
                                ),
                              CustomRow(
                                title: ' الحالة: ',
                                trailing:
                                    supportData.requestInfo!.statusNameAr ?? '',
                              ),
                              SizedBox(height: 8.h),
                              supportData.requestInfo!.rate == null
                                  ? CustomRow(
                                      title: ' التقييم: ',
                                      trailing: 'لا يوجد',
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: 12.w,
                                          ),
                                          child: Text(
                                            ' التقييم: ',
                                            style: appTextStyle.copyWith(
                                              color: colorPrimary,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                                supportData.requestInfo!.rate ??
                                                    0,
                                                (_) => Icon(
                                                      Icons.star,
                                                      color: Colors.yellow[700],
                                                      size: 15.sp,
                                                    )),
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 8.h),
                              supportData.requestInfo!.rateNotes == null
                                  ? CustomRow(
                                      title: 'ملاحظات التقييم: ',
                                      trailing: 'لا يوجد',
                                      isLast: true,
                                    )
                                  : buildNotes(
                                      title: 'ملاحظات التقييم',
                                      notes:
                                          supportData.requestInfo!.rateNotes ??
                                              'لا يوجد'),
                            ]),
                      )),
                  SizedBox(height: 10.h),
                  if (supportData.requestAttachment != null &&
                      supportData.requestAttachment!.isNotEmpty) ...[
                    TapToExpand(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: supportData.requestAttachment!
                            .map((attachment) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '# ${(supportData.requestAttachment!.indexOf(attachment) + 1)}',
                                        style: TextStyle(
                                          color: colorBlack,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        color: colorLightGreen,
                                        icon: Icon(
                                          FontAwesomeIcons.fileContract,
                                          size: 20.sp,
                                        ),
                                        onPressed: () {
                                          String token =
                                              MySharedPref.getSupportMeToken();
                                          String ext = attachment.extention!
                                              .substring(1);
                                          openDocument(
                                            ext,
                                            attachment.path!,
                                            'Request_Attachment${attachment.id}',
                                            {
                                              'Authorization': 'Bearer $token',
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                      title: Text(
                        'المرفقات',
                        style: TextStyle(
                          color: colorPrimary,
                          fontSize: 16.sp,
                        ),
                      ),
                      closedHeight: 60.h,
                      isScrollable: true,
                      borderRadius: BorderRadius.circular(25),
                      width: Get.width,
                      outerClosedPadding: 0.0,
                      outerOpenedPadding: 4.0,
                      openedHeight: 200.h,
                      backgroundcolor: Colors.white,
                      iconColor: colorPrimary,
                    ),
                    // buildHeadline(text: 'المرفقات'),
                    SizedBox(height: 10.h),
                  ],
                  //...[] to add more widgets depending on if condition
                  if (supportData.workFlowTask != null &&
                      supportData.workFlowTask!.isNotEmpty) ...[
                    // buildHeadline(text: 'تفاصيل سير العمل علي التذكرة'),

                    TapToExpand(
                      title: Text(
                        'تفاصيل سير العمل علي التذكرة',
                        style: TextStyle(
                          color: colorPrimary,
                          fontSize: 14.sp,
                        ),
                      ),
                      closedHeight: 60.h,
                      isScrollable: true,
                      borderRadius: BorderRadius.circular(25),
                      width: Get.width,
                      outerClosedPadding: 0.0,
                      outerOpenedPadding: 2.0,
                      openedHeight: 200.h,
                      backgroundcolor: Colors.white,
                      iconColor: colorPrimary,
                      content: Table(
                        border: TableBorder.all(
                          width: 1.0,
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        children: supportData.workFlowTask!
                            .map((task) => TableRow(children: [
                                  getText(task.workBesideNameAr ?? '',
                                      color: colorBlack),
                                  getText(task.createdByNameAr ?? '',
                                      color: colorBlack),
                                  getText(task.userNameAr ?? '',
                                      color: colorBlack),
                                  getText(task.date ?? '', color: colorBlack),
                                  getText(task.statusNameAr ?? '',
                                      color: colorBlack),
                                ]))
                            .toList()
                          ..insert(
                              0,
                              TableRow(children: [
                                getText(
                                  'الجهة',
                                  color: colorPrimary,
                                ),
                                getText(
                                  'مسنده من',
                                  color: colorPrimary,
                                ),
                                getText(
                                  'مسنده الي',
                                  color: colorPrimary,
                                ),
                                getText(
                                  'التاريخ',
                                  color: colorPrimary,
                                ),
                                getText(
                                  'الحالة',
                                  color: colorPrimary,
                                ),
                              ])),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                  if (supportData.taskNotes != null &&
                      supportData.taskNotes!.isNotEmpty) ...[
                    // buildHeadline(text: 'الملاحظات'),
                    TapToExpand(
                      title: Text(
                        'الملاحظات',
                        style: TextStyle(
                          color: colorPrimary,
                          fontSize: 16.sp,
                        ),
                      ),
                      closedHeight: 60.h,
                      isScrollable: true,
                      borderRadius: BorderRadius.circular(25),
                      width: Get.width,
                      outerClosedPadding: 0.0,
                      outerOpenedPadding: 4.0,
                      openedHeight: 200.h,
                      backgroundcolor: Colors.white,
                      iconColor: colorPrimary,
                      content: Table(
                        border: TableBorder.all(
                          width: 1.0,
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        children: supportData.taskNotes!
                            .map((note) => TableRow(children: [
                                  note.notes == null
                                      ? getText('لا يوجد', color: colorBlack)
                                      : Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: HtmlWidget(note.notes!),
                                        ),
                                  getText(note.createdByNameAr ?? '',
                                      color: colorBlack),
                                  getText(note.date ?? '', color: colorBlack),
                                  IconButton(
                                    color: colorLightGreen,
                                    icon: Icon(
                                      FontAwesomeIcons.fileContract,
                                      size: 25.0,
                                    ),
                                    onPressed: () {
                                      String token =
                                          MySharedPref.getSupportMeToken();
                                      String ext = note.extention!.substring(1);
                                      openDocument(
                                        ext,
                                        note.path!,
                                        'TaskNote${note.id}',
                                        {
                                          'Authorization': 'Bearer $token',
                                        },
                                      );
                                    },
                                  ),
                                ]))
                            .toList()
                          ..insert(
                              0,
                              TableRow(children: [
                                getText(
                                  'الملاحظات',
                                  color: colorPrimary,
                                ),
                                getText(
                                  'المستخدم',
                                  color: colorPrimary,
                                ),
                                getText(
                                  'التاريخ',
                                  color: colorPrimary,
                                ),
                                getText(
                                  'المرفقات',
                                  color: colorPrimary,
                                ),
                              ])),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ]
                ],
              ),
            ),
          ),
          Positioned(
            top: supportData.requestInfo!.title!.length >= 44
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
                  supportData.requestInfo!.title ?? '',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getText(String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color ?? colorPrimary,
          fontSize: text.contains('-') && text.length == 10 ? 8.sp : 9.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding buildHeadline({required String text}) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: text.length > 20 ? 20.sp : 60.sp),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 1.0,
              color: Colors.black38,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              style: TextStyle(
                color: colorPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1.0,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotes({required String title, required String notes}) => Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 10.w, top: 8.sp),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: colorPrimary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4.sp),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: HtmlWidget(notes),
              ),
            ],
          ),
        ),
      );
}
