class MahderModel {
  List<MeetingDedails>? meetingDedails;
  List<MainMeetingSubject>? mainMeetingSubject;
  List<ComesNewOfBusinessesMeetingSubject>? comesNewOfBusinessesMeetingSubject;
  List<Users>? users;

  MahderModel(
      {this.meetingDedails,
        this.mainMeetingSubject,
        this.comesNewOfBusinessesMeetingSubject,
        this.users});

  MahderModel.fromJson(Map<String, dynamic> json) {
    if (json['meetingDedails'] != null) {
      meetingDedails = <MeetingDedails>[];
      json['meetingDedails'].forEach((v) {
        meetingDedails!.add(MeetingDedails.fromJson(v));
      });
    }
    if (json['mainMeetingSubject'] != null) {
      mainMeetingSubject = <MainMeetingSubject>[];
      json['mainMeetingSubject'].forEach((v) {
        mainMeetingSubject!.add(MainMeetingSubject.fromJson(v));
      });
    }
    if (json['comesNewOfBusinessesMeetingSubject'] != null) {
      comesNewOfBusinessesMeetingSubject =
      <ComesNewOfBusinessesMeetingSubject>[];
      json['comesNewOfBusinessesMeetingSubject'].forEach((v) {
        comesNewOfBusinessesMeetingSubject!
            .add(ComesNewOfBusinessesMeetingSubject.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }
void setUsers (List<Users> newUsers)=> users=newUsers;
}

class MeetingDedails {
  int? id;
  String? titleAr;
  String? intro;
  String? place;
  String? date;
  String? hgDate;
  String? startTime;
  String? endTime;
  String? startHeader;

  MeetingDedails(
      {this.id,
        this.titleAr,
        this.intro,
        this.place,
        this.date,
        this.hgDate,
        this.startTime,
        this.endTime,
        this.startHeader});

  MeetingDedails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['titleAr'];
    intro = json['intro'];
    place = json['place'];
    date = json['date'];
    hgDate = json['hgDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startHeader = json['startHeader'];
  }

}

class MainMeetingSubject {
  String? titleAr;
  int? order;
  String? orderName;
  int? id;
  int? subjectId;
  String? details;
  String? decision;
  int? councilDecisionTypeId;
  int? subjectClassId;
  String? decisionTypeNameAr;
  String? decisionTypeNameEn;

  MainMeetingSubject(
      {this.titleAr,
        this.order,
        this.orderName,
        this.id,
        this.subjectId,
        this.details,
        this.decision,
        this.councilDecisionTypeId,
        this.subjectClassId,
        this.decisionTypeNameAr,
        this.decisionTypeNameEn});

  MainMeetingSubject.fromJson(Map<String, dynamic> json) {
    titleAr = json['titleAr'];
    order = json['order'];
    orderName = json['orderName'];
    id = json['id'];
    subjectId = json['subjectId'];
    details = json['details'];
    decision = json['decision'];
    councilDecisionTypeId = json['councilDecisionTypeId'];
    subjectClassId = json['subjectClassId'];
    decisionTypeNameAr = json['decisionTypeNameAr'];
    decisionTypeNameEn = json['decisionTypeNameEn'];
  }

}

class ComesNewOfBusinessesMeetingSubject {
  String? titleAr;
  int? order;
  String? orderName;
  int? id;
  int? subjectId;
  String? details;
  String? decision;
  int? councilDecisionTypeId;
  int? subjectClassId;
  String? decisionTypeNameAr;
  String? decisionTypeNameEn;

  ComesNewOfBusinessesMeetingSubject(
      {this.titleAr,
        this.order,
        this.orderName,
        this.id,
        this.subjectId,
        this.details,
        this.decision,
        this.councilDecisionTypeId,
        this.subjectClassId,
        this.decisionTypeNameAr,
        this.decisionTypeNameEn});

  ComesNewOfBusinessesMeetingSubject.fromJson(Map<String, dynamic> json) {
    titleAr = json['titleAr'];
    order = json['order'];
    orderName = json['orderName'];
    id = json['id'];
    subjectId = json['subjectId'];
    details = json['details'];
    decision = json['decision'];
    councilDecisionTypeId = json['councilDecisionTypeId'];
    subjectClassId = json['subjectClassId'];
    decisionTypeNameAr = json['decisionTypeNameAr'];
    decisionTypeNameEn = json['decisionTypeNameEn'];
  }

}

class Users {
  String? userNID;
  String? userNameAr;
  String? userNameEn;
  int? order;
  int? privilegeId;
  String? privilegeNameAr;
  String? privilegeNameEn;
  String? jobTitle;
  bool? isSigned;
  String? signDate;
  String? signNote;
  String? sign;
  String? attendanceStatusNameAr;
  String? attendanceStatusNameEn;
  int? attendanceStatusId;

  Users(
      {this.userNID,
        this.userNameAr,
        this.userNameEn,
        this.order,
        this.privilegeId,
        this.privilegeNameAr,
        this.privilegeNameEn,
        this.jobTitle,
        this.isSigned,
        this.signDate,
        this.signNote,
        this.sign,
        this.attendanceStatusNameAr,
        this.attendanceStatusNameEn,
        this.attendanceStatusId});

  Users.fromJson(Map<String, dynamic> json) {
    userNID = json['userNID'];
    userNameAr = json['userNameAr'];
    userNameEn = json['userNameEn'];
    order = json['order'];
    privilegeId = json['privilegeId'];
    privilegeNameAr = json['privilegeNameAr'];
    privilegeNameEn = json['privilegeNameEn'];
    jobTitle = json['jobTitle'];
    isSigned = json['isSigned'];
    signDate = json['signDate'];
    signNote = json['signNote'];
    sign = json['sign'];
    attendanceStatusNameAr = json['attendanceStatusNameAr'];
    attendanceStatusNameEn = json['attendanceStatusNameEn'];
    attendanceStatusId = json['attendanceStatusId'];
  }
}
