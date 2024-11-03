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
import 'package:eservices/app/data/models/schedule.dart';
import 'package:eservices/config/theme/app_colors.dart';

import '../../../data/models/academic_schedule.dart';

class Schedule extends StatelessWidget {
  Schedule({Key? key, required this.data, this.isAcademic = false})
      : super(key: key);
  final List data;
  final bool isAcademic;

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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/no-data.gif'),
                        ),
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
                      children: data.map(((course) {
                      var crs;
                      if (isAcademic) {
                        crs = AcadmicScheduleModel.fromJson(course);
                      } else {
                        crs = ScheduleModel.fromJson(course);
                      }
                      return MyCard(
                        title: isAcademic
                            ? crs.scbcrsETITLE ?? ''
                            : crs.courseName ?? '',
                        desc: isAcademic
                            ? crs.colLDESC ?? crs.crn
                            : crs.room ?? crs.build ?? crs.courseNo,
                        icon: FontAwesomeIcons.calendarCheck,
                        fullWidth: true,
                        margin: EdgeInsets.all(8.sp),
                        subTitle:
                            isAcademic ? crs.sirasgNPERCENTRESPONSE : crs.days,
                        onTap: () => showDetails(
                          title: isAcademic
                              ? crs.scbcrsETITLE ?? ''
                              : crs.courseName ?? '',
                          rows: [
                            CustomRow(
                              title: ' رمز المقرر : ',
                              trailing: isAcademic
                                  ? crs.coursENO ?? ''
                                  : crs.courseNo ?? '',
                            ),
                            CustomRow(
                              title: ' الرقم : ',
                              trailing:
                                  isAcademic ? crs.crn ?? '' : crs.crm ?? '',
                            ),
                            CustomRow(
                              title: ' اسم المقرر :  ',
                              trailing: isAcademic
                                  ? crs.scbcrsETITLE ?? ''
                                  : crs.courseName ?? '',
                            ),
                            isAcademic
                                ? CustomRow(
                                    title: ' العبئ :  ',
                                    trailing: crs.calculated ?? '',
                                  )
                                : CustomRow(
                                    title: ' الشعبة :  ',
                                    trailing: crs.division ?? '',
                                  ),
                            CustomRow(
                              title: ' الوحدات :  ',
                              trailing: isAcademic
                                  ? crs.hours ?? ''
                                  : crs.unit.toString(),
                            ),
                            CustomRow(
                              title: ' النشاط :  ',
                              trailing: isAcademic
                                  ? crs.typeofclass ?? ''
                                  : crs.activite ?? '',
                            ),
                            if (isAcademic)
                              CustomRow(
                                title: ' نسبة المسؤولية :  ',
                                trailing: crs.sirasgNPERCENTRESPONSE ?? '',
                              ),
                            CustomRow(
                              title: ' الأيام :  ',
                              trailing: crs.days ?? '',
                            ),
                            CustomRow(
                              title: ' الوقت :  ',
                              trailing: crs.time ?? '',
                            ),
                            CustomRow(
                              title: ' المبنى :  ',
                              trailing: isAcademic
                                  ? crs.colLDESC ?? ''
                                  : crs.build ?? '',
                            ),
                            CustomRow(
                              title: ' القاعة :  ',
                              trailing: crs.room ?? '',
                            ),
                          ],
                        ),
                      );
                    })).toList()),
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
                  'الجدول الدراسي',
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
