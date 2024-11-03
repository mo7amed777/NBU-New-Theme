import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  VoidCallback callBack;
  String? label;
  double? padding, fontSize;
  Color? color;
  Color? textColor;
  Widget? child;
  IconData? icon;
  CustomButton(
      {Key? key,
      required this.callBack,
      this.label,
      this.padding,
      this.icon,
      this.color,
      this.fontSize = 5.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: callBack,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? colorPrimary,
        padding: EdgeInsets.all(padding ?? 10.sp),
        foregroundColor: textColor ?? colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: icon == null
          ? null
          : Icon(
              icon,
              size: fontSize ?? 16.sp,
            ),
      iconAlignment: IconAlignment.end,
      label: child ??
          Text(
            label ?? '',
            style: TextStyle(
              fontSize: fontSize ?? 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
    );
  }
}
