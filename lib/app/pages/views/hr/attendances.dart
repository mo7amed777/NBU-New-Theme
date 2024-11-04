import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/details_dialog.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/data/models/attendance.dart';
import 'package:eservices/app/pages/views/hr/courses.dart';
import 'package:eservices/config/theme/app_colors.dart';

class Attendances extends StatelessWidget {
  const Attendances({Key? key, required this.attendances}) : super(key: key);

  final List attendances;

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
                child: attendances.isEmpty
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
                        children: attendances
                            .map(((attend) {
                              Attendance attendance =
                                  Attendance.fromJson(attend);
                              return MyCard(
                                  title: attendance.dateName ??
                                      attendance.transactionStatusTitle ??
                                      '',
                                  icon: FontAwesomeIcons.personCircleQuestion,
                                  margin: EdgeInsets.all(8.sp),
                                  fullWidth: true,
                                  subTitle: attendance.transactionStatusTitle ??
                                      attendance.notes ??
                                      '',
                                  desc: attendance.tranDate?.substring(0, 10) ??
                                      attendance.dateName ??
                                      '',
                                  onTap: () => showDetails(
                                          title: attendance.dateName ??
                                              attendance
                                                  .transactionStatusTitle ??
                                              '',
                                          rows: [
                                            CustomRow(
                                              title: ' تاريخ الحركة: ',
                                              trailing: attendance.tranDate!
                                                  .substring(0, 10),
                                            ),
                                            CustomRow(
                                              title: ' اليوم: ',
                                              trailing:
                                                  attendance.dateName ?? '',
                                            ),
                                            CustomRow(
                                              title: ' حالة الموظف: ',
                                              trailing: attendance
                                                      .transactionStatusTitle ??
                                                  '',
                                            ),
                                            if (attendance.notes != null)
                                              CustomRow(
                                                title: ' الملاحظات: ',
                                                trailing: attendance.notes!,
                                              ),
                                            CustomRow(
                                              title: ' بداية الدوام: ',
                                              trailing:
                                                  attendance.shiftStart ?? '',
                                            ),
                                            CustomRow(
                                              title: ' نهاية الدوام: ',
                                              trailing:
                                                  attendance.shiftEnd ?? '',
                                            ),
                                            if (attendance.clockIn != null)
                                              CustomRow(
                                                title: ' وقت الدخول: ',
                                                trailing: attendance.clockIn!,
                                              ),
                                            if (attendance.clockOut != null)
                                              CustomRow(
                                                title: ' وقت الخروج: ',
                                                trailing: attendance.clockOut!,
                                              ),
                                            if (attendance.latency != null)
                                              CustomRow(
                                                title: ' اجمالي التاخيرات: ',
                                                trailing: attendance.latency
                                                        ?.toString() ??
                                                    '',
                                              ),
                                          ]));
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
                  'الحضور والإنصراف',
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
