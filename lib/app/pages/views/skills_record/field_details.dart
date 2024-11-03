import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/term_course.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/skills_record/term_details.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FieldDetails extends StatefulWidget {
  final int id;
  final String title;

  const FieldDetails({required this.id, required this.title});
  @override
  _FieldDetailsState createState() => _FieldDetailsState();
}

class _FieldDetailsState extends State<FieldDetails> {
  static const _pageSize = 10;

  final PagingController<int, Map> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  void fetchPage(int pageKey) async {
    try {
      final newItems = await getFieldDetails(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<List<Map>> getFieldDetails(int pageKey, int pageSize) async {
    String token = MySharedPref.getSkillsRecordToken();
    var headers = 'Bearer $token';
    APIController controller = APIController(headers: {
      'Authorization': headers
    }, url: 'https://mahari.nbu.edu.sa/api/Student/GetAllAvailableCourseAsPagination?categoryId=${widget.id}&currentPage=$pageKey&itemsPerPage=$pageSize');
    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success) {
      var data = controller.data['returnObject']['termCourses'];
      return List<Map>.from(data);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.15, left: 8.w, right: 8.w),
              child: SizedBox(
                height: Get.height,
                child: AnimationLimiter(
                  child: PagedListView<int, Map>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Map>(
                      itemBuilder: (context, req, index) => InkWell(
                        onTap: () => showDetails(req['id']),
                        child: Card(
                            color: Color(
                              int.parse(
                                req['color'].replaceFirst('#', '0xff'),
                              ),
                            ),
                            margin: EdgeInsets.all(8.sp),
                            // Change this color to the desired background color
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    15.0), // Adjust the top left border radius
                                // Adjust the bottom right border radius
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 8.h),
                                    Text(
                                      req['course']['arabicName'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: colorPrimary,
                                        fontWeight:
                                            req['course']['arabicName'].length >
                                                    17
                                                ? FontWeight.w900
                                                : FontWeight.bold,
                                        fontSize:
                                            req['course']['arabicName'].length >
                                                    35
                                                ? 12.sp
                                                : 14.sp,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(
                                          int.parse(
                                            req['color']
                                                .replaceFirst('#', '0xff'),
                                          ),
                                        ),
                                        border: Border.all(
                                          color: Color(
                                              0xffd1dfd9), // Change this color to the desired border color
                                          width:
                                              1.9, // Change this value to the desired border width
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.sp, vertical: 4.sp),
                                        child: Text(
                                          "عدد الساعات:  ${req['hours']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ), // Change this color to the desired background color
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${req['fromDate']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: colorLightGreen,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.sp),
                                          child: Icon(Icons.calendar_month),
                                        ),
                                        Text(
                                          "${req['toDate']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Column(
                                      children: (req['termScheduleList']
                                              as List)
                                          .map(
                                            (term) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${term['dayArabicName']}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: colorPrimary,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.sp),
                                                    child: Icon(
                                                        Icons.trending_down),
                                                  ),
                                                  Text(
                                                    "${term['fromTime']} - ${term['toTime']}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.sp,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    SizedBox(height: 12.h),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  'assets/images/no-data.gif',
                                )),
                            SizedBox(height: 32),
                            Text(
                              'لا يوجد دورات',
                              style: TextStyle(
                                color: colorPrimary,
                                fontSize: 25.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: widget.title.length >= 44
                  ? Get.height * 0.08
                  : Get.height * 0.066,
              left: 0.0,
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () => Get.back(),
              ),
            ),
            Positioned(
              top: Get.height * 0.07,
              right: 12.w,
              left: 32.w,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: colorPrimary,
                  ),
                  child: Text(
                    widget.title,
                    style: largeTitleStyle.copyWith(color: colorWhite),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void showDetails(int id) {
    showLoadingOverlay(asyncFunction: () async {
      String token = MySharedPref.getSkillsRecordToken();
      var headers = 'Bearer $token';
      APIController controller = APIController(
          url: 'https://mahari.nbu.edu.sa/api/Student/GetTermCourseById?id=$id',
          headers: {
            'Authorization': headers,
          });
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        TermCourse termCourse =
            TermCourse.fromJson(controller.data['returnObject']);
        Get.to(() => TermCourseDetails(termCourse: termCourse));
      }
    });
  }
}
