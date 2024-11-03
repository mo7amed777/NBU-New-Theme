import 'dart:collection';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:eservices/app/data/models/chat/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';
import 'package:dio/dio.dart' as dio;

class Chatting extends StatefulWidget {
  Chatting({Key? key, required this.chat, required this.userID})
      : super(key: key);
  ChatModel chat;
  final int userID;

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  final TextEditingController _textController = TextEditingController();

  bool sendButton = false;

  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> messages = [];
  HubConnection? connection;
  void openConnection() async {
    connection = HubConnectionBuilder()
        .withUrl(
            'https://crm.nbu.edu.sa/chathub?ConnectionId=${widget.chat.connectionId}',
            HttpConnectionOptions(
              client: IOClient(
                  HttpClient()..badCertificateCallback = (x, y, z) => true),
              withCredentials: true,
            ))
        .build();

    await connection?.start();
    connection?.serverTimeoutInMilliseconds = 10000000;

    connection?.on('ReceiveMessage', (message) async {
      ChatMessage msg = ChatMessage.fromJson(message?.first);
      if (groupedByDate[msg.date] == null) {
        groupedByDate[msg.date!] = [];
      }
      groupedByDate[msg.date]!.add(msg);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });

      setState(() {});
    });
  }

  LinkedHashMap<String, List<ChatMessage>> groupedByDate = LinkedHashMap();

  bool show = false;
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    if (connection?.state != HubConnectionState.connected) {
      openConnection();
    }
    messages = widget.chat.chatMessages ?? [];
    sortAndGroupMessages();
  }

  void sortAndGroupMessages() {
    if (messages.isNotEmpty) {
      for (var message in messages) {
        String date = message.date ?? '';
        if (groupedByDate.containsKey(date)) {
          groupedByDate[date]!.add(message);
        } else {
          groupedByDate[date] = [
            message
          ]; // Initialize the list with the current message
        }
      }

      // Sort messages within each date group by time
      groupedByDate.forEach((date, messageList) {
        messageList.sort((a, b) {
          return a.time!.compareTo(b.time!); // Sort by time
        });
      });

      // Create a list of dates and sort it
      var sortedDates = groupedByDate.keys.toList()
        ..sort((a, b) {
          DateTime dateA = DateTime.parse(
              '${a.split('-')[2]}-${a.split('-')[1]}-${a.split('-')[0]}');
          DateTime dateB = DateTime.parse(
              '${b.split('-')[2]}-${b.split('-')[1]}-${b.split('-')[0]}');
          return dateA.compareTo(dateB);
        });

      // Rebuild groupedByDate in sorted order
      LinkedHashMap<String, List<ChatMessage>> sortedGroupedByDate =
          LinkedHashMap();
      for (var date in sortedDates) {
        sortedGroupedByDate[date] = groupedByDate[date]!;
      }

      groupedByDate = sortedGroupedByDate;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() async {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      APIController controller = APIController(
        url:
            'https://crm.nbu.edu.sa/api/Chat/SetViewMessageAndGetChatsMessageCount?Id=${widget.chat.id}',
      );
      await controller.getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          groupedByDate.isEmpty
              ? Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: const AssetImage('assets/images/chat_back.png'),
                    fit: BoxFit.fill,
                  )),
                )
              : Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: const AssetImage('assets/images/chat_back.png'),
                    fit: BoxFit.fill,
                  )),
                  height: Get.height,
                  padding: EdgeInsets.only(
                      top: Get.height * 0.15,
                      left: 8.w,
                      right: 8.w,
                      bottom: Get.height * 0.1),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: groupedByDate.values.map((chatMessage) {
                        String date = groupedByDate.keys.firstWhere(
                            (key) => groupedByDate[key] == chatMessage);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: chatMessage
                              .map(
                                (chatMessage) => Align(
                                  alignment: chatMessage.userId == widget.userID
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Card(
                                      color: chatMessage.userId == widget.userID
                                          ? Color(0xffD9FDD3)
                                          : Colors.white,
                                      margin: EdgeInsets.all(
                                        4.sp,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              chatMessage.userId ==
                                                      widget.userID
                                                  ? 16
                                                  : 0),
                                          topRight: Radius.circular(
                                              chatMessage.userId ==
                                                      widget.userID
                                                  ? 0
                                                  : 16),
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (chatMessage.isFile ?? false)
                                              InkWell(
                                                onTap: () => Get.dialog(
                                                  Center(
                                                    child: Image.network(
                                                      chatMessage.path!,
                                                      headers: {
                                                        'Authorization':
                                                            'Bearer ${MySharedPref.getSupportMeToken()}',
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                child: Image.network(
                                                  chatMessage.path!,
                                                  fit: BoxFit.fill,
                                                  width: Get.width * 0.75,
                                                  headers: {
                                                    'Authorization':
                                                        'Bearer ${MySharedPref.getSupportMeToken()}',
                                                  },
                                                ),
                                              ),
                                            SizedBox(height: 5.sp),
                                            if (chatMessage.message != null)
                                              Text(
                                                chatMessage.message ?? '',
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            SizedBox(height: 5.sp),
                                            SizedBox(
                                              width: 60.w,
                                              child: Row(
                                                children: [
                                                  chatMessage.userId ==
                                                          widget.userID
                                                      ? Icon(
                                                          FontAwesomeIcons
                                                              .checkDouble,
                                                          size: 12.sp,
                                                          color: chatMessage
                                                                      .isView ??
                                                                  false
                                                              ? Color(
                                                                  0xff62C4E8)
                                                              : Colors.black54,
                                                        )
                                                      : Container(),
                                                  SizedBox(width: 5.sp),
                                                  if (chatMessage.time != null)
                                                    Text(
                                                      chatMessage.time!
                                                          .substring(0, 5),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              )
                              .toList()
                            ..insert(
                                0,
                                Align(
                                  child: date == ""
                                      ? Container()
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 60.sp),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Divider(
                                                  thickness: 1.0,
                                                  color: Colors.black38,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  date,
                                                  style: TextStyle(
                                                    color: colorPrimary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Divider(
                                                  thickness: 1.0,
                                                  color: Colors.black38,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                )),
                        );
                      }).toList(),
                    ),
                  ),
                ),
          Positioned(
            top: Get.height * 0.07,
            left: 4.w,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            top: Get.height * 0.067,
            left: 40.w,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/male.png',
              ),
              radius: 25.sp,
            ),
          ),
          Positioned(
            top: Get.height * 0.07,
            right: 8.w,
            child: Center(
              child: Container(
                width: Get.width * 0.7,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorPrimary,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 4.0, top: 2.0, bottom: 2.0),
                    child: Text(
                      widget.chat.title ?? widget.chat.fromUserNameAr ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8.h,
            left: 8.w,
            right: 8.w,
            child: buildMessageTextInput(),
          ),
        ],
      ),
    );
  }

  File? image;

  FocusNode focusNode = FocusNode();
  Widget buildMessageTextInput() {
    return Row(
      children: [
        SizedBox(
          width: sendButton ? Get.width - 65.w : Get.width - 20.w,
          child: Card(
            margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
            color: colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextFormField(
              controller: _textController,
              focusNode: focusNode,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    sendButton = true;
                  });
                } else {
                  setState(() {
                    sendButton = false;
                  });
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "ارسال رسالة",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: IconButton(
                  icon: Icon(
                    show ? Icons.keyboard : Icons.emoji_emotions_outlined,
                  ),
                  onPressed: () {
                    if (!show) {
                      focusNode.unfocus();
                      focusNode.canRequestFocus = false;
                    }
                    setState(() {
                      show = !show;
                    });
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);

                    if (pickedFile != null) {
                      image = File(pickedFile.path);
                      setState(() {
                        sendButton = true;
                      });
                    }
                  },
                ),
                contentPadding: EdgeInsets.all(5),
              ),
            ),
          ),
        ),
        if (sendButton)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
              right: 2,
              left: 2,
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFF128C7E),
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (sendButton) {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                    sendMessage(
                        message: _textController.text,
                        chatId: widget.chat.id!,
                        connectionId: widget.chat.connectionId!);
                    _textController.clear();
                    setState(() {
                      sendButton = false;
                    });
                  }
                },
              ),
            ),
          ),
      ],
    );
  }

  void sendMessage(
      {required String message,
      required int chatId,
      required String connectionId}) async {
    //Remove keyboard focus

    //check if message is not empty then send to API & setState if success
    final messageText = message.trim();
    if (messageText.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });

      dio.MultipartFile? attatchment;
      if (image != null) {
        attatchment = dio.MultipartFile.fromFileSync(image!.path);
      }
      var data = {
        "ChatId": chatId,
        "Message": messageText,
        "ConnectionId": connectionId,
        "Attachment": attatchment,
      };
      dio.FormData formData = dio.FormData.fromMap(data);

      APIController controller = APIController(
        url: 'https://crm.nbu.edu.sa/api/Chat/AddMessage',
        requestType: RequestType.post,
        body: formData,
      );

      await controller.getData();

      if (controller.apiCallStatus == ApiCallStatus.success) {
        setState(() {
          if (attatchment != null) {
            attatchment = null;
            image = null;
          }
          //   messages.removeLast();
          //   messages.add(ChatMessage(
          //       message: message,
          //       userId: widget.userID,
          //       isView: true,
          //       date:
          //           "${DateTime.now().day}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}",
          //       time: DateTime.now().toIso8601String().substring(11, 16)));
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    focusNode.dispose();
    connection?.stop();
    super.dispose();
  }
}


// controller = APIController(
        //   url: 'https://crm.nbu.edu.sa/api/Chat/GetChat?Id=$chatId',
        // );
        // await controller.getData();
        // if (controller.apiCallStatus == ApiCallStatus.success) {
        //   ChatModel chat = ChatModel.fromJson(controller.data['returnObject']);
        //   setState(() {
        //     widget.chat = chat;
        //   });
        // }