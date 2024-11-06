import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showDetails({required List<CustomRow> rows, required String title}) async {
  await Get.dialog(
    Card(
      margin: EdgeInsets.only(
          top: Get.height * 0.15,
          right: 28.w,
          left: 28.w,
          bottom: Get.height * 0.15),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorPrimary,
                ),
                child: Text(
                  title,
                  style: mediumTitleStyle.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32.h),
              Column(
                children: rows,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
