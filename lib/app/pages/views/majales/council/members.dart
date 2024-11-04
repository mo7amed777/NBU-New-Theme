import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/app/data/models/member.dart';
import 'package:eservices/config/theme/app_colors.dart';

class CouncilMembers extends StatelessWidget {
  const CouncilMembers({Key? key, required this.data}) : super(key: key);
  final List data;

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
                        children: data.map(((modelMember) {
                        MemberModel member = MemberModel.fromJson(modelMember);
                        return Card(
                          elevation: 0,
                          color: colorPrimary,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Text(
                              member.userNameAr ?? member.userNameEn ?? '',
                              overflow: TextOverflow.fade,
                              style: TextStyle(color: colorWhite),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/male.png',
                              ),
                              radius: 20,
                            ),
                            trailing: Text(
                              member.privilegeNameAr ??
                                  member.privilegeNameEn ??
                                  '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 9, 247, 144),
                                  fontSize: 12.sp),
                            ),
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
                  'الأعضاء',
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
