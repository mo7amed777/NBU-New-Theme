class Chat {
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

  Chat(
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
      this.date});

  Chat.fromJson(Map<String, dynamic> json) {
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
  }
}
