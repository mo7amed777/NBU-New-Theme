class Student {
  String? id;
  String? nid;
  String? firstNameAr;
  String? midNameAr;
  String? lastNameAr;
  String? firstNameEn;
  String? midNameEn;
  String? lastNameEn;
  String? gender;
  String? degreeName;
  String? collegeName;
  String? departmentName;
  String? collegeCode;
  String? departmentCode;
  String? programName;
  String? status;
  double? gpa;
  String? gade;
  String? campName;

  Student(
      {this.id,
        this.nid,
        this.firstNameAr,
        this.midNameAr,
        this.lastNameAr,
        this.firstNameEn,
        this.midNameEn,
        this.lastNameEn,
        this.gender,
        this.degreeName,
        this.collegeName,
        this.departmentName,
        this.collegeCode,
        this.departmentCode,
        this.programName,
        this.status,
        this.gpa,
        this.gade,
        this.campName});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nid = json['nid'];
    firstNameAr = json['firstNameAr'];
    midNameAr = json['midNameAr'];
    lastNameAr = json['lastNameAr'];
    firstNameEn = json['firstNameEn'];
    midNameEn = json['midNameEn'];
    lastNameEn = json['lastNameEn'];
    gender = json['gender'];
    degreeName = json['degreeName'];
    collegeName = json['collegeName'];
    departmentName = json['departmentName'];
    collegeCode = json['collegeCode'];
    departmentCode = json['departmentCode'] ?? "0";
    programName = json['programName'];
    status = json['status'];
    gpa = json['gpa'];
    gade = json['gade'];
    campName = json['campName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nid'] = nid;
    data['firstNameAr'] = firstNameAr;
    data['midNameAr'] = midNameAr;
    data['lastNameAr'] = lastNameAr;
    data['firstNameEn'] = firstNameEn;
    data['midNameEn'] = midNameEn;
    data['lastNameEn'] = lastNameEn;
    data['gender'] = gender;
    data['degreeName'] = degreeName;
    data['collegeName'] = collegeName;
    data['departmentName'] = departmentName;
    data['collegeCode'] = collegeCode;
    data['departmentCode'] = departmentCode ?? "0";
    data['programName'] = programName;
    data['status'] = status;
    data['gpa'] = gpa;
    data['gade'] = gade;
    data['campName'] = campName;
    return data;
  }
}
