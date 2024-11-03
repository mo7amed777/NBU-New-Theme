import 'package:cached_network_image/cached_network_image.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/theme/app_colors.dart';

class PDFViewer extends StatelessWidget {
  final String url;
  final Map<String, String> headers;
  final bool isImage;
  const PDFViewer(
      {required this.url, required this.headers, this.isImage = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isImage
            ? Center(
                child: CachedNetworkImage(
                  imageUrl: url,
                  httpHeaders: headers,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Center(
                    child: Image.asset(
                      'assets/images/loading.gif',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                      child: Material(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/no-data.gif',
                          )),
                      SizedBox(height: 32),
                      Text(
                        'حدث خطأ في تحميل الملف',
                        style: TextStyle(
                          color: colorPrimary,
                          fontSize: 25.sp,
                        ),
                      ),
                    ],
                  ))),
                ),
              )
            : PDF().fromUrl(
                url,
                headers: headers,
                placeholder: (double progress) => Center(
                  child: Image.asset(
                    'assets/images/loading.gif',
                    height: 100,
                    width: 100,
                  ),
                ),
                errorWidget: (dynamic error) => Center(
                    child: Material(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          'assets/images/no-data.gif',
                        )),
                    SizedBox(height: 32),
                    Text(
                      'حدث خطأ في فتح الملف',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 25.sp,
                      ),
                    ),
                  ],
                ))),
              ),
        Positioned(
          top: Get.height * 0.065,
          left: 8.w,
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () => Get.back(),
          ),
        ),
      ],
    );
  }
}
