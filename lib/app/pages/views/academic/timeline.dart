import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_widget/zoom_widget.dart';

class Timeline extends StatelessWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Zoom(
                maxZoomWidth: Get.width,
                maxZoomHeight: Get.height,
                backgroundColor: Colors.white,
                initPosition: Offset(-100, 0),
                child: Image.asset(
                  'assets/images/academic/table.jpeg',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                right: 1,
                top: 1,
                bottom: 1,
                child: InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.double_arrow_rounded,
                      color: colorBlackLight,
                      size: 35.sp,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
