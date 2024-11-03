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
import 'package:eservices/app/data/models/decision.dart';
import 'package:eservices/app/pages/views/hr/courses.dart';
import 'package:eservices/config/theme/app_colors.dart';

class Decisions extends StatelessWidget {
  const Decisions({Key? key, required this.decisions}) : super(key: key);

  final List decisions;

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
                child: decisions.isEmpty
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
                        children: decisions.map(((dec) {
                        Decision decision = Decision.fromJson(dec);
                        return MyCard(
                          title: decision.decisionName ?? '',
                          desc: decision.effectiveDate ?? '',
                          subTitle: decision.presenceDate ?? '',
                          icon: FontAwesomeIcons.envelopeCircleCheck,
                          fullWidth: true,
                          margin: EdgeInsets.all(8.sp),
                          onTap: () => showDetails(
                            title: decision.decisionName ?? '',
                            rows: [
                              CustomRow(
                                title: ' رقم القرار: ',
                                trailing: decision.decisionNO!,
                              ),
                              CustomRow(
                                title: ' إسم القرار: ',
                                trailing: decision.decisionName!,
                              ),
                              CustomRow(
                                title: ' بداية القرار: ',
                                trailing: decision.fromDate ?? '',
                              ),
                              CustomRow(
                                title: ' نهاية القرار: ',
                                trailing: decision.toDate ?? '',
                              ),
                              CustomRow(
                                title: ' تاريخ المباشرة: ',
                                trailing: decision.presenceDate ?? '',
                              ),
                              CustomRow(
                                title: ' تنفيذ القرار: ',
                                trailing: decision.effectiveDate ?? '',
                              ),
                              CustomRow(
                                title: ' الراتب الأساسي: ',
                                trailing: decision.basicSalary.toString(),
                              ),
                            ],
                          ),
                        );
                      })).toList())),
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
                  'القرارات المعتمدة',
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
