import 'package:eservices/app/components/custom_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/users/student.dart';
import 'package:eservices/app/data/models/users/user.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

class IDCard extends StatelessWidget {
  dynamic user;
  Uint8List? image;
  String userType;
  IDCard({Key? key, required this.user, required this.userType, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.sp, left: 12.sp, right: 12.sp),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/card.png',
            ),
          ),
          Positioned(
              top: 67.h,
              left: 0,
              right: 0,
              child: userType != "student" && image!.isNotEmpty
                  ? Container(
                      height: 115.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorWhite,
                      ),
                      child: Center(
                        child: RepaintBoundary(child: Image.memory(image!)),
                      ),
                    )
                  : Container(
                      height: 115.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorWhite,
                      ),
                      child: Center(
                        child: Image.asset(((user is Student)
                                ? user.gender == "F"
                                : user.sexTypeName != "ذكر")
                            ? 'assets/images/female.png'
                            : 'assets/images/male.png'),
                      ),
                    )),
          Positioned(
            bottom: 25.h,
            left: 10.w,
            // right: 1,
            child: Container(
              height: 75.h,
              width: 75.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: colorWhite,
              ),
              child: Center(
                child: QrImageView(
                  data: userType == "student"
                      ? getQRData(isUser: false)
                      : getQRData(isUser: true),
                  version: QrVersions.auto,
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.225,
            left: 1,
            right: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: (userType == "student" && user.firstNameEn == null)
                        ? 55.h
                        : 45.h),
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Text(
                    userType == "student"
                        ? getUserName(
                            '${user.firstNameAr ?? ''} ${user.midNameAr ?? ''} ${user.lastNameAr ?? ''}',
                            40)
                        : getUserName(user.arabicName ?? '', 40),
                    style: mediumTitleStyle.copyWith(
                      color: colorPrimary,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                (userType == "student" && user.firstNameEn == null)
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text(
                          userType == "student"
                              ? getUserName(
                                  '${user.firstNameEn ?? ''} ${user.midNameEn ?? ''} ${user.lastNameEn ?? ''}',
                                  40)
                              : getUserName(user.latinFullName ?? '', 40),
                          style: mediumTitleStyle.copyWith(
                            color: colorPrimary,
                          ),
                        ),
                      ),
                SizedBox(height: 16.h),
                CustomRow(
                  title: 'الرقم الوظيفي: ',
                  //typeEn: ':Employee ID ',
                  trailing: userType == "student"
                      ? user.id ?? ''
                      : user.recordNumber ?? '',
                  // infoEn: userType == "student"
                  //     ? user.id ?? ''
                  //     : user.employeeid.toString(),
                ),
                CustomRow(
                  title: 'الوظيفة: ',
                  //typeEn: ':Profession ',
                  trailing:
                      userType == "student" ? "طالب" : user.lastJobName ?? '',
                  // infoEn: userType == "student"
                  //     ? "Student"
                  //     : user.lastJobName ?? '',
                ),
                CustomRow(
                  title: 'السجل المدني/الإقامة: ',
                  //typeEn: ':National/Residence ID ',
                  trailing: userType == "student"
                      ? user.nid ?? ''
                      : user.assignmentCivilRecordNumber ?? '',
                  // infoEn: userType == "student"
                  //     ? user.nid ?? ''
                  //     : user.assignmentCivilRecordNumber ?? '',
                ),
                CustomRow(
                  title: 'الكلية/الإدارة: ',
                  //typeEn: ':Dep./College ',
                  trailing: userType == "student"
                      ? user.collegeName ?? ''
                      : user.employeeDepartmentUnitName ?? '',
                  // infoEn: userType == "student"
                  //     ? user.collegeName ?? ''
                  //     : user.employeeDepartmentUnitName ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget buidRow(
  //     {required String type, required String info, double fontSize = 10}) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
  //     width: fontSize > 10 ? (Get.height * 0.45).h : (Get.width * 0.65).w,
  //     child: Row(
  //       children: [
  //         Text(
  //           type,
  //           // textDirection: TextDirection.rtl,
  //           style: TextStyle(
  //             fontSize: fontSize.sp,
  //             color: colorPrimary,
  //           ),
  //         ),
  //         SizedBox(
  //           width: 2.w,
  //         ),
  //         Text(
  //           info,
  //           textDirection: TextDirection.rtl,
  //           style: TextStyle(
  //             fontSize: fontSize + 1,
  //             fontWeight: FontWeight.bold,
  //             color: colorPrimaryLight,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _displayDialog(BuildContext context) {
  //   showGeneralDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     transitionDuration: Duration(milliseconds: 2000),
  //     transitionBuilder: (context, animation, secondaryAnimation, child) {
  //       return FadeTransition(
  //         opacity: animation,
  //         child: ScaleTransition(
  //           scale: animation,
  //           child: child,
  //         ),
  //       );
  //     },
  //     pageBuilder: (context, animation, secondaryAnimation) {
  //       return SafeArea(
  //         child: Material(
  //           child: InkWell(
  //             onTap: () => Get.back(),
  //             child: Container(
  //               //margin: EdgeInsets.all(16.sp),

  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(55),
  //                 border: Border.all(color: Colors.black.withOpacity(0.07)),
  //               ),
  //               child: Stack(
  //                 children: [
  //                   Image.asset(
  //                     'assets/images/id_rotate.jpg',
  //                     fit: BoxFit.fill,
  //                     height: Get.height,
  //                     width: Get.width,
  //                   ),
  //                   Positioned(
  //                     right: 64.h,
  //                     child: RotatedBox(
  //                       quarterTurns: 1,
  //                       child: user is User && image!.isNotEmpty
  //                           ? CircleAvatar(
  //                               backgroundImage: MemoryImage(
  //                                 image!,
  //                               ),
  //                               radius: 55,
  //                             )
  //                           : CircleAvatar(
  //                               backgroundImage: AssetImage(((user is User)
  //                                       ? user.sexTypeName != "ذكر"
  //                                       : user.gender == "F")
  //                                   ? 'assets/images/female.png'
  //                                   : 'assets/images/male.png'),
  //                               radius: 55,
  //                             ),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: 4.h,
  //                     right: Get.width * 0.4,
  //                     child: RotatedBox(
  //                       quarterTurns: 1,
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             userType == "student"
  //                                 ? getUserName(
  //                                     '${user.firstNameAr ?? ''} ${user.midNameAr ?? ''} ${user.lastNameAr ?? ''}',
  //                                     40)
  //                                 : getUserName(user.arabicName ?? '', 40),
  //                             style: appTitleStyle,
  //                           ),
  //                           Text(
  //                             userType == "student"
  //                                 ? getUserName(
  //                                     '${user.firstNameEn ?? ''} ${user.midNameEn ?? ''} ${user.lastNameEn ?? ''}',
  //                                     40)
  //                                 : getUserName(user.latinFullName ?? '', 40),
  //                             style: appTitleStyle,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: 4.h,
  //                     left: Get.width * 0.15,
  //                     child: RotatedBox(
  //                       quarterTurns: 1,
  //                       child: Container(
  //                         width: Get.height * 0.75,
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             buidRow(
  //                               type: 'الوظيفة: ',
  //                               //typeEn: ':Profession ',
  //                               info: userType == "student"
  //                                   ? "طالب"
  //                                   : user.lastJobName ?? '',
  //                               // infoEn: userType == "student"
  //                               //     ? "Student"
  //                               //     : user.lastJobName ?? '',
  //                               fontSize: 12.sp,
  //                             ),
  //                             buidRow(
  //                               type: 'الرقم الوظيفي: ',
  //                               //typeEn: ':Employee ID ',
  //                               info: userType == "student"
  //                                   ? user.id ?? ''
  //                                   : user.recordNumber ?? '',
  //                               // infoEn: userType == "student"
  //                               //     ? user.id ?? ''
  //                               //     : user.employeeid.toString(),
  //                               fontSize: 12.sp,
  //                             ),
  //                             buidRow(
  //                               type: 'السجل المدني/الإقامة: ',
  //                               //typeEn: ':National/Residence ID ',
  //                               info: userType == "student"
  //                                   ? user.nid ?? ''
  //                                   : user.assignmentCivilRecordNumber ?? '',
  //                               // infoEn: userType == "student"
  //                               //     ? user.nid ?? ''
  //                               //     : user.assignmentCivilRecordNumber ?? '',
  //                               fontSize: 12.sp,
  //                             ),
  //                             buidRow(
  //                               type: 'الكلية/الإدارة: ',
  //                               //typeEn: ':Dep./College ',
  //                               info: userType == "student"
  //                                   ? user.collegeName ?? ''
  //                                   : user.employeeDepartmentUnitName ?? '',
  //                               // infoEn: userType == "student"
  //                               //     ? user.collegeName ?? ''
  //                               //     : user.employeeDepartmentUnitName ?? '',
  //                               fontSize: 12.sp,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     top: 16.h,
  //                     left: Get.width * 0.3,
  //                     child: QrImageView(
  //                       data: userType == "student"
  //                           ? getQRData(isUser: false)
  //                           : getQRData(isUser: true),
  //                       version: QrVersions.auto,
  //                       size: 55.sp,
  //                       padding: EdgeInsets.zero,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  String getQRData({required bool isUser}) {
    if (isUser) {
      return "الهوية : ${user.assignmentCivilRecordNumber} \n"
          " الإسم : ${user.arabicName} \n"
          "الجنسية : ${user.nationalityName} \n "
          "النوع : ${user.sexTypeName} \n "
          "الحالة الإجتماعية : ${user.maritalStatusName} \n "
          "تاريخ الميلاد : ${user.gregorianBirthDate} \n "
          "الهاتف : ${user.phoneNo} \n "
          "رصيد الأجازة : ${user.vacationBalance} \n  "
          "المؤهل : ${user.highestQualificationName} \n "
          "القسم : ${user.sectionName} \n "
          "التخصص : ${user.lastMainSpecialtyName} \n "
          "الحالة الوظيفية : ${user.employeeStatusName} \n "
          "نوع الوظيفة : ${user.employeeTypeName} \n "
          "تاريخ التعيين : ${user.hiringDate} \n "
          "تاريخ اخر ترقية : ${user.lastPromotionDate} \n ";
    } else {
      return "الهوية : ${user.nid} \n"
          " الإسم : ${user.firstNameAr ?? ''} ${user.midNameAr ?? ''} ${user.lastNameAr ?? ''} \n"
          "النوع : ${user.gender == "M" ? "ذكر" : "أنثى"} \n "
          "المؤهل : ${user.degreeName} \n "
          "الكلية : ${user.collegeName} \n "
          "القسم : ${user.departmentName} \n "
          "المعدل التراكمي : ${user.gpa} \n "
          "التقدير : ${user.gade} \n "
          "التصنيف : ${user.campName} \n "
          "الحالة الدراسية : ${user.status} \n ";
    }
  }
}

String getUserName(String name, int max) {
  if (name.length <= max) {
    return name;
  }

  String fullName = name.substring(0, max);
  return fullName.substring(0, fullName.lastIndexOf(' '));
}
