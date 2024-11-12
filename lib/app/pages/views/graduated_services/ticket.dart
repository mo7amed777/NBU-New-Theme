import 'dart:io';
import 'dart:typed_data';

import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/app/pages/views/graduated_services/graduated_services.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class TicketScreen extends StatefulWidget {
  final Map<String, dynamic> code;

  const TicketScreen({Key? key, required this.code}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            height: Get.height * 0.75,
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorPrimaryLighter,
                  colorPrimaryLight,
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.circular(
                20 * _animation.value,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10 * _animation.value,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(30.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.sp),
                    child: Text(
                      widget.code['eventName'],
                      style: TextStyle(
                        fontSize: 18.w * _animation.value,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.sp),
                    child: QrImageView(
                      data: widget.code['id'].toString(),
                      backgroundColor: Colors.white,
                      version: QrVersions.auto,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.sp, bottom: 4.sp),
                    child: Text(
                      widget.code['location'],
                      style: TextStyle(
                        fontSize: 18.w * _animation.value,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    toDate(widget.code['date']),
                    style: TextStyle(
                      fontSize: 15.w * _animation.value,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                          color: Colors.white30,
                          onPressed: () =>
                              _shareQrCode(code: widget.code['id'].toString()),
                          padding: EdgeInsets.zero,
                          child: Icon(
                            Icons.share,
                            color: Colors.white70,
                          )),
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white30,
                          onPressed: () => _downloadQrCode(
                              code: widget.code['id'].toString()),
                          child: Icon(
                            Icons.file_download,
                            color: Colors.white70,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<ByteData> _generateQrImageData({required String code}) async {
    final qrPainter = QrPainter(
      data: code,
      version: QrVersions.auto,
      gapless: false,
      color: Colors.black,
      emptyColor: Colors.white,
    );
    final imageByteData = await qrPainter.toImageData(200.0);
    return imageByteData!.buffer.asByteData();
  }

  void _shareQrCode({required String code}) async {
    try {
      await showLoadingOverlay(asyncFunction: () async {
        final qrImageData = await _generateQrImageData(code: code);
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/qr.png').create();
        await file.writeAsBytes(qrImageData.buffer.asUint8List());
        Share.shareXFiles([XFile(file.path)], text: 'QR code for $code');
      });
    } catch (e) {
      CustomSnackBar.showCustomErrorToast(
          message: 'حدث خطأ في المشاركة برجاء المحاولة في وقت لاحق');
    }
  }

  void _downloadQrCode({required String code}) async {
    try {
      await showLoadingOverlay(asyncFunction: () async {
        final qrImageData = await _generateQrImageData(code: code);
        await ImageGallerySaver.saveImage(qrImageData.buffer.asUint8List());
      });
      CustomSnackBar.showCustomSnackBar(
          title: 'نجاح', message: 'تم تحميل الكود في معرض الصور بنجاح');
    } catch (e) {
      CustomSnackBar.showCustomErrorToast(
          message: 'حدث خطأ في التحميل برجاء المحاولة في وقت لاحق');
    }
  }
}
