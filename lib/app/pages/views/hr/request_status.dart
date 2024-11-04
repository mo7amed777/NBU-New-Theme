import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/details_dialog.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/request_state.dart';
import 'package:eservices/app/pages/views/hr/courses.dart';
import 'package:eservices/config/theme/app_colors.dart';

class RequestStatus extends StatelessWidget {
  const RequestStatus({Key? key, required this.requests}) : super(key: key);

  final List requests;

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
                child: requests.isEmpty
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
                            'لا يوجد',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: requests.map(((request) {
                        RequestState req = RequestState.fromJson(request);
                        return MyCard(
                            title: req.orderType ?? '',
                            desc: req.orderFromDate ?? '',
                            margin: EdgeInsets.all(8.sp),
                            fullWidth: true,
                            icon: FontAwesomeIcons.magnifyingGlassChart,
                            subTitle: req.orderStatus ?? '',
                            onTap: () =>
                                showDetails(title: req.orderType ?? '', rows: [
                                  CustomRow(
                                    title: ' رقم الطلب: ',
                                    trailing: req.orderNumber ?? '',
                                  ),
                                  CustomRow(
                                    title: ' نوع الطلب: ',
                                    trailing: req.orderType ?? '',
                                  ),
                                  CustomRow(
                                    title: ' حالة الطلب: ',
                                    trailing: req.orderStatus ?? '',
                                  ),
                                  CustomRow(
                                    title: ' تاريخ بداية الطلب: ',
                                    trailing: req.orderFromDate ?? '',
                                  ),
                                  CustomRow(
                                    title: ' تاريخ انتهاء الطلب: ',
                                    trailing: req.orderToDate ?? '',
                                  ),
                                ]));
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
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colorPrimary,
                ),
                child: Text(
                  'الطلبات',
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
