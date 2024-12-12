import 'dart:io';

import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/input_field.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FinanceRequestForm extends StatelessWidget {
  FinanceRequestForm(
      {super.key,
      required this.financePriorties,
      required this.researcherRoles,
      required this.userData,
      required this.projectId,
      required this.presidentData});
  List financePriorties, researcherRoles;
  final Map<String, dynamic> userData, presidentData;
  final String projectId;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _magazineNameController = TextEditingController();
  TextEditingController _filedSpecificController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();
  TextEditingController _issnController = TextEditingController();
  TextEditingController _totalSubscribersController = TextEditingController();
  TextEditingController _fromNBUController = TextEditingController();
  TextEditingController _outsideNBUController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _ibanController = TextEditingController();

  dynamic acceptAttatchment, researchAttatchment;
  bool isAcceptedFromNBU = false, isNotSupportFromAnyWorkBeside = false;
  String financePriortyId = '-1', applicantRoleId = '-1';
  late String acceptDate;

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
                top: Get.height * 0.15, left: 10.w, right: 10.w),
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputField(
                      hint: 'عنوان البحث',
                      controller: _titleController,
                    ),
                    SizedBox(height: 10.h),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return dataDropdown(
                          items: financePriorties,
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
                      hint: "اسم المجلة العلمية",
                      controller: _magazineNameController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      hint: "مجال تخصص المجلة",
                      controller: _filedSpecificController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      hint: 'الموقع الالكتروني للمجلة',
                      controller: _websiteController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      hint: 'الرقم التسلسلي الدولي الموحد (ISSN)',
                      controller: _issnController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      hint: 'عدد المشاركين الكلي',
                      controller: _totalSubscribersController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      hint: 'من الجامعة',
                      controller: _fromNBUController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      hint: 'من خارج الجامعة',
                      controller: _outsideNBUController,
                    ),
                    SizedBox(height: 10.h),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return dataDropdown(
                          items: researcherRoles,
                          item: applicantRoleId,
                          onItemSelected: (value) {
                            setState(() {
                              applicantRoleId = value;
                            });
                          },
                        );
                      },
                    ),
                    Wrap(
                      children: [
                        StatefulBuilder(builder: (context, setState) {
                          return buildCheckBox(
                              title:
                                  'تم قبول البحث للنشر خلال عملك في جامعة الحدود الشمالية',
                              isChecked: isAcceptedFromNBU,
                              onChecked: (value) {
                                setState(() {
                                  isAcceptedFromNBU = value ?? false;
                                });
                              });
                        }),
                        StatefulBuilder(builder: (context, setState) {
                          return buildCheckBox(
                              title: 'لم يتم دعم البحث من أي جهة أخرى بالجامعة',
                              isChecked: isNotSupportFromAnyWorkBeside,
                              onChecked: (value) {
                                setState(() {
                                  isNotSupportFromAnyWorkBeside =
                                      value ?? false;
                                });
                              });
                        }),
                      ],
                    ),
                    Text(
                      ' تاريخ قبول النشر النهائي للبحث :',
                      style: appTextStyle.copyWith(
                        color: colorPrimary,
                      ),
                    ),
                    Container(
                      height: 100.h,
                      width: Get.width,
                      margin: EdgeInsets.symmetric(vertical: 8.sp),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colorPrimaryLight,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (value) {
                          acceptDate = value.toString().substring(0, 10);
                        },
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
                      hint: ' اسم البنك',
                      controller: _bankNameController,
                    ),
                    SizedBox(height: 10.h),
                    InputField(
                      hint: 'رقم الايبان',
                      controller: _ibanController,
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: CustomButton(
                        callBack: () {
                          try {
                            getPresidentDecision();
                          } catch (e) {
                            CustomSnackBar.showCustomErrorToast(
                                message:
                                    'حدث خطاء في الاتصال بالانترنت برجاء المحاولة في وقت لاحق');
                            return;
                          }
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

  Widget buildCheckBox(
      {required String title, required bool isChecked, required onChecked}) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorPrimaryLight,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: CheckboxListTile(
          title: Text(
            title,
            style: appTextStyle.copyWith(
              color: isChecked ? colorLightGreen : colorBlack,
            ),
          ),
          checkColor: isChecked ? colorLightGreen : colorBlack,
          value: isChecked,
          onChanged: onChecked),
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

  void getPresidentDecision() async {
    //Validate all fields required and move to next screen for president sign and form submit
  }
}

Widget dataDropdown({
  required String item,
  required List items,
  required ValueChanged<String> onItemSelected,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
    width: Get.width,
    decoration: BoxDecoration(
      border: Border.all(
        color: colorPrimaryLight,
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
