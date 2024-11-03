import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyListTile extends StatelessWidget {
  final String title, subtitle;

  const MyListTile({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0.0,
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorBlackLight,
                  fontSize: 16.sp)),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontWeight: FontWeight.w500, height: 1.5),
        ),
      ),
    );
  }
}
