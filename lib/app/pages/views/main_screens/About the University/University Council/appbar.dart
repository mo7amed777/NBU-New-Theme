import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Appbar extends StatefulWidget {
  const Appbar({required this.title, this.icon, this.onIconPressed});
  final IconData? icon;
  final String title;
  final Function? onIconPressed;

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      height: AppBar().preferredSize.height,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4, left: 16, right: 4.0),
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22,
                    color: colorPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          widget.icon != null
              ? Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, right: 8.w, left: 8.w),
                      child: SizedBox(
                        width: AppBar().preferredSize.height - 8,
                        height: AppBar().preferredSize.height - 8,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                                AppBar().preferredSize.height),
                            child: Icon(
                              widget.icon,
                              color: colorPrimary,
                            ),
                            onTap: () {
                              widget.onIconPressed!();
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w, top: 8.h),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: colorPrimary,
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: colorPrimary,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
