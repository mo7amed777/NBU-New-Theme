import 'dart:io';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/input_field.dart';
import 'package:eservices/app/data/models/users/academic_research.dart';
import 'package:eservices/app/pages/views/research/finance_request/president_agreement.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class FinanceRequestForm extends StatelessWidget {
  FinanceRequestForm({
    super.key,
    required this.financePriorties,
    required this.researcherRoles,
    required this.userData,
    required this.projectId,
    required this.type,
    required this.presidentData,
    this.scholarshipId,
    this.scholarshipCountry,
    this.scholarshipDegree,
    this.scholarshipEndDate,
  });
  List financePriorties, researcherRoles;
  final Map<String, dynamic> presidentData;
  AcademicResearch userData;
  final String projectId, type;
  final String? scholarshipId,
      scholarshipCountry,
      scholarshipDegree,
      scholarshipEndDate;

  final TextEditingController _titleController = TextEditingController(),
      _magazineNameController = TextEditingController(),
      _filedSpecificController = TextEditingController(),
      _websiteController = TextEditingController(),
      _issnController = TextEditingController(),
      _totalSubscribersController = TextEditingController(),
      _fromNBUController = TextEditingController(),
      _outsideNBUController = TextEditingController(),
      _bankNameController = TextEditingController(),
      _ibanController = TextEditingController(),
      _universityName = TextEditingController(),
      _order = TextEditingController();

  dynamic acceptAttatchment, researchAttatchment;
  bool isAcceptedFromNBU = false, isNotSupportFromAnyWorkBeside = false;
  String financePriortyId = '-1',
      applicantRoleId = '-1',
      _universityRanking = '-1';
  final List _universityRanks = [
    {'id': -1, 'nameAr': 'التصنيف'},
    {'id': 1, 'nameAr': 'سنغهاي'},
    {'id': 2, 'nameAr': 'QS'},
  ];
  String acceptDate = '-1';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    financePriorties.insert(
      0,
      {
        'id': -1,
        'nameAr': "الاولوية البحثية التي يندرج تحتها البحث",
        'nameEn': 'Select',
        'isActive': true
      },
    );
    researcherRoles.insert(
      0,
      {'id': -1, 'nameAr': 'دور مقدم الطلب', 'nameEn': 'Select'},
    );

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.15, left: 10.w, right: 10.w, bottom: 8.h),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputField(
                      validate: true,
                      hint: 'عنوان البحث',
                      controller: _titleController,
                    ),
                    SizedBox(height: 10.h),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return dataDropdown(
                          items: financePriorties,
                          color: financePriortyId != '-1'
                              ? colorPrimaryLight
                              : colorRed,
                          item: financePriortyId,
                          onItemSelected: (value) {
                            setState(() {
                              financePriortyId = value; // Update selected value
                            });
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      validate: true,
                      hint: "اسم المجلة العلمية",
                      controller: _magazineNameController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      validate: true,
                      hint: "مجال تخصص المجلة",
                      controller: _filedSpecificController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      validate: true,
                      hint: 'الموقع الالكتروني للمجلة',
                      controller: _websiteController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      validate: true,
                      hint: 'الرقم التسلسلي الدولي الموحد (ISSN)',
                      controller: _issnController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      validate: true,
                      hint: 'عدد المشاركين الكلي',
                      controller: _totalSubscribersController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      validate: true,
                      hint: 'من الجامعة',
                      controller: _fromNBUController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      validate: true,
                      hint: 'من خارج الجامعة',
                      controller: _outsideNBUController,
                    ),
                    SizedBox(height: 10.h),
                    if (type == '3') ...[
                      InputField(
                        validate: true,
                        hint: 'إسم الجامعة',
                        controller: _universityName,
                      ),
                      SizedBox(height: 10.h),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return dataDropdown(
                            items: _universityRanks,
                            color: _universityRanking != '-1'
                                ? colorPrimaryLight
                                : colorRed,
                            item: _universityRanking,
                            onItemSelected: (value) {
                              setState(() {
                                _universityRanking = value;
                                print(_universityRanks[
                                    int.parse(_universityRanking)]['nameAr']);
                              });
                            },
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      InputField(
                        validate: true,
                        hint: "الترتيب",
                        controller: _order,
                      ),
                      SizedBox(height: 10.h),
                    ],
                    if (type != '4')
                      StatefulBuilder(
                        builder: (context, setState) {
                          return dataDropdown(
                            items: researcherRoles,
                            color: applicantRoleId != '-1'
                                ? colorPrimaryLight
                                : colorRed,
                            item: applicantRoleId,
                            onItemSelected: (value) {
                              setState(() {
                                applicantRoleId = value;
                              });
                            },
                          );
                        },
                      ),
                    StatefulBuilder(builder: (context, setState) {
                      return Container(
                        width: Get.width,
                        margin: EdgeInsets.symmetric(vertical: 8.sp),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isAcceptedFromNBU ||
                                    isNotSupportFromAnyWorkBeside
                                ? colorPrimaryLight
                                : colorRed,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Wrap(
                          children: [
                            buildCheckBox(
                                title:
                                    'تم قبول البحث للنشر خلال عملك في جامعة الحدود الشمالية',
                                isChecked: isAcceptedFromNBU,
                                onChecked: (value) {
                                  setState(() {
                                    isAcceptedFromNBU = value ?? false;
                                  });
                                }),
                            buildCheckBox(
                                title:
                                    'لم يتم دعم البحث من أي جهة أخرى بالجامعة',
                                isChecked: isNotSupportFromAnyWorkBeside,
                                onChecked: (value) {
                                  setState(() {
                                    isNotSupportFromAnyWorkBeside =
                                        value ?? false;
                                  });
                                }),
                          ],
                        ),
                      );
                    }),
                    Text(
                      ' تاريخ قبول النشر النهائي للبحث :',
                      style: appTextStyle.copyWith(
                        color: colorPrimary,
                      ),
                    ),
                    Container(
                      height: 75.h,
                      width: Get.width,
                      margin: EdgeInsets.symmetric(vertical: 8.sp),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colorPrimaryLight,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (DateTime value) {
                          acceptDate = value.toString().substring(0, 10);
                        },
                        mode: CupertinoDatePickerMode.date,
                        backgroundColor: colorPrimaryLighter,
                        dateOrder: DatePickerDateOrder.ymd,
                      ),
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(vertical: 8.sp),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colorPrimaryLight,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: StatefulBuilder(builder: (context, setState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildAttatchButton(
                              title: 'مرفق القبول',
                              icon: acceptAttatchment != null
                                  ? Icon(
                                      FontAwesomeIcons.fileCircleCheck,
                                      color: colorLightGreen,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.fileCircleXmark,
                                      color: colorRed,
                                    ),
                              onAttachmentUploaded: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  File file = File(result.paths.first!);
                                  setState(() {
                                    acceptAttatchment = file;
                                  });
                                }
                              },
                            ),
                            buildAttatchButton(
                              title: 'مرفق البحث',
                              icon: researchAttatchment != null
                                  ? Icon(
                                      FontAwesomeIcons.fileCircleCheck,
                                      color: colorLightGreen,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.fileCircleXmark,
                                      color: colorRed,
                                    ),
                              onAttachmentUploaded: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  File file = File(result.paths.first!);
                                  setState(() {
                                    researchAttatchment = file;
                                  });
                                }
                              },
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      validate: true,
                      hint: ' اسم البنك',
                      controller: _bankNameController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      validate: true,
                      hint: 'رقم الايبان',
                      controller: _ibanController,
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: CustomButton(
                        callBack: () {
                          validateForm();
                        },
                        label: 'حفظ',
                        fontSize: 18,
                        padding: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                  'بيانات البحث العلمي المقبول للنشر',
                  style: largeTitleStyle.copyWith(
                      color: colorWhite, fontSize: 14.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckBox({
    required String title,
    required bool isChecked,
    required onChecked,
  }) {
    return CheckboxListTile(
      title: Text(
        title,
        style: appTextStyle.copyWith(
          color: isChecked ? colorLightGreen : colorBlack,
        ),
      ),
      checkColor: isChecked ? colorLightGreen : colorBlack,
      value: isChecked,
      onChanged: onChecked,
    );
  }

  Widget buildAttatchButton(
      {required String title,
      required onAttachmentUploaded,
      required Icon icon}) {
    return TextButton.icon(
      label: Text(title),
      onPressed: onAttachmentUploaded,
      icon: icon,
    );
  }

  void validateForm() async {
    int total = int.parse(_totalSubscribersController.text);
    int from = int.parse(_fromNBUController.text);
    int out = int.parse(_outsideNBUController.text);

    if (total != from + out) {
      CustomSnackBar.showCustomErrorToast(
          message: 'عدد المشاركين الكلي لا يساوي العدد من داخل وخارج الجامعة!');
      return;
    }

    final bool allFieldsFilled = _formKey.currentState!.validate();
    if (allFieldsFilled &&
        (isAcceptedFromNBU || isNotSupportFromAnyWorkBeside) &&
        acceptDate != '-1' &&
        applicantRoleId != '-1' &&
        financePriortyId != '-1' &&
        acceptAttatchment != null &&
        researchAttatchment != null) {
      dio.MultipartFile acceptMultipartFile = dio.MultipartFile.fromFileSync(
          acceptAttatchment.path,
          filename: acceptAttatchment.path.split('/').last);
      dio.MultipartFile researchMultipartFile = dio.MultipartFile.fromFileSync(
          researchAttatchment.path,
          filename: researchAttatchment.path.split('/').last);
      final body = {
        'UniversityOrder': _order.text,
        'CollegeName': userData.collegeName,
        'CollegeCode': userData.collegeCode,
        'NidSectionPresident': presidentData['nid'],
        'AcceptFile': acceptMultipartFile,
        'ISSN': _issnController.text,
        'IsAcceptedFromNBU': isAcceptedFromNBU,
        'NameSectionPresident': presidentData['name'],
        'IBAN': _ibanController.text,
        'IsNotSupportFromAnyWorkBeside': isNotSupportFromAnyWorkBeside,
        'ScholarshipEndDate': type != '4' ? null : scholarshipEndDate,
        'UniversityRanking': type != '3'
            ? null
            : _universityRanks[int.parse(_universityRanking)]['nameAr'],
        'TotalCountParticipant': _totalSubscribersController.text,
        'EmployeeId': userData.id,
        'UniversityParticipantCount': _fromNBUController.text,
        'JobCode': userData.jobCode,
        'FinanceRequestTypeId': type,
        'ScholarshipDegree': scholarshipDegree,
        'FinancePriortyId': financePriortyId,
        'SectionName': userData.sectionName,
        'SectionCode': userData.sectionCode,
        'ApplicantRoleId': applicantRoleId,
        'ProjectId': projectId,
        'ScholarshipCountry': scholarshipCountry,
        'JobRankName': userData.lastJobRankName,
        'MagazineSubjectCategory': _filedSpecificController.text,
        'ResearchFile': researchMultipartFile,
        'Title': _titleController.text,
        'UniversityName': _universityName.text,
        'EmployeeName': userData.name,
        'OutsideUnivertstParticipantCount': _outsideNBUController.text,
        'MagazineUrl': _websiteController.text,
        'FinalPublicationAcceptanceDate': acceptDate,
        'Bank': _bankNameController.text,
        'ScholarshipId': scholarshipId ?? userData.scholarId,
        'MagazineName': _magazineNameController.text
      };
      dio.FormData formData = dio.FormData.fromMap(body);

      Get.to(() => PresidentAgreement(
            formBody: formData,
            presidentName: presidentData['name'],
            userId: userData.nid!,
          ));
    } else {
      CustomSnackBar.showCustomErrorToast(message: 'يجب إدخال جميع الحقول!!!');
      return;
    }
  }
}

Widget dataDropdown({
  required String item,
  required List items,
  required ValueChanged<String> onItemSelected,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
    width: Get.width,
    decoration: BoxDecoration(
      border: Border.all(
        color: color,
      ),
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: item,
        items: items
            .map((it) => DropdownMenuItem<String>(
                  value: it['id'] == null ? '' : it['id'].toString(),
                  enabled: it['id'] != -1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      it['nameAr'],
                      style: TextStyle(
                        color: it['id'] != -1 ? colorPrimary : colorBlackLight,
                      ),
                    ),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null && value != '-1') {
            onItemSelected(value);
          }
        },
      ),
    ),
  );
}
