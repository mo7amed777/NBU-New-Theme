import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/finance_request_details.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/research/my_requests/my_finance_request_details.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyFinanceRequests extends StatelessWidget {
  MyFinanceRequests({required this.requests});
  final List requests;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          requests.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/no-data.gif'),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'لا يوجد لديك طلبات',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 25.sp,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.15, left: 8.w, right: 8.w),
                  child: SizedBox(
                    height: Get.height,
                    child: AnimationLimiter(
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.25, crossAxisCount: 1),
                        physics: BouncingScrollPhysics(),
                        children: List.generate(
                          requests.length,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              columnCount: 1,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: FinanceCard(
                                    projectID: requests[index]['projectId'],
                                    title: requests[index]['title'] ?? '',
                                    type: requests[index]
                                            ['arNameFinanceRequestType'] ??
                                        '',
                                    date: requests[index]['date'] ?? '',
                                    requestId:
                                        requests[index]['requestId'].toString(),
                                    financeStatus: requests[index]
                                        ['arNameFinanceStatus'],
                                    statusId: requests[index]
                                        ['financeStatusId'],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
                  'طلباتي',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget FinanceCard({
    required int statusId,
    required String projectID,
    required String financeStatus,
    required String requestId,
    required String date,
    required String type,
    required String title,
  }) {
    Color color = statusId == 3
        ? colorLightGreen
        : statusId == 4
            ? colorRed
            : Colors.orange;
    return Card(
        margin: EdgeInsets.all(8.sp),
        color: colorWhite,
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0), // Adjust the top left border radius
            // Adjust the bottom right border radius
          ),
        ),
        shadowColor: Color(0xff9ab83d),
        child: InkWell(
          onTap: () => getFinanceRequestDetails(id: requestId),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.sp),
                      margin: EdgeInsets.only(top: 16.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(
                              0xffd1dfd9), // Change this color to the desired border color
                          width:
                              1.9, // Change this value to the desired border width
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ), // Optional: Add border radius for rounded corners
                      child: Icon(
                        FontAwesomeIcons.fileInvoiceDollar,
                        size: 25.sp,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      projectID,
                      style: mediumTitleStyle.copyWith(color: color),
                    ),
                    SizedBox(height: 16.h),
                    CustomRow(
                      title: 'عنوان البحث',
                      trailing: title,
                    ),
                    CustomRow(
                      title: 'النوع',
                      trailing: type,
                    ),
                    CustomRow(
                      title: 'التاريخ',
                      trailing: date,
                      isLast: true,
                    ),
                  ],
                ),
                Positioned(
                  left: 1,
                  top: 1,
                  child: Container(
                    padding: EdgeInsets.all(6.sp),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25)),
                    ),
                    child: Text(
                      financeStatus,
                      style: appTextStyle.copyWith(color: colorWhite),
                    ), // Opt
                  ),
                ),
                Positioned(
                  right: 1,
                  top: 1,
                  child: Container(
                    padding: EdgeInsets.all(4.sp),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),
                    child: Text(
                      '   # $requestId  ',
                      style: appTextStyle.copyWith(color: colorWhite),
                    ), // Opt
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void getFinanceRequestDetails({required String id}) async {
    await showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getResearchToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
        url:
            'https://researchtest.nbu.edu.sa/api/FinanceRequest/GetRequestDetails?Id=$id',
        headers: {'Authorization': headers},
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success &&
          controller.data['returnObject'] != null) {
        final data = controller.data['returnObject'];
        FinanceRequestDetails requestDetails =
            FinanceRequestDetails.fromJson(data);
        Get.to(() => MyFinanceRequestDetails(requestDetails: requestDetails));
      }
    });
  }
}
