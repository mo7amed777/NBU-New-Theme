class AcademicResearch {
  int? id;
  String? name;
  String? nid;
  int? genderId;
  String? nationality;
  int? collegeCode;
  String? collegeName;
  String? sectionName;
  int? sectionCode;
  String? generalSpecialization;
  String? specificSpecialization;
  String? jobCode;
  String? mobileNo;
  String? universityEmail;
  String? personalEmail;
  String? scopusId;
  String? wosId;
  String? scholarId;
  String? orcidId;
  String? lastJobRankName;

  AcademicResearch(
      {this.id,
      this.name,
      this.nid,
      this.genderId,
      this.nationality,
      this.collegeCode,
      this.collegeName,
      this.sectionName,
      this.sectionCode,
      this.generalSpecialization,
      this.specificSpecialization,
      this.jobCode,
      this.mobileNo,
      this.universityEmail,
      this.personalEmail,
      this.scopusId,
      this.wosId,
      this.scholarId,
      this.orcidId,
      this.lastJobRankName});

  AcademicResearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nid = json['nid'];
    genderId = json['genderId'];
    nationality = json['nationality'];
    collegeCode = json['collegeCode'];
    collegeName = json['collegeName'];
    sectionName = json['sectionName'];
    sectionCode = json['sectionCode'];
    generalSpecialization = json['generalSpecialization'];
    specificSpecialization = json['specificSpecialization'];
    jobCode = json['jobCode'];
    mobileNo = json['mobileNo'];
    universityEmail = json['universityEmail'];
    personalEmail = json['personalEmail'];
    scopusId = json['scopusId'];
    wosId = json['wosId'];
    scholarId = json['scholarId'];
    orcidId = json['orcidId'];
    lastJobRankName = json['lastJobRankName'];
  }
}
