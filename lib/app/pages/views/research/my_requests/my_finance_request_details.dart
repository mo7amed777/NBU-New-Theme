import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/finance_request_details.dart';
import 'package:eservices/app/data/models/support_data.dart';
import 'package:eservices/app/pages/views/majales/council/documents.dart';
import 'package:eservices/app/pages/views/support_me/request_details.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class MyFinanceRequestDetails extends StatelessWidget {
  final FinanceRequestDetails requestDetails;
  const MyFinanceRequestDetails({super.key, required this.requestDetails});

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
              child: Column(children: [
                if (requestDetails.requestInfo != null)
                  TapToExpand(
                    content: Column(
                      children: [
                        CustomRow(
                          title: "الإسم",
                          trailing:
                              requestDetails.requestInfo!.employeeName ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "رقم السجل / الهوية",
                          trailing:
                              requestDetails.requestInfo!.employeeNid ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "الإيميل الشخصي",
                          trailing:
                              requestDetails.requestInfo!.employeeEmail ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "الرقم الوظيفي",
                          trailing: requestDetails.requestInfo!.jobCode ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "الكلية",
                          trailing:
                              requestDetails.requestInfo!.collegeName ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "القسم",
                          trailing:
                              requestDetails.requestInfo!.sectionName ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        if (requestDetails.requestInfo!.financeRequestType !=
                            4) ...[
                          CustomRow(
                            title: "الرتبة العلمية",
                            trailing:
                                requestDetails.requestInfo!.jobRankName ?? '',
                            padding: EdgeInsets.all(8.sp),
                          ),
                          CustomRow(
                            title: "رقم الجوال",
                            trailing:
                                requestDetails.requestInfo!.employeePhone ?? '',
                            padding: EdgeInsets.all(8.sp),
                          ),
                          CustomRow(
                            title: "رقم المشروع",
                            isLast: true,
                            trailing:
                                requestDetails.requestInfo!.projectId ?? '',
                            padding: EdgeInsets.all(8.sp),
                          ),
                        ],
                        if (requestDetails.requestInfo!.financeRequestType ==
                            4) ...[
                          CustomRow(
                            title: "رقم قرار الابتعاث",
                            trailing:
                                requestDetails.requestInfo!.scholarshipId ?? '',
                            padding: EdgeInsets.all(8.sp),
                          ),
                          CustomRow(
                            title: "الدرجة المبتعث لها",
                            trailing:
                                requestDetails.requestInfo!.scholarshipDegree ??
                                    '',
                            padding: EdgeInsets.all(8.sp),
                          ),
                          CustomRow(
                            title: "الدولة المبتعث لها",
                            trailing: requestDetails
                                    .requestInfo!.scholarshipCountry ??
                                '',
                            padding: EdgeInsets.all(8.sp),
                          ),
                          CustomRow(
                            title: "تاريخ إنتهاء البعثة",
                            isLast: true,
                            trailing: requestDetails
                                    .requestInfo!.scholarshipEndDate ??
                                '',
                            padding: EdgeInsets.all(8.sp),
                          ),
                        ],
                      ],
                    ),
                    title: Text(
                      'بياناتي الشخصية',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 16.sp,
                      ),
                    ),
                    isScrollable: false,
                    borderRadius: BorderRadius.circular(25),
                    width: Get.width,
                    openedHeight: Get.height,
                    outerClosedPadding: 4.0,
                    outerOpenedPadding: 4.0,
                    backgroundcolor: Colors.white,
                    iconColor: colorPrimary,
                  ),
                SizedBox(height: 10.h),
                if (requestDetails.requestInfo != null)
                  TapToExpand(
                    content: Column(
                      children: [
                        CustomRow(
                          title: "عنوان البحث",
                          trailing: requestDetails.requestInfo!.title ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "الاولوية البحثية التي يندرج تحتها البحث",
                          trailing: requestDetails
                                  .requestInfo!.arNameFinancePriorty ??
                              '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "اسم المجلة العلمية",
                          trailing:
                              requestDetails.requestInfo!.magazineName ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "مجال تخصص المجلة",
                          trailing: requestDetails
                                  .requestInfo!.magazineSubjectCategory ??
                              '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "الموقع الالكتروني للمجلة",
                          trailing:
                              requestDetails.requestInfo!.magazineUrl ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "الرقم التسلسلي الدولي الموحد (ISSN)",
                          trailing: requestDetails.requestInfo!.issn ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "عدد المشاركين الكلي",
                          trailing: requestDetails
                              .requestInfo!.totalCountParticipant
                              .toString(),
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "من الجامعة",
                          trailing: requestDetails
                              .requestInfo!.universityParticipantCount
                              .toString(),
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "من خارج الجامعة",
                          trailing: requestDetails
                              .requestInfo!.outsideUnivertstParticipantCount
                              .toString(),
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "الحالة",
                          trailing:
                              requestDetails.requestInfo!.arNameFinanceStatus ??
                                  '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "التاريخ",
                          trailing: requestDetails.requestInfo!.date ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        if (requestDetails.requestInfo!.financeRequestType != 4)
                          CustomRow(
                            title: "دور مقدم الطلب",
                            trailing: requestDetails
                                    .requestInfo!.arNameApplicantRole ??
                                '',
                            padding: EdgeInsets.all(8.sp),
                          ),
                        CustomRow(
                          title: requestDetails.requestInfo!.isAcceptedFromNBU!
                              ? 'تم قبول البحث للنشر خلال عملك في جامعة الحدود الشمالية'
                              : 'لم يتم دعم البحث من أي جهة أخرى بالجامعة',
                          icon: FontAwesomeIcons.check,
                          iconColor: colorLightGreen,
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "تاريخ قبول النشر النهائي للبحث",
                          trailing: requestDetails.requestInfo!
                                  .finalPublicationAcceptanceDate ??
                              '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "اسم البنك",
                          trailing: requestDetails.requestInfo!.bank ?? '',
                          padding: EdgeInsets.all(8.sp),
                        ),
                        CustomRow(
                          title: "رقم الايبان",
                          trailing: requestDetails.requestInfo!.iban ?? '',
                          padding: EdgeInsets.all(8.sp),
                          isLast: true,
                        ),
                      ],
                    ),
                    title: Text(
                      'بيانات البحث',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 16.sp,
                      ),
                    ),
                    isScrollable: false,
                    borderRadius: BorderRadius.circular(25),
                    width: Get.width,
                    openedHeight: Get.height,
                    outerClosedPadding: 4.0,
                    outerOpenedPadding: 4.0,
                    backgroundcolor: Colors.white,
                    iconColor: colorPrimary,
                  ),
                SizedBox(height: 10.h),
                if (requestDetails.requestAttachment != null)
                  TapToExpand(
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: requestDetails.requestAttachment!
                          .map((attachment) => Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '# ${attachment.type}',
                                      style: TextStyle(
                                        color: colorBlack,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      attachment.type == 1
                                          ? 'مرفق القبول'
                                          : 'مرفق البحث',
                                      style: TextStyle(
                                        color: attachment.type == 1
                                            ? colorLightGreen
                                            : colorPrimary,
                                        fontSize: 16.sp,
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
                                            MySharedPref.getResearchToken();
                                        String ext =
                                            attachment.extention!.substring(1);
                                        openDocument(
                                          ext,
                                          attachment.path!,
                                          attachment.type == 1
                                              ? 'مرفق القبول'
                                              : 'مرفق البحث',
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
                    isScrollable: false,
                    borderRadius: BorderRadius.circular(25),
                    width: Get.width,
                    openedHeight: Get.height,
                    outerClosedPadding: 4.0,
                    outerOpenedPadding: 4.0,
                    backgroundcolor: Colors.white,
                    iconColor: colorPrimary,
                  ),
                SizedBox(height: 10.h),
                if (requestDetails.workFlowTask != null)
                  TapToExpand(
                    title: Text(
                      'سير العمل',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 14.sp,
                      ),
                    ),
                    isScrollable: false,
                    borderRadius: BorderRadius.circular(25),
                    width: Get.width,
                    openedHeight: Get.height,
                    outerClosedPadding: 4.0,
                    outerOpenedPadding: 4.0,
                    backgroundcolor: Colors.white,
                    iconColor: colorPrimary,
                    content: Table(
                      border: TableBorder.all(
                        width: 1.0,
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      children: requestDetails.workFlowTask!
                          .map((task) => TableRow(children: [
                                getText(task.fromUserName ?? '',
                                    color: colorBlack),
                                getText(task.toUserName ?? '',
                                    color: colorBlack),
                                getText(task.date ?? '', color: colorBlack),
                                getText(
                                    task.approveType == 1
                                        ? 'مصادقة القسم'
                                        : "مصادقة لجنة التوصيات",
                                    color: colorBlack),
                                getText(
                                  task.approveStatus == 1
                                      ? 'قيد الانتظار'
                                      : task.approveStatus == 2
                                          ? 'مقبول'
                                          : 'مرفوض',
                                  color: task.approveStatus == 1
                                      ? Colors.orange
                                      : task.approveStatus == 2
                                          ? colorLightGreen
                                          : colorRed,
                                ),
                              ]))
                          .toList()
                        ..insert(
                            0,
                            TableRow(children: [
                              getText(
                                'من',
                                color: colorPrimary,
                              ),
                              getText(
                                'إلى',
                                color: colorPrimary,
                              ),
                              getText(
                                'التاريخ',
                                color: colorPrimary,
                              ),
                              getText(
                                'النوع',
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
              ]),
            ),
          ),
          Positioned(
            top: Get.height * 0.066,
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
                  'تفاصيل الطلب',
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
}
