import 'dart:convert';
import 'dart:io';

import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/details_dialog.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/course.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:path_provider/path_provider.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key, required this.courses}) : super(key: key);

  final List courses;

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
                child: courses.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/no-data.gif'),
                          ),
                          SizedBox(height: 32),
                          Text(
                            'لا يوجد لديك دورات مضافة',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: courses
                            .map(((crs) {
                              Course course = Course.fromJson(crs);
                              return MyCard(
                                title: course.courseNameDesc ?? '',
                                desc: course.courseDate ?? '',
                                subTitle: course.graduationName ?? '',
                                margin: EdgeInsets.all(8.sp),
                                onTap: () => showDetails(
                                  title: course.arabicName ?? '',
                                  rows: [
                                    CustomRow(
                                      title: ' بداية الدورة: ',
                                      trailing: course.startDate!,
                                    ),
                                    CustomRow(
                                      title: ' نهاية الدورة: ',
                                      trailing: course.endDate!,
                                    ),
                                    CustomRow(
                                      title: ' الحصول على الدورة: ',
                                      trailing: course.courseDate!,
                                    ),
                                    CustomRow(
                                      title: ' تقييم الدورة: ',
                                      trailing: course.evaluationName!,
                                    ),
                                    CustomRow(
                                      title: ' مكان الدورة: ',
                                      trailing: course.graduationName!,
                                    ),
                                    if (course.imageAttachmentId != null)
                                      CustomRow(
                                        title: 'عرض الملف',
                                        iconColor: colorLightGreen,
                                        icon: FontAwesomeIcons.fileContract,
                                        onTap: () => viewFile(
                                            id: course.imageAttachmentId
                                                .toString(),
                                            type: '1'),
                                      ),
                                  ],
                                ),
                                fullWidth: true,
                                icon: FontAwesomeIcons.penClip,
                              );
                            }))
                            .toList()
                            .reversed
                            .toList())),
          ),
          Positioned(
            top: Get.height * 0.065,
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
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colorPrimary,
                ),
                child: Text(
                  'الدورات التدريبية',
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

/// Android Extension or IOS *.all => bool false for IOS
Map<String, dynamic> fileExtension(bool isAndroid) {
  return isAndroid
      ? {
          '.docx':
              'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
          '.jpg': 'image/jpeg',
          '.rar': 'application/x-zip-compressed',
          '.pdf': 'application/pdf',
          '.jpeg': 'image/jpeg',
          '.bmp': 'image/bmp',
          '.heic': 'image/jpeg',
          '.mp4': "video/mp4",
          '.mht': "text/html",
          '.tif': 'image/jpeg',
          '.txt': "text/plain",
          '.tmp': "*/*",
          '.html': "text/html",
          '.jfif': 'image/jpeg',
          '.tiff': 'image/jpeg',
          '.doc': "application/msword",
          '.htm': "text/html",
          '.png': "image/png",
        }
      : {
          '.docx': "public.tar-archive",
          '.jpg': "public.jpeg",
          '.rar': "com.microsoft.word.doc",
          '.pdf': "com.adobe.pdf",
          '.jpeg': "public.jpeg",
          '.bmp': "com.microsoft.bmp",
          '.heic': "public.mpeg-4",
          '.mp4': "public.mpeg-4",
          '.mht': "public.html",
          '.tif': "public.jpeg",
          '.txt': "public.plain-text",
          '.tmp': "*/*",
          '.html': "public.html",
          '.jfif': "public.jpeg",
          '.tiff': "public.jpeg",
          '.doc': "com.microsoft.word.doc",
          '.htm': "public.html",
          '.png': "public.png",
        };
}

/// id : file ID , type : file Type 1 for courses , 2 for qualificatoins
void viewFile({required String id, required String type}) async {
  try {
    await showLoadingOverlay(asyncFunction: () async {
      APIController controller = APIController(
          url:
              "https://mobileapi.nbu.edu.sa/api/NBUExternalApi/GetEmpAttachment?id=$id&type=$type");

      await controller.getData();
      if (controller.data['imageBody'] == null) {
        CustomSnackBar.showCustomErrorToast(
          message: 'لا يوجد مرفق',
        );
        return;
      }
      String ext = controller.data['fileExtension'];
      String filePath = await convert(controller.data['imageBody'], ext);

      //mimeType => Andoid Files ext.
      //uti => IOS Files ext.
      OpenAppFile.open(
        filePath,
        mimeType: fileExtension(true)[".${ext.removeAllWhitespace}"],
        uti: fileExtension(true)[".${ext.removeAllWhitespace}"],
      );
    });
  } catch (e) {
    CustomSnackBar.showCustomErrorToast(
      message: 'حدث خطأ أثناء فتح الملف',
    );
  }
}

/// src: file Source , ext : File Extension
Future<String> convert(String src, String ext) async {
  Uint8List base64Decode(String source) => base64.decode(source);
  Directory appDocDir = await getApplicationDocumentsDirectory();
  int last = appDocDir.path.lastIndexOf('/');
  String appDocPath =
      appDocDir.path.replaceRange(last, appDocDir.path.length, '/file.$ext');
  File file = await File(appDocPath).create();
  file.writeAsBytes(base64Decode(src));
  return file.path;
}
