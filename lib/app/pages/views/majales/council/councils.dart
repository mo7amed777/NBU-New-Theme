import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/details_dialog.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/council.dart';
import 'package:eservices/app/pages/views/majales/council/council_details.dart';
import 'package:eservices/config/theme/app_colors.dart';

class Council extends StatelessWidget {
  const Council({Key? key, required this.data, this.isMajales = false})
      : super(key: key);
  final List data;
  final bool isMajales;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: Get.height * 0.17, left: 8.w, right: 8.w),
                child: data.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  'assets/images/no-data.gif',
                                )),
                            SizedBox(height: 32),
                            Text(
                              isMajales ? 'لا يوجد مجالس' : 'لا يوجد لجان',
                              style: TextStyle(
                                color: colorPrimary,
                                fontSize: 25.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: data.map(((userCouncil) {
                        CouncilModel council =
                            CouncilModel.fromJson(userCouncil);
                        return MyCard(
                          title: council.title ?? council.mainTypeName ?? '',
                          fullWidth: true,
                          isMajales: true,
                          onTap: () {
                            Get.to(() => CounDetails(
                                counNo: council.id!,
                                counTitle:
                                    council.title ?? council.mainTypeName ?? '',
                                IsCouncil: isMajales));
                          },
                          showDetails: () => showDetails(
                            rows: [
                              CustomRow(
                                title: 'رقم المجلس / اللجنة : ',
                                trailing: council.id.toString(),
                              ),
                              CustomRow(
                                title: ' تاريخ البداية : ',
                                trailing: council.startDate ?? '',
                              ),
                              CustomRow(
                                title: 'الجهة : ',
                                trailing: council.sideName ?? '',
                              ),
                            ],
                            title: council.title ?? '',
                          ),
                          showNext: () {
                            Get.to(() => CounDetails(
                                counNo: council.id!,
                                counTitle:
                                    council.title ?? council.mainTypeName ?? '',
                                IsCouncil: isMajales));
                          },
                          subTitle: council.title ?? council.mainTypeName ?? '',
                          desc: council.startDate ?? council.sideName ?? '',
                          icon: FontAwesomeIcons.buildingColumns,
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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorPrimary,
                ),
                child: Text(
                  isMajales ? 'المجالس' : 'اللجان',
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
