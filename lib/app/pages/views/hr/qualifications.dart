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
import 'package:eservices/app/data/models/qualification.dart';
import 'package:eservices/app/pages/views/hr/courses.dart';
import 'package:eservices/config/theme/app_colors.dart';

class Qualifications extends StatelessWidget {
  const Qualifications({Key? key, required this.qualifications})
      : super(key: key);

  final List qualifications;

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
                child: qualifications.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/no-data.gif'),
                          ),
                          SizedBox(height: 32),
                          Text(
                            'لا يوجد لديك مؤهلات علمية',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: qualifications.map(((qualification) {
                        Qualification qualific =
                            Qualification.fromJson(qualification);
                        return MyCard(
                          title: qualific.certificateName ?? '',
                          desc: qualific.hijriCertificateDate ?? '',
                          margin: EdgeInsets.all(8.sp),
                          fullWidth: true,
                          subTitle: qualific.graduationUnitName ?? '',
                          icon: FontAwesomeIcons.award,
                          onTap: () => showDetails(
                            title: qualific.certificateName ?? '',
                            rows: [
                              CustomRow(
                                title: ' الدرجة العلمية: ',
                                trailing: qualific.certificateName!,
                              ),
                              if (qualific.mainSpecialtyDescription != null)
                                CustomRow(
                                  title: ' التخصص الرئيسي: ',
                                  trailing: qualific.mainSpecialtyDescription!,
                                ),
                              if (qualific.subSpecialtyDescription != null)
                                CustomRow(
                                  title: ' التخصص الفرعى: ',
                                  trailing: qualific.subSpecialtyDescription!,
                                ),
                              CustomRow(
                                title: ' الحصول على المؤهل: ',
                                trailing: qualific.hijriCertificateDate!,
                              ),
                              CustomRow(
                                title: ' الدولة: ',
                                trailing: qualific.countryName!,
                              ),
                              CustomRow(
                                title: ' مكان التخرج: ',
                                trailing: qualific.graduationUnitName!,
                              ),
                              if (qualific.attachmentId != null)
                                CustomRow(
                                  icon: FontAwesomeIcons.fileContract,
                                  title: 'عرض الملف',
                                  iconColor: colorLightGreen,
                                  onTap: () => viewFile(
                                      id: qualific.attachmentId.toString(),
                                      type: '2'),
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
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colorPrimary,
                ),
                child: Text(
                  'المؤهلات العلمية',
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
