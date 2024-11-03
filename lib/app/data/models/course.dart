class Course {
  String? assignmentCivilRecordNumber;
  String? arabicName;
  String? courseNameDesc;
  String? startDate;
  int? coursePeriod;
  String? endDate;
  String? courseDate;
  String? graduationName;
  String? evaluationName;
  int? imageAttachmentId;

  Course({
    this.assignmentCivilRecordNumber,
    this.arabicName,
    this.courseNameDesc,
    this.startDate,
    this.coursePeriod,
    this.endDate,
    this.courseDate,
    this.graduationName,
    this.evaluationName,
    this.imageAttachmentId,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        assignmentCivilRecordNumber:
            json['assignmentCivilRecordNumber'] as String?,
        arabicName: json['arabicName'] as String?,
        courseNameDesc: json['courseNameDesc'] as String?,
        startDate: json['startDate'] as String?,
        coursePeriod: json['coursePeriod'] as int?,
        endDate: json['endDate'] as String?,
        courseDate: json['courseDate'] as String?,
        graduationName: json['graduationName'] as String?,
        evaluationName: json['evaluationName'] as String?,
        imageAttachmentId: json['imageAttachmentId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'assignmentCivilRecordNumber': assignmentCivilRecordNumber,
        'arabicName': arabicName,
        'courseNameDesc': courseNameDesc,
        'startDate': startDate,
        'coursePeriod': coursePeriod,
        'endDate': endDate,
        'courseDate': courseDate,
        'graduationName': graduationName,
        'evaluationName': evaluationName,
        'imageAttachmentId': imageAttachmentId,
      };
}
