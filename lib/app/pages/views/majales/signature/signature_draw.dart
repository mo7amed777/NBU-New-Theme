import 'dart:convert';
import 'dart:typed_data';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/majales/signature/signature_crop.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:hand_signature/signature.dart';

const String base64Code = 'data:image/png;base64,';

HandSignatureControl control = HandSignatureControl(
  threshold: 0.01,
  smoothRatio: 0.65,
  velocityRange: 2.0,
);

class Signature extends StatefulWidget {
  const Signature({Key? key}) : super(key: key);

  @override
  State<Signature> createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {
  bool painted = false;
  bool startPainting = false;

  @override
  void dispose() {
    super.dispose();
    control.clear(); //Clear Not Dispose for reuse
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: HandSignature(
                      control: control,
                      type: SignatureDrawType.shape,
                      onPointerDown: () {
                        setState(() {
                          startPainting = true;
                        });
                      },
                      onPointerUp: () {
                        setState(() {
                          painted = true;
                        });
                      },
                    ),
                  ),
                  CustomPaint(
                    painter: DebugSignaturePainterCP(
                      control: control,
                      cp: false,
                      cpStart: false,
                      cpEnd: false,
                    ),
                  ),
                  startPainting
                      ? Container()
                      : Center(
                          child: Text(
                            'قم برسم أو إدراج التوقيع الخاص بك',
                            style: appTextStyle,
                          ),
                        ),
                  Positioned(
                    right: 16.0,
                    top: 32.0,
                    child: IconButton(
                      onPressed: () {
                        control.clear();
                        setState(() {
                          painted = false;
                          startPainting = false;
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        size: 35,
                        color: colorBlackLight,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    top: 32.0,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 35,
                        textDirection: TextDirection.ltr,
                        color: colorBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: Get.width - 48,
            child: CustomButton(
              color: colorPrimary,
              callBack: () async {
                if (painted) {
                  saveSignature();
                } else {
                  Get.to(() => SignatureCrop());
                }
                setState(() {
                  control.clear();
                  painted = false;
                  startPainting = false;
                });
              },
              label: painted ? 'حفظ التوقيع' : 'إدراج التوقيع',
              fontSize: 16,
              padding: 12,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }

  void saveSignature() async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      ByteData? bytes = await control.toImage(
        width: Get.width.toInt(),
        height: Get.height.toInt(),
      );
      final binaryData = bytes!.buffer.asUint8List();
      final base64Data = base64Encode(binaryData);

      // Uint8List bytess= base64Decode(base64Data);
      // Get.dialog(Image.memory(bytess));

      if (base64Data.isEmpty) {
        CustomSnackBar.showCustomErrorSnackBar(
            message: "حدث خطأ في التوقيع برجاء المحاولة مرة أخرى!",
            title: 'فشل');
        return;
      }
      var body = {
        "sign": "$base64Code$base64Data",
        "token": headers,
      };

      APIController controller = APIController(
          url: 'https://mobileapi.nbu.edu.sa/api/MajalesExternalApi/AddNewSign',
          body: body,
          requestType: RequestType.post);
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        CustomSnackBar.showCustomSnackBar(
            title: 'نجاح', message: 'تم الحفظ بنجاح');
      }
    });
  }

//
}
