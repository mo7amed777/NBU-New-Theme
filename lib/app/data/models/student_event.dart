class Event {
  int? id;
  String? eventName;
  int? eventId;
  String? studentName;
  String? creationDate;
  String? date;
  int? invitationStatus;
  int? attendanceStatus;
  int? invitationPersonType;
  int? totalInvitationCount;
  String? path;
  int? fontSize;
  String? fontColor;
  int? axisX;
  int? axisY;
  String? bgColor;
  int? barcodeAxisX;
  int? barcodeAxisY;
  int? totalInvitedCount;

  Event(
      {this.id,
      this.eventName,
      this.eventId,
      this.studentName,
      this.creationDate,
      this.date,
      this.invitationStatus,
      this.attendanceStatus,
      this.invitationPersonType,
      this.totalInvitationCount,
      this.path,
      this.fontSize,
      this.fontColor,
      this.axisX,
      this.axisY,
      this.bgColor,
      this.barcodeAxisX,
      this.barcodeAxisY,
      this.totalInvitedCount});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['eventName'];
    eventId = json['eventId'];
    studentName = json['studentName'];
    creationDate = json['creationDate'];
    date = json['date'];
    invitationStatus = json['invitationStatus'];
    attendanceStatus = json['attendanceStatus'];
    invitationPersonType = json['invitationPersonType'];
    totalInvitationCount = json['totalInvitationCount'];
    path = json['path'];
    fontSize = json['fontSize'];
    fontColor = json['fontColor'];
    axisX = json['axisX'];
    axisY = json['axisY'];
    bgColor = json['bgColor'];
    barcodeAxisX = json['barcodeAxisX'];
    barcodeAxisY = json['barcodeAxisY'];
    totalInvitedCount = json['totalInvitedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eventName'] = eventName;
    data['eventId'] = eventId;
    data['studentName'] = studentName;
    data['creationDate'] = creationDate;
    data['date'] = date;
    data['invitationStatus'] = invitationStatus;
    data['attendanceStatus'] = attendanceStatus;
    data['invitationPersonType'] = invitationPersonType;
    data['totalInvitationCount'] = totalInvitationCount;
    data['path'] = path;
    data['fontSize'] = fontSize;
    data['fontColor'] = fontColor;
    data['axisX'] = axisX;
    data['axisY'] = axisY;
    data['bgColor'] = bgColor;
    data['barcodeAxisX'] = barcodeAxisX;
    data['barcodeAxisY'] = barcodeAxisY;
    data['totalInvitedCount'] = totalInvitedCount;
    return data;
  }
}
