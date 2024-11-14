import 'dart:io';

import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/models/users/student.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import '../../components/id_card.dart';

class PrintCard extends StatefulWidget {
  final int branchId;
  final List bloodTypes;
  final List nationalities;
  final Map user;
  const PrintCard(
      {Key? key,
      required this.branchId,
      required this.user,
      required this.nationalities,
      required this.bloodTypes})
      : super(key: key);

  @override
  _PrintCardState createState() => _PrintCardState();
}

class _PrintCardState extends State<PrintCard> {
  Map<String, dynamic> userData = MySharedPref.getUserData();
  late Student student;
  String selectedBloodType = 'فصيلة الدم';
  String selectedNationality = 'الجنسية';

  @override
  void initState() {
    super.initState();
    student = Student.fromJson(userData['user']);
    if (widget.user.isEmpty) {
      widget.bloodTypes.insert(
        0,
        {'id': -1, 'name': 'فصيلة الدم'},
      );
    }
    selectedBloodType = widget.user.isNotEmpty
        ? widget.user['bloodTypeId'].toString()
        : widget.bloodTypes[0]['id'].toString();

    selectedNationality = widget.user['nationalityId'] != null
        ? widget.user['nationalityId'].toString()
        : widget.nationalities[0]['id'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.075, left: 8.w, right: 8.w),
              child: _buildProfileContent(context)),
          Positioned(
            top: Get.height * 0.015,
            left: 4.w,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            top: Get.height * 0.02,
            left: 1.w,
            right: 1.w,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colorPrimary,
                ),
                child: Text(
                  'طلب طباعة بطاقة الطالب',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomRow(
              title: 'الإســـم ',
              trailing: getUserName(
                  "${student.firstNameAr ?? ''} ${student.midNameAr ?? ''} ${student.lastNameAr ?? ''}",
                  30)),
          CustomRow(title: 'الـهـويـة ', trailing: student.nid!),
          CustomRow(title: 'الرقم الجامعي', trailing: student.id!),
          CustomRow(title: 'الدرجـة', trailing: student.degreeName ?? ""),
          CustomRow(title: 'الـكـليـة', trailing: student.collegeName ?? ""),
          CustomRow(title: 'الموقع', trailing: student.campName ?? ""),
          CustomRow(title: 'التخصص', trailing: student.programName ?? ""),
          CustomRow(title: 'الحالة', trailing: student.status ?? ""),
          CustomRow(title: 'التقدير', trailing: student.gade ?? ""),
          CustomRow(
              title: 'الجنسية',
              trailing: widget.user['nationality']['arabicName'] ?? ""),
          CustomRow(
              title: 'المعدل',
              trailing: student.gpa != null ? student.gpa!.toString() : ""),
          CustomRow(title: 'القسم   ', trailing: student.departmentName ?? ""),
          //Upload Photo Optional if printed
          if (image != null)
            SizedBox(
              height: 100.h,
              width: 100.h,
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Image.file(image!),
              ),
            ),

          TextButton.icon(
            //Check if first time to print

            style: TextButton.styleFrom(
              backgroundColor: colorPrimary,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            ),
            label: Text(
              image == null ? 'اضافة صورة' : 'تعديل الصورة',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.camera);

              if (pickedFile != null) {
                setState(() {
                  image = File(pickedFile.path);
                });
              }
            },
            icon: Icon(
              FontAwesomeIcons.solidImage,
              color: Colors.white,
            ),
          ),
          //Convert bloodTypes to dropDown menu
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: DropdownButton<String>(
              value: selectedBloodType,
              isExpanded: true,
              underline: Container(height: 1, color: colorLightGreen),
              items:
                  widget.bloodTypes.map<DropdownMenuItem<String>>((bloodType) {
                return DropdownMenuItem<String>(
                  value: bloodType['id'].toString(),
                  enabled: bloodType['id'] != '-1',
                  child: Text(
                    bloodType['name'],
                    style: TextStyle(
                      color: bloodType['id'] != '-1'
                          ? colorPrimary
                          : colorBlackLight,
                    ),
                  ),
                );
              }).toList(),
              hint: Text('اختر فصيلة الدم :'),
              iconEnabledColor: colorBlackLight,
              onChanged: (value) async {
                setState(() {
                  selectedBloodType = value!;
                  for (var bloodType in widget.bloodTypes) {
                    if (bloodType['id'].toString() == value) {
                      selectedBloodTypeId = bloodType['id'];
                    }
                  }
                });
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: DropdownButton<String>(
              value: selectedNationality,
              isExpanded: true,
              underline: Container(height: 1, color: colorLightGreen),
              items: widget.nationalities
                  .map<DropdownMenuItem<String>>((nationality) {
                return DropdownMenuItem<String>(
                  value: nationality['id'].toString(),
                  child: Text(
                    nationality['arabicName'],
                    style: TextStyle(
                      color: colorPrimary,
                    ),
                  ),
                );
              }).toList(),
              hint: Text('اختر الجنسية:'),
              onChanged: (value) async {
                setState(() {
                  selectedNationality = value!;
                  for (var nationlty in widget.nationalities) {
                    if (nationlty['id'].toString() == value) {
                      selectedNationalityId = nationlty['id'];
                    }
                  }
                });
              },
            ),
          ),

          CustomButton(
            callBack: () {
              if (widget.user.isEmpty) {
                if (image == null) {
                  CustomSnackBar.showCustomErrorSnackBar(
                      title: 'خطأ', message: 'يجب اختيار صورة لطباعة البطاقة');
                  return;
                }
              }
              if (selectedBloodTypeId == 0 && selectedBloodType == '-1') {
                CustomSnackBar.showCustomErrorSnackBar(
                    title: 'خطأ',
                    message: 'يجب اختيار فصيلة الدم لطباعة البطاقة');
                return;
              }
              printCard(
                isPrinted: false,
                branchId: widget.branchId,
                copyNumber: widget.user.isNotEmpty
                    ? widget.user['isPrint']
                        ? widget.user['copyNumber'] + 1
                        : widget.user['copyNumber']
                    : 1,
                bloodTypeId: widget.user.isNotEmpty
                    ? widget.user['bloodTypeId']
                    : selectedBloodTypeId,
                nationalityId:
                    widget.user['bloodTypeId'] ?? selectedNationalityId ?? 1,
              );
            },
            label: 'إرسال الطلب',
            fontSize: 18,
            padding: 8,
          ),
        ],
      ),
    );
  }

  File? image;
  int selectedBloodTypeId = 0;
  int selectedNationalityId = 1;

  void printCard({
    required bool isPrinted,
    required int branchId,
    required int copyNumber,
    required int bloodTypeId,
    required int nationalityId,
  }) async {
    await showLoadingOverlay(asyncFunction: () async {
      dio.MultipartFile? attatchment;
      if (image != null) {
        attatchment = dio.MultipartFile.fromFileSync(image!.path);
      }

      Map<String, dynamic> data = {
        "Id": widget.user.isNotEmpty ? widget.user['id'] : 0,
        "Nid": student.nid,
        "IsPrint": isPrinted,
        "BranchId": branchId,
        "GenderId": student.gender == 'M' ? 1 : 2,
        "CollegeId": int.parse(student.collegeCode!),
        "ArabicName":
            "${student.firstNameAr ?? ''} ${student.midNameAr ?? ''} ${student.lastNameAr ?? ''}",
        "EnglishName":
            "${student.firstNameEn ?? ''} ${student.midNameEn ?? ''} ${student.lastNameEn ?? ''}",
        "CopyNumber": copyNumber,
        "BloodTypeId": bloodTypeId,
        "AttachmentId":
            widget.user.isNotEmpty ? widget.user['attachmentId'] : 0,
        "NationalityId": widget.user['NationalityId'] ?? nationalityId ?? 1,
        "UniversityCode": student.id,
        'Profile': attatchment ?? widget.user['profilePath'],
      };
      dio.FormData formData = dio.FormData.fromMap(data);

      APIController controller = APIController(
        url: widget.user.isNotEmpty
            ? 'https://std-card.nbu.edu.sa/api/StudentMobile/EditStudent'
            : 'https://std-card.nbu.edu.sa/api/StudentMobile/AddStudent',
        body: formData,
        requestType: RequestType.post,
      );

      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        Get.back();
        CustomSnackBar.showCustomSnackBar(
            title: 'نجاح', message: 'تم اضافة الطلب بنجاح');
      }
    });
  }
}
