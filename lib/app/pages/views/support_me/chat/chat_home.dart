import 'dart:io';

import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/data/models/chat/chats.dart';
import 'package:eservices/app/data/models/chat/chat_model.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/support_me/chat/chat_screen.dart';
import 'package:eservices/app/pages/views/support_me/new_requests.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';

class Chats extends StatefulWidget {
  Chats(
      {Key? key,
      required this.data,
      required this.userID,
      required this.showFromUser})
      : super(key: key);
  List data;
  final int userID;
  final bool showFromUser;

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  HubConnection? connection;
  int countNum = 0;
  void openConnection() async {
    String connectionId = widget.showFromUser
        ? "${widget.data[0]['workBesideId']}_admin"
        : widget.userID.toString();
    connection = HubConnectionBuilder()
        .withUrl(
            'https://crm.nbu.edu.sa/chathub?ConnectionId=$connectionId',
            HttpConnectionOptions(
              client: IOClient(
                  HttpClient()..badCertificateCallback = (x, y, z) => true),
              withCredentials: true,
            ))
        .build();

    await connection?.start();
    connection?.serverTimeoutInMilliseconds = 1000000;

    connection?.on('ReceiveMessage', (message) async {
      if (message != null) {
        if (message[0]['isAddchat'] == true) {
          getChats();
        }
        outerLoop:
        for (var user in widget.data) {
          if (user['connectionId'] == message[0]['connectionId']) {
            for (var item in chatCount) {
              if (item['id'] == user['id']) {
                getCount();

                break outerLoop;
              }
            }
          }
        }
        sortChats();
        setState(() {});
      }
    });
  }

  List chatCount = [];

  @override
  void initState() {
    super.initState();
    sortChats();

    if (connection?.state != HubConnectionState.connected) {
      openConnection();
    }

    getCount();
  }

  void getCount() async {
    APIController controller = APIController(
      url: 'https://crm.nbu.edu.sa/api/Chat/GetChatsMessageCount',
    );
    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success) {
      setState(() {
        chatCount = controller.data['returnObject'] ?? [];
      });
    }
  }

  void sortChats() {
    widget.data.sort((a, b) {
      return b['date'].compareTo(a['date']);
    });
    widget.data.sort((a, b) {
      String aDate = a['modificationDate'] ?? a['date'];
      String bDate = b['modificationDate'] ?? b['date'];
      return bDate.compareTo(aDate);
    });
  }

  void getChats() async {
    await showLoadingOverlay(asyncFunction: () async {
      APIController controller = APIController(
        url: 'https://crm.nbu.edu.sa/api/Chat/GetChats',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        widget.data = controller.data['returnObject'] ?? [];
        sortChats();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    connection?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => newChat(),
        backgroundColor: colorPrimary,
        foregroundColor: Colors.white,
        tooltip: 'محادثة جديدة',
        elevation: 5,
        splashColor: Colors.white,
        shape: CircleBorder(),
        highlightElevation: 0,
        child: Icon(Icons.add_comment),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: Get.height * 0.17, left: 20.w, right: 20.w),
                child: widget.data.isEmpty
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
                            'لا يوجد محادثات',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: widget.data.map(((chatModel) {
                        Chat chat = Chat.fromJson(chatModel);
                        countNum = getCounts(chatCount: chatCount, chat: chat);
                        return Card(
                          elevation: 5,
                          color: countNum != 0 ? colorPrimary : colorWhite,
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: countNum != 0
                              ? badges.Badge(
                                  badgeStyle: badges.BadgeStyle(
                                    padding: EdgeInsets.all(8.sp),
                                  ),
                                  position: badges.BadgePosition.topEnd(
                                      top: -10, end: 0),
                                  badgeAnimation: badges.BadgeAnimation.scale(
                                    loopAnimation: true,
                                  ),
                                  badgeContent: Text(
                                    countNum.toString(),
                                    style: TextStyle(color: colorWhite),
                                  ),
                                  showBadge: countNum != 0,
                                  child: ListTile(
                                    title: Text(
                                      (widget.showFromUser
                                              ? chat.fromUserNameAr
                                              : chat.workBesideNameAr) ??
                                          '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: colorPrimary, fontSize: 13.sp),
                                    ),
                                    onTap: () {
                                      openChat(id: chat.id.toString());
                                      setState(() {
                                        var count = chatCount.firstWhere(
                                            (element) =>
                                                element['id'] == chat.id);

                                        count['chatMessageCount'] = 0;
                                        count['modificationDate'] =
                                            DateTime.now().toString();
                                      });
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                        'assets/images/male.png',
                                      ),
                                      radius: 20,
                                    ),
                                    subtitle: Text(
                                      chat.requestTypeNameAr ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: colorPrimary, fontSize: 12.sp),
                                    ),
                                  ),
                                )
                              : ListTile(
                                  title: Text(
                                    (widget.showFromUser
                                            ? chat.fromUserNameAr
                                            : chat.workBesideNameAr) ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: colorPrimary, fontSize: 13.sp),
                                  ),
                                  onTap: () {
                                    openChat(id: chat.id.toString());
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/male.png',
                                    ),
                                    radius: 20,
                                  ),
                                  subtitle: Text(
                                    chat.requestTypeNameAr ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: colorPrimary, fontSize: 12.sp),
                                  ),
                                ),
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
                  'طلبات المحادثة',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int getCounts({required Chat chat, required List chatCount}) {
    if (chatCount.isNotEmpty) {
      for (var count in chatCount) {
        if (count['chatMessageCount'] > 0) {
          if (chat.id == count['id']) {
            return count['chatMessageCount'];
          }
        }
      }
    }

    return 0;
  }

  void openChat({required String id}) async {
    APIController controller = APIController(
      url:
          'https://crm.nbu.edu.sa/api/Chat/SetViewMessageAndGetChatsMessageCount?Id=$id',
    );
    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success) {
      controller = APIController(
        url: 'https://crm.nbu.edu.sa/api/Chat/GetChat?Id=$id',
      );
      await controller.getData();
      if (controller.apiCallStatus == ApiCallStatus.success) {
        ChatModel chat = ChatModel.fromJson(controller.data['returnObject']);
        if (connection?.state == HubConnectionState.connected) {
          await connection?.stop();
        }
        Get.to(() => Chatting(chat: chat, userID: widget.userID));
      }
    }
  }

  void newChat() async {
    APIController controller = APIController(
      url: 'https://crm.nbu.edu.sa/api/LKPRequestType/GetRequestTypes',
    );
    await controller.getData();
    List requestTypes = controller.data['returnObject'] ?? [];

    String? selectedType;

    controller = APIController(
      url: 'https://crm.nbu.edu.sa/api/WorkBeside/GetWorkBesidesSelectedList',
    );
    await controller.getData();
    List departments = controller.data['returnObject'] ?? [];
    Map<int, bool> reqSelected = {};
    Map<int, bool> deptSelected = {};

    String? selectedDepartment;
    Get.defaultDialog(
      title: 'محادثة جديدة',
      content: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colorPrimary,
            ),
            child: Text(
              'الجهة',
              style: mediumTitleStyle.copyWith(color: colorWhite),
            ),
          ),
          SizedBox(height: 5.h),
          StatefulBuilder(
            builder: (context, setState) => Wrap(
              children: departments
                  .map((dept) => InkWell(
                        onTap: () {
                          setState(() {
                            if (deptSelected.containsKey(dept['id']) &&
                                deptSelected[dept['id']] == true) {
                              deptSelected[dept['id']] = false;
                            } else if (deptSelected.containsKey(dept['id']) &&
                                deptSelected[dept['id']] == false) {
                              deptSelected[dept['id']] = true;
                            } else {
                              deptSelected = {};
                              deptSelected.addAll({
                                dept['id']: true,
                              });
                            }
                            selectedDepartment = dept['id'].toString();
                          });
                        },
                        splashColor: colorPrimary,
                        child: Card(
                          elevation: 5,
                          color: deptSelected.containsKey(dept['id']) &&
                                  deptSelected[dept['id']] == true
                              ? colorPrimary
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(dept['workBesideNameAr']),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(height: 35.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colorPrimary,
            ),
            child: Text(
              'النوع',
              style: mediumTitleStyle.copyWith(color: colorWhite),
            ),
          ),
          SizedBox(height: 5.h),
          StatefulBuilder(
            builder: (context, setState) => Wrap(
              children: requestTypes
                  .map((req) => InkWell(
                        onTap: () {
                          setState(() {
                            if (reqSelected.containsKey(req['id']) &&
                                reqSelected[req['id']] == true) {
                              reqSelected[req['id']] = false;
                            } else if (reqSelected.containsKey(req['id']) &&
                                reqSelected[req['id']] == false) {
                              reqSelected[req['id']] = true;
                            } else {
                              reqSelected = {};
                              reqSelected.addAll({
                                req['id']: true,
                              });
                            }
                            selectedType = req['id'].toString();
                          });
                        },
                        splashColor: colorPrimary,
                        child: Card(
                          elevation: 5,
                          color: reqSelected.containsKey(req['id']) &&
                                  reqSelected[req['id']] == true
                              ? colorPrimary
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(req['nameAr']),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
      confirm: CustomButton(
        padding: 8,
        fontSize: 16,
        callBack: () async {
          if (selectedDepartment != null && selectedType != null) {
            Get.back();
            APIController controller = APIController(
                url: 'https://crm.nbu.edu.sa/api/Chat/AddChat',
                requestType: RequestType.post,
                body: {
                  "requestTypeId": requestTypeID,
                  "workBesideId": selectedDepartment,
                });
            await controller.getData();
            if (controller.apiCallStatus == ApiCallStatus.success) {
              openChat(id: controller.data['returnObject'].toString());
              getChats();
              sortChats();
              setState(() {});
              // setState(() {
              //   var count = chatCount.firstWhere((element) =>
              //       element['id'] == controller.data['returnObject']);

              //   count['chatMessageCount'] = 0;
              // });
            }
          } else {
            CustomSnackBar.showCustomErrorToast(
                message: 'اختر الجهة ونوع الطلب');
          }
        },
        label: 'بدء المحادثة',
      ),
      // cancel: CustomButton(
      //   padding: 8,
      //   fontSize: 16,
      //   callBack: () {
      //     Get.back();
      //   },
      //   label: 'الغاء',
      // ),
    );
  }
}
