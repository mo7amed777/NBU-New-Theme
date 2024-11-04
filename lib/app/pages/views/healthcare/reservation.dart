import 'dart:convert';

import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/components/input_field.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/healthcare/user_reservations.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Reservation extends StatefulWidget {
  final List clinics;
  final String userID;

  Reservation({required this.userID, required this.clinics});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  List doctors = [];

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
                child: MyDropdownExample(
                  clinics: widget.clinics,
                  userId: widget.userID,
                )),
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
                  'حجز موعد',
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

class MyDropdownExample extends StatefulWidget {
  final List clinics;
  final String userId;

  MyDropdownExample({required this.clinics, required this.userId});

  @override
  _MyDropdownExampleState createState() => _MyDropdownExampleState();
}

class _MyDropdownExampleState extends State<MyDropdownExample> {
  String? selectedClinic;
  String? selectedDoctor;
  List doctors = [];

  Future<void> fetchdoctors(String clinicid) async {
    APIController apicontroller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/HealthExternalApi/PhysicianByClinicId?clinicid=$clinicid');
    await apicontroller.getData();
    if (apicontroller.apiCallStatus == ApiCallStatus.success &&
        apicontroller.data['res']) {
      setState(() {
        doctors = apicontroller.data['responseObject'];
      });
    }
  }

  String selectedTime = "not available";
  String date = "";
  List timeChips = [];
  String reserveType = 'نفسي';
  TextEditingController attendController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        child: Card(
          elevation: 0.0,
          margin: EdgeInsets.all(8.sp),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)
                // Adjust the bottom right border radius
                ),
            side: BorderSide(
              color: Color(
                  0xff337c3d), // Change this color to the desired border color
              // Change this value to the desired border width
            ),
          ),
          shadowColor: Color(0xff9ab83d),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '* ملاحظة يمكنك الحجز لنفسك أو للتابعين *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    height: 4,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text('الحجز ل : ',
                        style: TextStyle(
                          color: Color(0xff9ab83d),
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            reserveType = 'نفسي';
                          });
                        },
                        child: Row(
                          children: [
                            CupertinoRadio(
                                value: 'نفسي',
                                groupValue: reserveType,
                                activeColor: Color(0xff9ab83d),
                                onChanged: (String? value) {
                                  setState(() {
                                    reserveType = value!;
                                  });
                                }),
                            SizedBox(width: 4),
                            Text(
                              'نفسي',
                              style: TextStyle(
                                color: colorPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            reserveType = 'تابع';
                          });
                        },
                        child: Row(
                          children: [
                            CupertinoRadio(
                                value: 'تابع',
                                groupValue: reserveType,
                                activeColor: Color(0xff9ab83d),
                                onChanged: (String? value) {
                                  setState(() {
                                    reserveType = value!;
                                  });
                                }),
                            SizedBox(width: 4),
                            Text(
                              'تابع',
                              style: TextStyle(
                                color: colorPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Center(
                  child: SizedBox(
                    width: 300.w,
                    child: DropdownButton<String>(
                      value: selectedClinic,
                      isExpanded: true,
                      underline: Container(height: 1, color: Color(0xff337c3d)),
                      items: widget.clinics
                          .map<DropdownMenuItem<String>>((clinic) {
                        return DropdownMenuItem<String>(
                          value: clinic['clinic-id'],
                          child: Text(
                            clinic['clinic-name-ar'],
                            style: TextStyle(
                              color: colorPrimary,
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Text('اختر العياده'),
                      iconEnabledColor: colorBlackLighter,
                      onChanged: (value) {
                        setState(() {
                          selectedClinic = value;
                          selectedDoctor = null;
                        });

                        // Fetch doctors based on the selected clinic
                        fetchdoctors(value!);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (selectedClinic != null)
                  Center(
                    child: SizedBox(
                      width: 300.w,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedDoctor,
                        underline:
                            Container(height: 1, color: Color(0xff337c3d)),
                        items: doctors.map<DropdownMenuItem<String>>((doctor) {
                          return DropdownMenuItem<String>(
                            value: doctor['physician-id'],
                            child: Text(
                              doctor['physician-name'],
                              style: TextStyle(
                                color: colorPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                        hint: Text('اختر الطبيب'),
                        iconEnabledColor: colorBlackLighter,
                        onChanged: (value) async {
                          selectedDoctor = value;
                          date = DateTime.now().toString().substring(0, 10);
                          APIController apicontroller = APIController(
                              url:
                                  'https://mobileapi.nbu.edu.sa/api/HealthExternalApi/GetAvailableTime?Date=$date&DoctorId=$selectedDoctor');
                          await apicontroller.getData();
                          if (apicontroller.apiCallStatus ==
                              ApiCallStatus.success) {
                            List availableTimes = apicontroller.data;
                            if (availableTimes.isEmpty) {
                              CustomSnackBar.showCustomSnackBar(
                                  title: 'غير متاح',
                                  color: Colors.red[400],
                                  message:
                                      'لا يوجد اوقات متاحه اليوم اختر يوم اخر');

                              selectedTime = "not available";
                              setState(() {
                                timeChips.clear();
                              });
                            } else {
                              setState(() {
                                timeChips.clear();
                              });
                              for (int i = 0; i < availableTimes.length; i++) {
                                timeChips.add(availableTimes[i]);
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                if (reserveType == 'تابع')
                  InputField(
                    label: 'إسم التابع',
                    hint: 'إسم التابع',
                    controller: attendController,
                    keyboardType: TextInputType.name,
                  ),
                if (reserveType == 'تابع') SizedBox(height: 10),
                if (reserveType == 'تابع')
                  InputField(
                    label: 'رقم الهوية',
                    hint: 'رقم الهوية',
                    controller: nameController,
                    keyboardType: TextInputType.number,
                  ),
                if (reserveType == 'تابع') SizedBox(height: 10),
                SizedBox(height: 20.h),
                Visibility(
                  visible: selectedDoctor != null,
                  child: SizedBox(
                    height: 100.h,
                    child: CupertinoDatePicker(
                      minimumDate: DateTime.now(),
                      initialDateTime: DateTime.now(),
                      maximumDate: DateTime.now().add(Duration(days: 14)),
                      backgroundColor: colorWhite,
                      mode: CupertinoDatePickerMode.date,
                      dateOrder: DatePickerDateOrder.dmy,
                      onDateTimeChanged: (selectedDate) async {
                        date = selectedDate.toString().substring(0, 10);
                        APIController apicontroller = APIController(
                            url:
                                'https://mobileapi.nbu.edu.sa/api/HealthExternalApi/GetAvailableTime?Date=$date&DoctorId=$selectedDoctor');
                        await apicontroller.getData();
                        if (apicontroller.apiCallStatus ==
                            ApiCallStatus.success) {
                          List availableTimes = apicontroller.data;
                          if (availableTimes.isEmpty) {
                            CustomSnackBar.showCustomSnackBar(
                                title: 'غير متاح',
                                color: Colors.red[400],
                                message:
                                    'لا يوجد اوقات متاحه هذا اليوم اختر يوم اخر');
                            selectedTime = "not available";
                            setState(() {
                              timeChips = [];
                            });
                          } else {
                            setState(() {
                              timeChips = [];
                            });
                            for (int i = 0; i < availableTimes.length; i++) {
                              timeChips.add(availableTimes[i]);
                            }
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Visibility(
                  visible: timeChips.isNotEmpty,
                  child: ExpansionTile(
                    collapsedShape: RoundedRectangleBorder(
                        side: BorderSide(color: colorPrimary),
                        borderRadius: BorderRadius.circular(10)),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: colorPrimary),
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(
                      'المواعيد المتاحه',
                      style: TextStyle(
                        color: Color(0xff337c3d),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      SizedBox(
                        height: 300,
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2.5, crossAxisCount: 3),
                          children: timeChips
                              .map(
                                (time) => ChoiceChip(
                                  padding: EdgeInsets.all(2.sp),
                                  selectedColor: Color(0xff9ab83d),
                                  showCheckmark: false,
                                  label: Text(
                                    checkTime((time as Map).values.first),
                                    style: smallTitleStyle.copyWith(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  selected: selectedTime == (time).keys.first,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selectedTime = (selected
                                          ? (time).keys.first
                                          : "not available");
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                if (selectedTime != 'not available')
                  Center(
                    child: CustomButton(
                        callBack: () async =>
                            await showLoadingOverlay(asyncFunction: () async {
                              Map<String, dynamic> userData =
                                  MySharedPref.getUserData();
                              Map user = {};
                              String userName = '';
                              if (userData['userType'] == 'student') {
                                user = userData['user'];
                                userName =
                                    '${user['firstNameAr'] ?? ''} ${user['midNameAr'] ?? ''} ${user['lastNameAr'] ?? ''}';
                              } else {
                                user = jsonDecode(userData['user']);
                                userName = user['arabicName'] ??
                                    user['latinFullName'] ??
                                    '';
                              }
                              Map body = {
                                "title": widget.userId,
                                "reserved_name": userName,
                                "child_id": reserveType == 'نفسي'
                                    ? null
                                    : attendController.value.text,
                                "attendant_name": reserveType == 'نفسي'
                                    ? null
                                    : nameController.value.text,
                                "clinic_id": selectedClinic,
                                "physician_id": selectedDoctor,
                                "time": selectedTime,
                                "mobile": "",
                                "date": date,
                                "target_id": "appointments"
                              };
                              APIController apicontroller = APIController(
                                  url:
                                      'https://mobileapi.nbu.edu.sa/api/HealthExternalApi/Reserve',
                                  requestType: RequestType.post,
                                  body: body);
                              await apicontroller.getData();
                              if (apicontroller.apiCallStatus ==
                                      ApiCallStatus.success &&
                                  apicontroller.data['res']) {
                                CustomSnackBar.showCustomSnackBar(
                                    message: 'تم الحجز بنجاح', title: 'نجاح');
                                APIController apointController = APIController(
                                  url:
                                      'https://mobileapi.nbu.edu.sa/api/HealthExternalApi/GetAppointmentsByUserID?UserID=${widget.userId}',
                                );
                                await apointController.getData();
                                if (apointController.apiCallStatus ==
                                        ApiCallStatus.success &&
                                    apointController.data['res']) {
                                  Get.off(() => UserReservations(
                                      data: apointController
                                          .data['responseObject']));
                                }
                              }
                            }),
                        fontSize: 18,
                        padding: 8,
                        icon: FontAwesomeIcons.check,
                        label: 'حجز الموعد'),
                  ),
              ],
            ),
          ),
        ));
  }

  String checkTime(String time) {
    print(time.length);
    if (time.length < 12)
      return '   $time  ';
    else if (time.length < 14)
      return ' $time  ';
    else
      return time;
  }
}
