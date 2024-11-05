import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String desc;
  final bool fullWidth, isMajales;
  final List<String>? chips;
  final IconData icon;
  final Color? iconColor;
  final Widget? rateBar;
  final VoidCallback? onTap, showNext, showDetails;
  final EdgeInsetsGeometry? margin;
  const MyCard(
      {super.key,
      this.margin,
      this.onTap,
      this.iconColor,
      this.showNext,
      this.showDetails,
      required this.title,
      required this.subTitle,
      required this.desc,
      this.chips,
      this.fullWidth = false,
      this.isMajales = false,
      this.rateBar,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Container(
        width: fullWidth ? Get.width : Get.width * 0.75,
        margin: margin ?? EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: colorPrimaryLighter, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: colorPrimary.withOpacity(0.1), width: 1.2)),
                    child: Icon(icon,
                        size: 30.sp, color: iconColor ?? colorPrimary),
                  ),
                  SizedBox(width: 6.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: appTitleStyle.copyWith(
                              fontSize: 14, color: colorLightGreen)),
                      SizedBox(height: 3.h),
                      Text(desc,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: appSubTextStyle.copyWith(
                              color: colorBlackLight,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            if (chips != null)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: chips!
                      .map((chip) => Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            margin: margin ?? EdgeInsets.only(right: 8.w),
                            decoration: BoxDecoration(
                                color: colorPrimaryLighter,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              chip,
                              style: appSubTextStyle.copyWith(
                                  color: colorPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ))
                      .toList(),
                ),
              ),
            SizedBox(height: 8.h),
            Text(
              subTitle,
              style: smallTitleStyle.copyWith(
                color: colorPrimary,
              ),
            ),
            isMajales
                ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    CustomButton(
                      callBack: showDetails ?? () {},
                      label: 'المزيد',
                      fontSize: 11.sp,
                      padding: 8.sp,
                      icon: Icons.more_horiz,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    CustomButton(
                      callBack: showNext ?? () {},
                      label: 'التالي',
                      fontSize: 11.sp,
                      padding: 8.sp,
                      icon: Icons.arrow_forward_ios_outlined,
                    ),
                  ])
                : Align(
                    alignment: Alignment.centerLeft,
                    child: rateBar ??
                        SizedBox.shrink()), //rateBar ?? SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
