import 'dart:typed_data';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/routes/app_pages.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/users/user.dart';
import 'package:get/get.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/id_card.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   ScrollController _scrollController = ScrollController();
//   dynamic user = Get.arguments[0];
//   dynamic image = Get.arguments[1];

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           _buildParallaxBackground(context),
//           _buildProfileContent(context),
//           (user is User)
//               ? _buildvacationBalance(
//                   context: context, number: user.vacationBalance)
//               : Positioned(
//                   left: 0,
//                   top: 0,
//                   child: SizedBox(
//                     height: 1,
//                     width: 1,
//                   ),
//                 ),
//           Positioned(
//             top: 32.h,
//             left: 0.w,
//             child: IconButton(
//               icon: Icon(
//                 FontAwesomeIcons.circleXmark,
//                 color: Colors.red,
//               ),
//               onPressed: () => Get.back(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildParallaxBackground(BuildContext context) {
//     return Positioned(
//       top: 0.0,
//       left: 0.0,
//       right: 0.0,
//       child: Container(
//         height: Get.height.h * 0.35,
//         width: Get.width.w,
//         decoration: BoxDecoration(
//           image: (user is User) && image.isNotEmpty
//               ? DecorationImage(
//                   image: MemoryImage(image),
//                   fit: BoxFit.fill,
//                 )
//               : DecorationImage(
//                   image: AssetImage(
//                     'assets/images/profile_back.png',
//                   ),
//                   fit: BoxFit.fill,
//                 ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileContent(BuildContext context) {
//     return Positioned(
//       top: Get.height.h * 0.3,
//       left: 0.0,
//       right: 0.0,
//       bottom: 0.0,
//       child: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/images/imag.png'), fit: BoxFit.cover),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30.0),
//             topRight: Radius.circular(30.0),
//           ),
//         ),
//         child: SingleChildScrollView(
//           controller: _scrollController,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(8.0.sp),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Column(
//                         children: [
//                           Padding(
//                             padding:
//                                 EdgeInsets.only(left: 8.0.sp, top: 15.0.sp),
//                             child: Text(
//                               (user is User)
//                                   ? getUserName(
//                                       user.latinFullName ??
//                                           user.arabicName ??
//                                           user.assignmentCivilRecordNumber,
//                                       30)
//                                   : getUserName(
//                                       user.firstNameAr! +
//                                           " " +
//                                           user.midNameAr! +
//                                           " " +
//                                           user.lastNameAr!,
//                                       30),
//                               style: TextStyle(
//                                 fontSize: 16.0.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: colorWhite,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsets.only(left: 16.0.sp, top: 8.0.sp),
//                             child: Text(
//                               (user is User)
//                                   ? user.emailAddress!
//                                   : user.collegeName!,
//                               style: TextStyle(
//                                 fontSize: 18.0.sp,
//                                 color: Colors.white38,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       user is User && image!.isNotEmpty
//                           ? CircleAvatar(
//                               backgroundImage: MemoryImage(
//                                 image,
//                               ),
//                               radius: 40.sp,
//                             )
//                           : CircleAvatar(
//                               backgroundImage: AssetImage(((user is User)
//                                       ? user.sexTypeName != "ذكر"
//                                       : user.gender == "F")
//                                   ? 'assets/images/female.png'
//                                   : 'assets/images/male.png'),
//                               radius: 40.sp,
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               buidRow(
//                   type: 'الـهـويـة ',
//                   info: (user is User)
//                       ? user.assignmentCivilRecordNumber!
//                       : user.nid),
//               (user is User)
//                   ? Container()
//                   : buidRow(type: 'الرقم الجامعي', info: user.id),
//               (user is User)
//                   ? buidRow(type: 'الوظيفة', info: user.lastJobName ?? "")
//                   : buidRow(type: 'الدرجـة', info: user.degreeName ?? ""),
//               (user is User)
//                   ? buidRow(type: 'الجنسية ', info: user.nationalityName ?? "")
//                   : buidRow(type: 'الـكـليـة', info: user.collegeName ?? ""),
//               (user is User)
//                   ? buidRow(
//                       type: 'التوظيف',
//                       info: user.lastJobEmploymentGroupName ?? "")
//                   : buidRow(type: 'الموقع', info: user.campName ?? ""),
//               (user is User)
//                   ? buidRow(type: 'الهاتف    ', info: user.phoneNo ?? "")
//                   : buidRow(type: 'التخصص', info: user.programName ?? ""),
//               (user is User)
//                   ? buidRow(
//                       type: 'المؤهل  ',
//                       info: user.highestQualificationName ?? "")
//                   : buidRow(type: 'الحالة', info: user.status ?? ""),
//               (user is User)
//                   ? buidRow(
//                       type: 'الحالة     ', info: user.employeeStatusName ?? "")
//                   : buidRow(type: 'التقدير', info: user.gade ?? ""),
//               (user is User)
//                   ? buidRow(type: 'التصنيف', info: user.employeeTypeName ?? "")
//                   : buidRow(
//                       type: 'المعدل',
//                       info: user.gpa != null ? user.gpa!.toString() : ""),
//               buidRow(
//                   type: 'القسم   ',
//                   info: (user is User)
//                       ? user.sectionName ?? ""
//                       : user.departmentName ?? ""),
//               SizedBox(height: 8.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buidRow({required String type, required String info}) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 13.0, top: 15.0),
//       child: Row(
//         children: [
//           Text(
//             type,
//             style: TextStyle(
//               fontSize: 13.sp,
//               height: 1.2,
//               color: colorWhite,
//             ),
//           ),
//           SizedBox(
//             width: 18,
//           ),
//           Icon(
//             FontAwesomeIcons.anglesLeft,
//             size: 15.sp,
//           ),
//           SizedBox(
//             width: 15,
//           ),
//           Flexible(
//             child: Text(
//               info,
//               textDirection: TextDirection.rtl,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: colorWhite,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildvacationBalance(
//       {required BuildContext context, required int number}) {
//     return Positioned(
//         bottom: 10.h,
//         left: 24.w,
//         child: Container(
//           height: 80.h,
//           width: 80.w,
//           decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               boxShadow: const [
//                 BoxShadow(color: colorWhite, spreadRadius: 3),
//               ],
//               gradient: LinearGradient(colors: [
//                 colorPrimary,
//                 colorPrimaryLight,
//               ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 6.0.sp),
//                 child: Text(
//                   'رصيد الأجازات',
//                   style: TextStyle(
//                       color: colorWhite,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 11.sp),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 4.0.sp),
//                 child: Text(number.toString(),
//                     style: TextStyle(
//                         color: colorWhite,
//                         fontSize: 17.sp,
//                         fontWeight: FontWeight.bold)),
//               ),
//             ],
//           ),
//         ));
//   }
// }
@immutable
class ProfileScreen extends StatelessWidget {
  final String userType;
  final dynamic user;
  final Uint8List? image;
  const ProfileScreen(
      {super.key, required this.userType, required this.user, this.image});

  @override
  Widget build(BuildContext context) {
    return user is User
        ? IDCard(
            user: user,
            image: image,
            userType: userType,
          )
        : IDCard(
            user: user,
            userType: userType,
          );
  }
}
