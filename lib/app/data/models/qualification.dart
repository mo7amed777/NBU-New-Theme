class Qualification {
  String? assignmentCivilRecordNumber;
  String? certificateName;
  String? graduationUnitName;
  String? countryName;
  String? hijriCertificateDate;
  String? gregorianCertificateDate;
  String? mainSpecialtyDescription;
  String? subSpecialtyDescription;
  int? attachmentId;

  Qualification({
    this.assignmentCivilRecordNumber,
    this.certificateName,
    this.graduationUnitName,
    this.countryName,
    this.hijriCertificateDate,
    this.gregorianCertificateDate,
    this.mainSpecialtyDescription,
    this.subSpecialtyDescription,
    this.attachmentId,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
        assignmentCivilRecordNumber:
            json['assignmentCivilRecordNumber'] as String?,
        certificateName: json['certificateName'] as String?,
        graduationUnitName: json['graduationUnitName'] as String?,
        countryName: json['countryName'] as String?,
        hijriCertificateDate: json['hijriCertificateDate'] as String?,
        gregorianCertificateDate: json['gregorianCertificateDate'] as String?,
        mainSpecialtyDescription: json['mainSpecialtyDescription'] as String?,
        subSpecialtyDescription: json['subSpecialtyDescription'] as String?,
        attachmentId: json['attachmentId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'assignmentCivilRecordNumber': assignmentCivilRecordNumber,
        'certificateName': certificateName,
        'graduationUnitName': graduationUnitName,
        'countryName': countryName,
        'hijriCertificateDate': hijriCertificateDate,
        'gregorianCertificateDate': gregorianCertificateDate,
        'mainSpecialtyDescription': mainSpecialtyDescription,
        'subSpecialtyDescription': subSpecialtyDescription,
        'attachmentId': attachmentId,
      };
}
