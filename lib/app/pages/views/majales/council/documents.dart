import 'dart:io';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/pages/views/majales/pdf_viewer.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CouncilDocuments extends StatelessWidget {
  const CouncilDocuments({required this.data, required this.headers});
  final List data;
  final String headers;

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
                            'لا يوجد مرفقات',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: data.map(((doc) {
                        return CustomRow(
                          title: doc['titleName'],
                          padding: EdgeInsets.all(8.sp),
                          icon: FontAwesomeIcons.fileContract,
                          color: colorPrimary,
                          iconColor: colorLightGreen,
                          onTap: () => openDocument(
                              doc['fileExtension'],
                              doc['path'],
                              doc['titleName'],
                              {'Authorization': headers}),
                        );
                      })).toList())),
          ),
          Positioned(
            top: Get.height * 0.066,
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
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorPrimary,
                ),
                child: Text(
                  'المرفقات',
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

void openDocument(String ext, String path, String fileName,
    Map<String, String> headers) async {
  fileName = '$fileName.${ext.toLowerCase()}';
  if (fileName.isImageFileName) {
    Get.to(
      () => PDFViewer(
        url: path,
        headers: headers,
        isImage: true,
      ),
    );
  } else if (fileName.isPDFFileName) {
    Get.to(PDFViewer(url: path, headers: headers));
  } else {
    await Get.defaultDialog(
      title: 'غير مدعوم',
      middleText: 'ملف غير مدعوم هل تريد تحميل الملف ؟',
      textConfirm: 'تحميل',
      onConfirm: () async {
        Get.back();
        String filePath = '';

        if (Platform.isIOS) {
          Directory library = await getApplicationDocumentsDirectory();
          filePath = "${library.path}/$fileName";
        } else {
          Directory? downloadsDir = await getExternalStorageDirectory();
          if (downloadsDir == null) {
            return;
          }
          filePath = "${downloadsDir.path}/$fileName";
        }
        try {
          // Request storage permissions
          var status = await Permission.storage.request();
          if (!status.isGranted) {
            return;
          }
          BaseClient.download(
            url: path,
            savePath: filePath,
            headers: {'Authorization': headers},
          );
          CustomSnackBar.showCustomSnackBar(
              title: 'تم التحميل', message: 'تم تحميل الملف بنجاح');
        } catch (e) {
          CustomSnackBar.showCustomErrorSnackBar(
              title: 'فشل التحميل', message: 'حدث خطأ في تحميل الملف');
        }
      },
    );
  }
}
