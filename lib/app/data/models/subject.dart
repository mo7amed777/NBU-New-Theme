class SubjectModel {
  String? titleAr;
  int? meetingId;
  int? id;
  int? subjectId;
  String? details;
  String? decision;
  int? councilDecisionTypeId;
  int? subjectClassId;
  String? creationDate;

  SubjectModel(
      {this.titleAr,
        this.meetingId,
        this.id,
        this.subjectId,
        this.details,
        this.decision,
        this.councilDecisionTypeId,
        this.subjectClassId,
        this.creationDate});

  SubjectModel.fromJson(Map<String, dynamic> json) {
    titleAr = json['titleAr'];
    meetingId = json['meetingId'];
    id = json['id'];
    subjectId = json['subjectId'];
    details = json['details'];
    decision = json['decision'];
    councilDecisionTypeId = json['councilDecisionTypeId'];
    subjectClassId = json['subjectClassId'];
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['titleAr'] = titleAr;
    data['meetingId'] = meetingId;
    data['id'] = id;
    data['subjectId'] = subjectId;
    data['details'] = details;
    data['decision'] = decision;
    data['councilDecisionTypeId'] = councilDecisionTypeId;
    data['subjectClassId'] = subjectClassId;
    data['creationDate'] = creationDate;
    return data;
  }
}
