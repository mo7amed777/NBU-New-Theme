class AcadmicScheduleModel {
  String? ssn;
  String? studenTNAME;
  String? term;
  String? crn;
  String? coursENO;
  String? scbcrsETITLE;
  String? hours;
  String? sirasgNPERCENTRESPONSE;
  String? calculated;
  String? typeofclass;
  String? days;
  String? time;
  String? colLDESC;
  String? room;

  AcadmicScheduleModel(
      {this.ssn,
        this.studenTNAME,
        this.term,
        this.crn,
        this.coursENO,
        this.scbcrsETITLE,
        this.hours,
        this.sirasgNPERCENTRESPONSE,
        this.calculated,
        this.typeofclass,
        this.days,
        this.time,
        this.colLDESC,
        this.room});

  AcadmicScheduleModel.fromJson(Map<String, dynamic> json) {
    ssn = json['ssn'];
    studenTNAME = json['studenT_NAME'];
    term = json['term'];
    crn = json['crn'];
    coursENO = json['coursE_NO'];
    scbcrsETITLE = json['scbcrsE_TITLE'];
    hours = json['hours'].toString();
    sirasgNPERCENTRESPONSE = json['sirasgN_PERCENT_RESPONSE'].toString();
    calculated = json['calculated'].toString();
    typeofclass = json['typeofclass'];
    days = json['days'];
    time = json['time'];
    colLDESC = json['colL_DESC'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ssn'] = this.ssn;
    data['studenT_NAME'] = this.studenTNAME;
    data['term'] = this.term;
    data['crn'] = this.crn;
    data['coursE_NO'] = this.coursENO;
    data['scbcrsE_TITLE'] = this.scbcrsETITLE;
    data['hours'] = this.hours;
    data['sirasgN_PERCENT_RESPONSE'] = this.sirasgNPERCENTRESPONSE;
    data['calculated'] = this.calculated;
    data['typeofclass'] = this.typeofclass;
    data['days'] = this.days;
    data['time'] = this.time;
    data['colL_DESC'] = this.colLDESC;
    data['room'] = this.room;
    return data;
  }
}
