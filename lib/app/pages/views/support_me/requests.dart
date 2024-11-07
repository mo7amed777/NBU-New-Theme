import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:delta_to_html/delta_to_html.dart';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/data/models/support.dart';
import 'package:eservices/app/data/models/support_data.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/support_me/request_details.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SupportRequests extends StatefulWidget {
  @override
  _SupportRequestsState createState() => _SupportRequestsState();
}

class _SupportRequestsState extends State<SupportRequests> {
  static const _pageSize = 10;

  final PagingController<int, SupportRequest> _pagingController =
      PagingController(firstPageKey: 1);

  QuillController rateNotesController = QuillController.basic();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await getSupportRequests(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<List<SupportRequest>> getSupportRequests(
      int pageKey, int pageSize) async {
    APIController controller = APIController(
        url:
            'https://crm.nbu.edu.sa/api/Request/GetRequests?page=$pageKey&pageSize=$pageSize');
    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success) {
      List data = controller.data['returnObject'];
      List<SupportRequest> requests = [];
      for (var req in data) {
        requests.add(SupportRequest.fromJson(req));
      }
      return requests;
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
                  child: PagedListView<int, SupportRequest>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<SupportRequest>(
                      itemBuilder: (context, req, index) => InkWell(
                        onTap: () => showDetails(req.encId!),
                        child: MyCard(
                          title: '# ${req.id ?? ''}   ',
                          subTitle: req.statusNameAr ?? req.statusNameEn ?? '',
                          onTap: () => showDetails(req.encId!),
                          desc: req.title ?? '',
                          fullWidth: true,
                          icon: getStatusIcon(req.statusId!),
                          iconColor: getStatusColor(req.statusId!),
                          rateBar: rateBar(
                              rate: req.rate ?? 0,
                              id: req.id!,
                              canRate:
                                  (req.statusId == 2 || req.statusId == 3) &&
                                      req.rate == null),
                        ),
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
                              'لا يوجد تذاكر',
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
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: colorPrimary,
                  ),
                  child: Text(
                    'التذاكر',
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

// 1: pending, 2: completed, 3: cancelled, 4: inProgress
  Color getStatusColor(int statusId) {
    switch (statusId) {
      case 1:
        return const Color.fromARGB(232, 187, 204, 35);
      case 2:
        return colorPrimary;
      case 3:
        return colorRed;
      case 4:
        return colorLightGreen;
      default:
        return colorPrimary;
    }
  }

  IconData getStatusIcon(int statusId) {
    switch (statusId) {
      case 1:
        return FontAwesomeIcons.hourglassStart;
      case 2:
        return FontAwesomeIcons.circleCheck;
      case 3:
        return FontAwesomeIcons.x;
      case 4:
        return FontAwesomeIcons.spinner;
      default:
        return FontAwesomeIcons.hourglassStart;
    }
  }

  void showDetails(String id) async {
    await showLoadingOverlay(asyncFunction: () async {
      APIController controller = APIController(
          url:
              'https://crm.nbu.edu.sa/api/Request/GetRequestData?RequestId=$id');
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success &&
          controller.data['returnObject'] != null) {
        SupportData supportData =
            SupportData.fromJson(controller.data['returnObject']);
        Get.to(() => RequestDetails(supportData: supportData));
      }
    });
  }

  Widget rateBar({required int rate, required int id, bool canRate = true}) {
    return AnimatedRatingStars(
      initialRating: rate.toDouble(),
      minRating: 0,
      maxRating: 5,
      filledColor: Colors.amber,
      emptyColor: Colors.grey,
      filledIcon: Icons.star,
      halfFilledIcon: Icons.star_half,
      emptyIcon: Icons.star_border,
      readOnly: !canRate,
      onChanged: (double rating) {
        Get.defaultDialog(
            title: 'اضافة ملاحظات',
            confirm: CustomButton(
              callBack: () async {
                Get.back();
                final deltaJson =
                    rateNotesController.document.toDelta().toJson();
                String notesHtml = DeltaToHTML.encodeJson(
                  List.castFrom(deltaJson),
                );
                await showLoadingOverlay(asyncFunction: () async {
                  APIController controller = APIController(
                    url: 'https://crm.nbu.edu.sa/api/Request/SetRateOfRequest',
                    body: {
                      "id": id,
                      "rate": rating.round(),
                      "notes": notesHtml,
                    },
                    requestType: RequestType.post,
                  );

                  await controller.getData();
                  if (controller.apiCallStatus == ApiCallStatus.success) {
                    Get.back();
                    CustomSnackBar.showCustomSnackBar(
                      title: 'نجاح',
                      message: 'تم حفظ التقييم بنجاح',
                    );
                    // } else {
                    //   CustomSnackBar.showCustomErrorSnackBar(
                    //     title: 'خطأ في الاتصال',
                    //     message: "حدث خطأ في الاتصال بالسيرفر يرجى المحاولة مرة أخرى!",
                    //   );
                    // }
                  }
                });
              },
              label: 'حفظ',
              fontSize: 14.sp,
              padding: 8.sp,
            ),
            content: SizedBox(
              height: 150.h,
              width: 300.w,
              child: Column(
                children: [
                  QuillSimpleToolbar(
                    controller: rateNotesController,
                    configurations: QuillSimpleToolbarConfigurations(
                      multiRowsDisplay: false,
                      showRedo: false,
                      showUndo: false,
                    ),
                  ),
                  Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: colorLightGreen),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: QuillEditor.basic(
                      controller: rateNotesController,
                      configurations: const QuillEditorConfigurations(
                          showCursor: true,
                          expands: false,
                          scrollable: true,
                          maxHeight: 50,
                          padding: EdgeInsets.all(8.0)),
                    ),
                  ),
                ],
              ),
            ));
      },
      displayRatingValue: true,
      interactiveTooltips: true,
      customFilledIcon: Icons.star,
      customHalfFilledIcon: Icons.star_half,
      customEmptyIcon: Icons.star_border,
      starSize: 18.sp,
      animationDuration: Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
    );
  }
}
