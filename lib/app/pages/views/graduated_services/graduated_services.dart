import 'dart:convert';
import 'dart:typed_data';
import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/details_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/student_event.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/hr/courses.dart';
import 'package:eservices/app/pages/views/graduated_services/ticket.dart';
import 'package:eservices/app/pages/views/majales/signature/signature_draw.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../components/expandTile.dart';
import '../../../components/input_field.dart';

class MyInvites extends StatefulWidget {
  final String title;
  final List<Event>? invites;
  final List<Event>? relInvites;
  final List<Map<String, dynamic>>? codes;
  final String? code;

  MyInvites({
    Key? key,
    required this.title,
    this.invites,
    this.relInvites,
    this.codes,
    this.code,
  }) : super(key: key);

  @override
  State<MyInvites> createState() => _MyInvitesState();
}

class _MyInvitesState extends State<MyInvites> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Event> events = widget.title == "دعواتى"
        ? widget.invites ?? []
        : widget.relInvites ?? [];
    return Stack(
      children: [
        Positioned(
          top: 16.h,
          left: 8.w,
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () => Get.back(),
          ),
        ),
        Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                margin: EdgeInsets.only(top: 16.0.h, bottom: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: colorPrimary,
                ),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 19.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // title == 'العباءة'
            //     ? Column(children: [
            //         SizedBox(
            //           height: 50.h,
            //         ),
            //         Text('يمكنك مشاركة أو حفظ الكود الخاص بك',
            //             style:
            //                 MyStyles.getTextTheme(isLightTheme: true).titleLarge),
            //   SizedBox(
            //     height: 28.h,
            //   ),
            //         Stack(
            //           children: [
            //             Container(
            //               margin: const EdgeInsets.all(16.0),
            //               padding: const EdgeInsets.only(bottom: 120,top: 60,right: 50,left: 50),
            //               decoration: BoxDecoration(
            //                 gradient: LinearGradient(
            //                   colors: const [
            //                     colorPrimaryLighter,
            //                     colorPrimaryLight,
            //                   ],
            //                   begin: Alignment.bottomLeft,
            //                   end: Alignment.topRight,
            //                 ),
            //                 borderRadius: BorderRadius.circular(
            //                   20,
            //                 ),
            //                 boxShadow: const [
            //                   BoxShadow(
            //                     color: Colors.grey,
            //                     blurRadius: 10,
            //                     offset: Offset(0, 5),
            //                   ),
            //                 ],
            //               ),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: QrImageView(
            //                   data: code!,
            //                   version: QrVersions.auto,
            //                   size: Get.height * 0.3,
            //                   backgroundColor: Colors.white,

            //                 ),
            //               ),
            //             ),
            //             Positioned(
            //               bottom: 22,
            //               right: 25,
            //               child: CupertinoButton(
            //                   color: Colors.white30,
            //                   onPressed: () => _shareQrCode(code: code!),
            //                   padding: EdgeInsets.zero,
            //                   child: Icon(
            //                     Icons.share,
            //                     color: Colors.white70,
            //                   )),
            //             ),
            //             Positioned(
            //               bottom: 22,
            //               left: 25,
            //               child: CupertinoButton(
            //                   padding: EdgeInsets.zero,
            //                   color: Colors.white30,
            //                   onPressed: () => _downloadQrCode(code: code!),
            //                   child: Icon(
            //                     Icons.file_download,
            //                     color: Colors.white70,
            //                   )),
            //             )
            //           ],
            //         ),
            //       ]) :
            widget.title == 'أكوادي'
                ? widget.codes!.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/no-data.gif'),
                          ),
                          SizedBox(height: 32),
                          Text(
                            'لا يوجد لديك دعوات ',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: widget.codes!
                            .map((code) => TicketScreen(
                                  code: code,
                                ))
                            .toList(),
                      )
                : events.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/no-data.gif'),
                          ),
                          SizedBox(height: 32),
                          Text(
                            'لا يوجد لديك دعوات ',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: events
                            .map((event) => ExpandedTile(
                                  mainTitle: event.eventName!,
                                  CourseDate: event.date!.substring(0, 10),
                                  title: widget.title == "دعواتى"
                                      ? event.totalInvitationCount! -
                                                  event.totalInvitedCount! ==
                                              0
                                          ? 'ليس لديك دعوات متاحة'
                                          : ' لديك ${event.totalInvitationCount! - event.totalInvitedCount!} دعوات متاحة '
                                      : event.studentName,
                                  TwoItemsRow: [
                                    event.attendanceStatus == 1
                                        ? 'لم يتم الحضور'
                                        : 'حضور',
                                    widget.title != "دعواتى"
                                        ? ''
                                        : event.invitationStatus == 1
                                            ? 'لم تستخدم'
                                            : event.invitationStatus == 2
                                                ? 'تم تأكيد الدعوة'
                                                : 'استخدمت',
                                  ],
                                  trailing: IconButton(
                                    onPressed: () {
                                      onExpandedCardTapped(event: event);
                                    },
                                    icon: Icon(Icons.info_outline),
                                    color: colorPrimaryLighter,
                                  ),
                                ))
                            .toList(),
                      ),
          ],
        ),
      ],
    );
  }

  bool canAccept = false;
  void onExpandedCardTapped({required Event event}) async {
    String token = MySharedPref.getGraduatedServicesToken();

    var headers = 'Bearer $token';
    //Check if Accept Button show up or not
    APIController controller = APIController(
      url:
          'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/GetSettings?token=$headers',
    );
    try {
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        List data = controller.data['returnObject'];
        for (var map in data) {
          if (map['key'] == 'ShowAcceptInvitation') {
            canAccept = (map['value'] == "True");
          }
        }
        // canAccept = controller.data['returnObject'];
      }
    } catch (e) {
      canAccept = false;
    }
    showDetails(rows: [
      CustomRow(
        title: ' إسم الحدث : ',
        trailing: event.eventName!,
      ),
      CustomRow(
        title: ' الوقت : ',
        trailing: toDate(event.date!),
      ),
      CustomRow(
        title: ' حالة الحضور : ',
        trailing: event.attendanceStatus == 1 ? 'لم يحضر' : 'تم',
      ),
      CustomRow(
        title: ' حالة الدعوة : ',
        trailing: event.invitationStatus == 1
            ? 'لم تستخدم'
            : event.invitationStatus == 2
                ? 'تم تأكيد الدعوة'
                : 'استخدمت',
      ),
      widget.title == "دعواتى"
          ? CustomRow(
              title: ' الدعوات المتاحة : ',
              trailing:
                  '${event.totalInvitationCount! - event.totalInvitedCount!}',
            )
          : CustomRow(
              title: ' إسم المدعو : ',
              trailing: event.studentName!,
            ),
      if (widget.title == "دعواتى") ...[
        CustomRow(
          title: ' إجمالى الدعوات : ',
          trailing: '${event.totalInvitationCount!}',
        ),
        if (event.totalInvitationCount! - event.totalInvitedCount! > 0)
          CustomRow(
            title: 'إضـافـة دعـوة',
            iconColor: colorWhite,
            color: colorPrimary,
            icon: FontAwesomeIcons.personCirclePlus,
            onTap: () => showInviteDialog(event: event),
          ),
      ],
      if (event.invitationStatus == 1 && widget.title == "دعواتى" && canAccept)
        CustomRow(
          title: 'تأكيد الحضور',
          iconColor: colorWhite,
          color: colorPrimary,
          icon: FontAwesomeIcons.personCircleCheck,
          onTap: () => acceptInvitation(event: event),
        ),

      // SizedBox(height: 3.h),
      // TextButton.icon(
      //   label: Text('تسجيل الحضور'),
      //   style: TextButton.styleFrom(
      //     backgroundColor: colorPrimaryLighter,
      //     iconColor: Colors.white,
      //     foregroundColor: Colors.white,
      //     padding: EdgeInsets.all(8.0),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(25.0),
      //     ),
      //   ),
      //   icon: Icon(
      //     Icons.qr_code,
      //   ),
      //   onPressed: () => scanQRCode(),
      // ),
      CustomRow(
        title: 'تحميل الدعوة',
        iconColor: colorWhite,
        color: colorPrimary,
        icon: FontAwesomeIcons.download,
        onTap: () => downloadInvitation(event: event),
      ),
    ], title: event.eventName ?? '');
  }

  void showInviteDialog({required Event event}) {
    Get.back();
    Get.defaultDialog(
      title: event.eventName!,
      content: Column(
        children: [
          InputField(
            label: 'الإسم',
            hint: 'إسم الشخص المدعو',
            controller: nameController,
          ),
          InputField(
            label: 'رقم الهاتف',
            hint: 'ex: 05xxxxxxxx',
            controller: phoneController,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      confirm: CupertinoButton(
        color: colorPrimaryLighter,
        onPressed: () => addStdRelInvite(
            invitedPhoneNumber: phoneController.text,
            invitedName: nameController.text,
            eventId: event.eventId!),
        child: Text('إضافة دعوة جديدة'),
      ),
    );
  }

  void downloadInvitation({required Event event}) async {
    String token = MySharedPref.getGraduatedServicesToken();

    var headers = 'Bearer $token';
    Map body = {
      "invitationId": event.eventId,
      "name": event.studentName,
      "fontSize": event.fontSize,
      "fontColor": event.fontColor,
      "bgColor": event.bgColor,
      "templatePath": event.path,
      "axisX": event.axisX,
      "axisY": event.axisY,
      "barcodeAxisX": event.barcodeAxisX,
      "barcodeAxisY": event.barcodeAxisY,
      "token": headers,
    };

    await showLoadingOverlay(asyncFunction: () async {
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/DownloadInvitation',
        requestType: RequestType.post,
        body: body,
      );
      try {
        await controller.getData();
        if (controller.apiCallStatus == ApiCallStatus.success) {
          String data = controller.data['returnObject'];
          //Check if base64 starting with base64 pattern and replace it
          if (data.contains(base64Code)) {
            data = data.replaceRange(0, 22, '');
          }

          if (data.isNotEmpty) {
            Uint8List base64Data = base64Decode(
              data,
            );
            await ImageGallerySaver.saveImage(base64Data);
            Get.back();
            CustomSnackBar.showCustomSnackBar(
                title: 'نجاح', message: 'تم تحميل الدعوة في معرض الصور بنجاح');
          }
        }
      } catch (e) {
        CustomSnackBar.showCustomErrorToast(
            message: 'حدث خطأ في التحميل برجاء المحاولة في وقت لاحق');
      }
    });
  }

  void acceptInvitation({required Event event}) async {
    String token = MySharedPref.getGraduatedServicesToken();

    var headers = 'Bearer $token';

    await showLoadingOverlay(asyncFunction: () async {
      APIController controller = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/AcceptInvitation',
        requestType: RequestType.post,
        body: {"token": headers, "invitedId": event.id},
      );
      try {
        await controller.getData();
        if (controller.apiCallStatus == ApiCallStatus.success) {
          setState(() {
            event.invitationStatus = 2;
          });
          Get.back();
          CustomSnackBar.showCustomSnackBar(
              title: 'نجاح', message: 'تم تأكيد الدعوة بنجاح');
        }
      } catch (e) {
        CustomSnackBar.showCustomErrorToast(
            message: 'حدث خطأ في تأكيد الحضور برجاء المحاولة في وقت لاحق');
      }
    });
  }

  void addStdRelInvite({
    required String invitedPhoneNumber,
    required String invitedName,
    required int eventId,
  }) async {
    String token = MySharedPref.getGraduatedServicesToken();
    var headers = 'Bearer $token';
    var stdRelBody = {
      "invitedPhoneNumber": invitedPhoneNumber,
      "invitedName": invitedName,
      "eventId": eventId, // from api "abaya"
      "studentId": 0, //Keep it zero
      "token": headers,
    };

    //Add Invitations For Student Relatives
    APIController stdrelController = APIController(
      url:
          'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/AddStudentInvitationForInvited',
      requestType: RequestType.post,
      body: stdRelBody,
    );
    await stdrelController.getData();
    if (stdrelController.apiCallStatus == ApiCallStatus.success) {
      Get.back();
      CustomSnackBar.showCustomSnackBar(
          title: 'نجاح', message: 'تم إضافة الدعوة بنجاح');
      //Get Invitations For Student
      APIController stdController = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/GetInvitationsForStudent?token=$headers',
      );
      await stdController.getData();
      if (stdController.apiCallStatus == ApiCallStatus.success) {
        List returnedInvites = stdController.data['returnObject'];
        widget.invites?.clear();
        for (var invite in returnedInvites) {
          widget.invites?.add(Event.fromJson(invite));
        }
      }
      //Get Invitations For Student Relatives
      APIController stdrelController = APIController(
        url:
            'https://mobileapi.nbu.edu.sa/api/GradCardExternalApi/GetInvitedInvitationsForStudent?token=$headers',
      );
      await stdrelController.getData();
      if (stdrelController.apiCallStatus == ApiCallStatus.success) {
        List returnedInvites = stdrelController.data['returnObject'];
        widget.relInvites?.clear();
        for (var invite in returnedInvites) {
          widget.relInvites?.add(Event.fromJson(invite));
        }
      }
    }
    setState(() {});
  }
}

String toDate(String datetime) {
  //2023-08-05T19:00:00
  String date = datetime.substring(0, 10);
  String time = datetime.substring(11, 16);
  int parsedHour = int.parse(time.substring(0, 2));
  if (parsedHour > 12) {
    parsedHour -= 12;
    time = time.replaceRange(0, 2, '$parsedHour');
    return 'On / $date   $time PM';
  } else {
    return 'On / $date   $time AM';
  }
}
