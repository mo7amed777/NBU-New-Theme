import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/reserve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';

import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../controllers/api_controller.dart';

class UserReservations extends StatefulWidget {
  UserReservations({required this.data});

  final List data;

  @override
  State<UserReservations> createState() => _UserReservationsState();
}

class _UserReservationsState extends State<UserReservations> {
  List reservations = [];
  String filter = 'حجوزات قادمة';

  @override
  void initState() {
    super.initState();
    widget.data.sort((a, b) =>
        a['field_appointment_date'].compareTo(b['field_appointment_date']));
    reservations = List.from(widget.data);
    filterTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: Get.height * 0.22, left: 8.w, right: 8.w),
                child: reservations.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/no-data.gif'),
                          ),
                          SizedBox(height: 32),
                          Text(
                            'لا يوجد لديك $filter',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: reservations.map(((userReserve) {
                        ReserveModel reserveModel =
                            ReserveModel.fromJson(userReserve);
                        return Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.sp),
                              margin: EdgeInsets.all(10.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: const [
                                    colorPrimary,
                                    colorPrimary,
                                    colorPrimary,
                                    colorPrimary,
                                    colorPrimary,
                                    colorPrimary,
                                    colorLightGreen,
                                    colorLightGreen,
                                  ],
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      reserveModel.clinicName ?? '',
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 18.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        reserveModel.date ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        reserveModel.time ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 18.h),
                                  Center(
                                    child: Text(
                                      reserveModel.doctorName!.trim(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    reserveModel.mobile ?? '',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (DateTime.parse(reserveModel.date!)
                                .isAfter(DateTime.now()))
                              Positioned(
                                  top: 8.h,
                                  left: 8.w,
                                  child: IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.circleXmark,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Get.defaultDialog(
                                          title: 'إلغاء الحجز',
                                          middleText:
                                              'هل أنت متأكد من إلغاء الحجز لديك ؟',
                                          confirm: CustomButton(
                                            callBack: () async {
                                              Get.back();
                                              APIController apicontroller =
                                                  APIController(
                                                url:
                                                    'https://mobileapi.nbu.edu.sa/api/HealthExternalApi/DeleteReserve?Id=${reserveModel.id}',
                                                requestType: RequestType.post,
                                              );
                                              await apicontroller.getData();
                                              if (apicontroller.apiCallStatus ==
                                                      ApiCallStatus.success &&
                                                  apicontroller.data['res']) {
                                                CustomSnackBar.showCustomSnackBar(
                                                    message:
                                                        'تم الغاء الحجز بنجاح',
                                                    title: 'نجاح');
                                                setState(() {
                                                  reservations.removeWhere(
                                                      (element) =>
                                                          element[
                                                              'field_appointment_id'] ==
                                                          reserveModel.id);
                                                });
                                              }
                                            },
                                            label: 'تأكيد الإلغاء',
                                            fontSize: 14.sp,
                                            padding: 8.sp,
                                          ),
                                          cancel: CustomButton(
                                            callBack: () async {
                                              Get.back();
                                            },
                                            label: 'تراجع',
                                            fontSize: 14.sp,
                                            padding: 8.sp,
                                          ),
                                        );
                                      })),
                          ],
                        );
                      })).toList())),
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
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorPrimary,
                ),
                child: Text(
                  'الحجوزات',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.14,
            child: Center(
              child: SizedBox(
                width: 300.w,
                child: DropdownButton<String>(
                  value: filter,
                  underline: Container(height: 1, color: Color(0xff337c3d)),
                  isExpanded: true,
                  items: ['حجوزات قادمة', 'حجوزات سابقة'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: appTextStyle,
                      ),
                    );
                  }).toList(),
                  hint: Text('نوع الحجز'),
                  onChanged: (value) {
                    setState(() {
                      filter = value!;
                      filterTimes();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void filterTimes() {
    DateTime now = DateTime.now();
    switch (filter) {
      case 'حجوزات سابقة':
        reservations = widget.data
            .where((time) =>
                DateTime.parse(time['field_appointment_date']).isBefore(now))
            .toList()
            .reversed
            .toList();

        break;
      case 'حجوزات قادمة':
        reservations = widget.data
            .where((time) =>
                DateTime.parse(time['field_appointment_date']).isAfter(now))
            .toList();
        break;
    }
  }
}
