class ScheduleModel {
  String? courseNo;
  String? crm;
  String? division;
  String? courseName;
  int? unit;
  String? activite;
  String? days;
  String? time;
  String? build;
  String? room;

  ScheduleModel(
      {this.courseNo,
        this.crm,
        this.division,
        this.courseName,
        this.unit,
        this.activite,
        this.days,
        this.time,
        this.build,
        this.room});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    courseNo = json['courseNo'];
    crm = json['crm'];
    division = json['division'];
    courseName = json['courseName'];
    unit = json['unit'];
    activite = json['activite'];
    days = json['days'];
    time = json['time'];
    build = json['build'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseNo'] = courseNo;
    data['crm'] = crm;
    data['division'] = division;
    data['courseName'] = courseName;
    data['unit'] = unit;
    data['activite'] = activite;
    data['days'] = days;
    data['time'] = time;
    data['build'] = build;
    data['room'] = room;
    return data;
  }
}
