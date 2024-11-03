import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRow extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? trailing;
  final Color? color;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final bool? isLast;
  final bool? hasDivider;
  final VoidCallback? onTap;
  const CustomRow({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
    this.color,
    this.isLast = false,
    this.hasDivider = false,
    this.iconColor,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Column(
        children: [
          hasDivider ?? false
              ? Divider(color: colorBlackLighter, thickness: 0.7, height: 20.h)
              : SizedBox(),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap ?? () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: appTextStyle.copyWith(
                    color: color ?? colorPrimary,
                  ),
                ),
                SizedBox(width: 10.w),
                trailing != null
                    ? Expanded(
                        child: Text(
                          trailing!,
                          maxLines: 2,
                          style: smallTitleStyle.copyWith(
                            color: colorBlack,
                          ),
                        ),
                      )
                    : Icon(icon,
                        size: 18.sp, color: iconColor ?? colorWhiteLight),
              ],
            ),
          ),
          isLast ?? false
              ? SizedBox()
              : Divider(color: colorBlackLighter, thickness: 0.7, height: 20.h)
        ],
      ),
    );
  }
}
