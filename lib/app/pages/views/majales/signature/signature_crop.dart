import 'dart:convert';
import 'dart:io';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/majales/signature/signature_draw.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignatureCrop extends StatefulWidget {
  const SignatureCrop({Key? key}) : super(key: key);

  @override
  _SignatureCropState createState() => _SignatureCropState();
}

class _SignatureCropState extends State<SignatureCrop> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _body(),
          Positioned(
            left: 16.0,
            top: 32.0,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black45,
                size: 35,
                textDirection: TextDirection.ltr,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    if (_croppedFile != null || _pickedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
          onPressed: () async {
            saveSignature();
          },
          backgroundColor: colorPrimary,
          tooltip: 'Save',
          child: const Icon(
            Icons.check,
            size: 30,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            _clear();
          },
          backgroundColor: colorRed,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        if (_croppedFile == null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              onPressed: () {
                _cropImage();
              },
              backgroundColor: const Color(0xFFBC764A),
              tooltip: 'Crop',
              child: const Icon(Icons.crop),
            ),
          )
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: GestureDetector(
        onTap: () => _uploadImage(),
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SizedBox(
            width: kIsWeb ? 380.0 : 320.0,
            height: 300.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DottedBorder(
                radius: const Radius.circular(12.0),
                borderType: BorderType.RRect,
                dashPattern: const [8, 4],
                color: colorBlackLighter,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: colorPrimary,
                        size: 80.sp,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'تحميل صورة التوقيع  ...',
                        style: appTextStyle,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.dialog,
            size: const CropperSize(
              width: 520,
              height: 520,
            ),
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }

  void saveSignature() async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getMajalesToken();
      var headers = 'Bearer $token';
      Uint8List binaryFile;
      if (_croppedFile != null) {
        binaryFile = await _croppedFile!.readAsBytes();
      } else {
        binaryFile = await _pickedFile!.readAsBytes();
      }

      final base64Data = base64.encode(binaryFile);

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
}
