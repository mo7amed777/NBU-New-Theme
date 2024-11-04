import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/details_dialog.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/data/models/leave_request.dart';
import 'package:eservices/app/pages/views/hr/courses.dart';
import 'package:eservices/config/theme/app_colors.dart';

class LeaveRequests extends StatelessWidget {
  const LeaveRequests({Key? key, required this.requests}) : super(key: key);

  final List requests;

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
                child: requests.isEmpty
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
                            'لا يوجد لديك بيانات',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: requests
                            .map(((req) {
                              LeaveRequest request = LeaveRequest.fromJson(req);
                              return MyCard(
                                title: request.kind ?? request.execusKind ?? '',
                                desc: request.leaveDate?.substring(0, 10) ?? '',
                                icon: FontAwesomeIcons.personWalking,
                                fullWidth: true,
                                margin: EdgeInsets.all(8.sp),
                                subTitle: request.reason ?? '',
                                onTap: () => showDetails(
                                  title:
                                      request.kind ?? request.execusKind ?? '',
                                  rows: [
                                    CustomRow(
                                      title: ' رقم الإذن: ',
                                      trailing: request.reqNO.toString(),
                                    ),
                                    CustomRow(
                                      title: ' نوع الإذن: ',
                                      trailing: request.kind ?? '',
                                    ),
                                    CustomRow(
                                      title: ' طبيعة الإذن: ',
                                      trailing: request.execusKind ?? '',
                                    ),
                                    CustomRow(
                                      title: ' تاريخ الإذن: ',
                                      trailing:
                                          request.leaveDate?.substring(0, 10) ??
                                              '',
                                    ),
                                    CustomRow(
                                      title: ' وقت الخروج: ',
                                      trailing: request.leaveTime ?? '',
                                    ),
                                    CustomRow(
                                      title: ' وقت العودة: ',
                                      trailing: request.returnTime ?? '',
                                    ),
                                    CustomRow(
                                      title: ' حالة الطلب: ',
                                      trailing:
                                          request.leaveExcuseApprovalStatus ??
                                              '',
                                    ),
                                    if (request.mangerUserName != null)
                                      CustomRow(
                                        title: ' الرئيس المباشر: ',
                                        trailing: request.mangerUserName!,
                                      ),
                                    CustomRow(
                                      title: ' بصمة الدخول: ',
                                      trailing: request.actaulIN ?? '',
                                    ),
                                    CustomRow(
                                      title: ' بصمة الخروج: ',
                                      trailing: request.actaulOUT ?? '',
                                    ),
                                    CustomRow(
                                      title: "سبب الإذن: ",
                                      trailing: request.reason ?? "",
                                    ),
                                  ],
                                ),
                              );
                            }))
                            .toList()
                            .reversed
                            .toList())),
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
                  'طلبات الإستئذان',
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
