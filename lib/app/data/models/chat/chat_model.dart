class ChatModel {
  int? id;
  String? title;
  String? connectionId;
  int? fromUserId;
  String? fromUserNameAr;
  String? fromUserNameEn;
  int? toUserId;
  String? toUserNameAr;
  String? toUserNameEn;
  int? workBesideId;
  String? workBesideNameAr;
  String? workBesideNameEn;
  String? requestTypeNameAr;
  String? requestTypeNameEn;
  String? date;
  List<ChatMessage>? chatMessages;

  ChatModel(
      {this.id,
      this.title,
      this.connectionId,
      this.fromUserId,
      this.fromUserNameAr,
      this.fromUserNameEn,
      this.toUserId,
      this.toUserNameAr,
      this.toUserNameEn,
      this.workBesideId,
      this.workBesideNameAr,
      this.workBesideNameEn,
      this.requestTypeNameAr,
      this.requestTypeNameEn,
      this.date,
      this.chatMessages});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    connectionId = json['connectionId'];
    fromUserId = json['fromUserId'];
    fromUserNameAr = json['fromUserNameAr'];
    fromUserNameEn = json['fromUserNameEn'];
    toUserId = json['toUserId'];
    toUserNameAr = json['toUserNameAr'];
    toUserNameEn = json['toUserNameEn'];
    workBesideId = json['workBesideId'];
    workBesideNameAr = json['workBesideNameAr'];
    workBesideNameEn = json['workBesideNameEn'];
    requestTypeNameAr = json['requestTypeNameAr'];
    requestTypeNameEn = json['requestTypeNameEn'];
    date = json['date'];
    if (json['chatMessages'] != null) {
      chatMessages = <ChatMessage>[];
      json['chatMessages'].forEach((v) {
        chatMessages!.add(ChatMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['connectionId'] = connectionId;
    data['fromUserId'] = fromUserId;
    data['fromUserNameAr'] = fromUserNameAr;
    data['fromUserNameEn'] = fromUserNameEn;
    data['toUserId'] = toUserId;
    data['toUserNameAr'] = toUserNameAr;
    data['toUserNameEn'] = toUserNameEn;
    data['workBesideId'] = workBesideId;
    data['workBesideNameAr'] = workBesideNameAr;
    data['workBesideNameEn'] = workBesideNameEn;
    data['requestTypeNameAr'] = requestTypeNameAr;
    data['requestTypeNameEn'] = requestTypeNameEn;
    data['date'] = date;
    if (chatMessages != null) {
      data['chatMessages'] = chatMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatMessage {
  int? id;
  String? message;
  int? userId;
  String? userNameAr;
  String? userNameEn;
  String? date;
  String? time;
  int? chatId;
  int? userWorkBesideId;
  String? attachmentId;
  String? extention;
  int? attachmentTypeId;
  String? path;
  bool? isFile;
  bool? isView;

  ChatMessage({
    this.id,
    this.message,
    this.userId,
    this.userNameAr,
    this.userNameEn,
    this.date,
    this.time,
    this.chatId,
    this.userWorkBesideId,
    this.attachmentId,
    this.extention,
    this.attachmentTypeId,
    this.path,
    this.isFile,
    this.isView,
  });

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    userId = json['userId'];
    userNameAr = json['userNameAr'];
    userNameEn = json['userNameEn'];
    date = json['date'] ?? json['creationDate'];
    time = json['time'] ?? json['creationTime'];
    chatId = json['chatId'];
    userWorkBesideId = json['userWorkBesideId'];
    attachmentId = json['attachmentId'];
    extention = json['extention'];
    attachmentTypeId = json['attachmentTypeId'];
    path = json['path'];
    isFile = json['isFile'];
    isView = json['isView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['userId'] = userId;
    data['userNameAr'] = userNameAr;
    data['userNameEn'] = userNameEn;
    data['date'] = date;
    data['time'] = time;
    data['chatId'] = chatId;
    data['userWorkBesideId'] = userWorkBesideId;
    data['attachmentId'] = attachmentId;
    data['extention'] = extention;
    data['attachmentTypeId'] = attachmentTypeId;
    data['path'] = path;
    data['isFile'] = isFile;
    data['isView'] = isView;
    return data;
  }
}
