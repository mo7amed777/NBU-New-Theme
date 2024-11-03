import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListItems extends StatelessWidget {
  final String title, subtitle;
  final List<String> items;
  final IconData icon;
  double padding;
  ListItems(
      {required this.title,
      required this.items,
      this.icon = Icons.circle,
      this.padding = 4,
      this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0.0,
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorBlackLight,
                      fontSize: 16.sp)),
              subtitle == ''
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(subtitle, style: TextStyle(height: 1.5)),
                    ),
            ],
          ),
        ),
        subtitle: Column(
          children: items.map(goal).toList(),
        ),
      ),
    );
  }

  Widget goal(String itemText) => Padding(
        padding: EdgeInsets.only(
          top: padding.h,
          left: 4.w,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon == Icons.circle
                ? Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Icon(
                      icon,
                      size: 10.sp,
                    ),
                  )
                : Icon(icon, size: 18.sp, color: colorBlackLight),
            SizedBox(width: 6.w),
            Flexible(
              child: Text(
                itemText,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      );
}
