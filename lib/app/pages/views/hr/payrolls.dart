import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/details_dialog.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/payroll.dart';
import 'package:eservices/app/pages/views/hr/courses.dart';
import 'package:eservices/config/theme/app_colors.dart';

class Payrolls extends StatelessWidget {
  const Payrolls({Key? key, required this.payrolls}) : super(key: key);

  final List payrolls;

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
              child: payrolls.isEmpty
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
                          'لا يوجد',
                          style: TextStyle(
                            color: colorPrimary,
                            fontSize: 25.sp,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: payrolls.map(
                        ((pay) {
                          Payroll payroll = Payroll.fromJson(pay);
                          return MyCard(
                            title: payroll.payName ?? '',
                            desc: payroll.payNumber ?? '',
                            icon: FontAwesomeIcons.solidMoneyBill1,
                            fullWidth: true,
                            margin: EdgeInsets.all(8.sp),
                            subTitle: payroll.masterPayName ??
                                payroll.periodName ??
                                '',
                            onTap: () => showDetails(
                              title: payroll.payName ?? '',
                              rows: [
                                CustomRow(
                                  title: ' رقم المسير: ',
                                  trailing: payroll.payNumber!,
                                ),
                                CustomRow(
                                  title: ' نوع المسير: ',
                                  trailing: payroll.masterPayName!,
                                ),
                                CustomRow(
                                  title: ' اجمالي الحسميات: ',
                                  trailing: payroll.totalDeduction.toString(),
                                ),
                                CustomRow(
                                  title: ' اجمالي البدلات: ',
                                  trailing:
                                      payroll.totalCompensation.toString(),
                                ),
                                CustomRow(
                                  title: ' صافي المبلغ: ',
                                  trailing: payroll.totalSalary.toString(),
                                ),
                                CustomRow(
                                  title: ' تاريخ اعداد المسير: ',
                                  trailing: payroll.payDate!,
                                ),
                                CustomRow(
                                  title: ' سنة المسير: ',
                                  trailing: payroll.gregorianYear!,
                                ),
                                CustomRow(
                                  title: ' الفترة المالية: ',
                                  trailing: payroll.periodName!,
                                ),
                              ],
                            ),
                          );
                        }),
                      ).toList(),
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
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorPrimary,
                ),
                child: Text(
                  'مسيرات الرواتب',
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
