import 'dart:convert';

class User {
  String? assignmentCivilRecordNumber;
  int? employeeid;
  String? recordNumber;
  String? firstName;
  String? secondName;
  String? thirdName;
  String? familyName;
  String? arabicName;
  String? latinFirstName;
  String? latinSecondName;
  String? latinThirdName;
  String? latinFamilyName;
  String? latinFullName;
  String? nationalityName;
  String? sexTypeName;
  String? maritalStatusName;
  String? hijriBirthDate;
  String? gregorianBirthDate;
  String? assignmentGovernmentalHireDate;
  String? hiringDate;
  String? lastPromotionDate;
  String? employeeTypeName;
  String? lastJobEmploymentGroupName;
  String? lastJobRankName;
  int? jobRankSerial;
  String? lastJobName;
  String? employeeLocationUnitName;
  String? employeeDepartmentUnitName;
  String? collegeName;
  String? sectionName;
  int? levelOneDepartmentID;
  int? levelTwoDepartmentID;
  String? highestQualificationName;
  String? lastMainSpecialtyName;
  String? lastSubSpecialtyName;
  String? lastAccurateSpecialty;
  String? phoneNo;
  String? emailAddress;
  String? employeeStatusName;
  int? isAcadimic;
  String? fileExtension;
  String? imageBody;
  int? vacationBalance;

  User({
    this.assignmentCivilRecordNumber,
    this.employeeid,
    this.recordNumber,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.familyName,
    this.arabicName,
    this.latinFirstName,
    this.latinSecondName,
    this.latinThirdName,
    this.latinFamilyName,
    this.latinFullName,
    this.nationalityName,
    this.sexTypeName,
    this.maritalStatusName,
    this.hijriBirthDate,
    this.gregorianBirthDate,
    this.assignmentGovernmentalHireDate,
    this.hiringDate,
    this.lastPromotionDate,
    this.employeeTypeName,
    this.lastJobEmploymentGroupName,
    this.lastJobRankName,
    this.jobRankSerial,
    this.lastJobName,
    this.employeeLocationUnitName,
    this.employeeDepartmentUnitName,
    this.collegeName,
    this.sectionName,
this.levelOneDepartmentID,
    this.levelTwoDepartmentID,
    this.highestQualificationName,
    this.lastMainSpecialtyName,
    this.lastSubSpecialtyName,
    this.lastAccurateSpecialty,
    this.phoneNo,
    this.emailAddress,
    this.employeeStatusName,
    this.isAcadimic,
    this.fileExtension,
    this.imageBody,
    this.vacationBalance,
  });

  factory User.fromMap(Map data) => User(
        assignmentCivilRecordNumber:
            data['assignmentCivilRecordNumber'] as String?,
    employeeid: data['employeeid'] as int?,
        recordNumber: data['recordNumber'] as String?,
        firstName: data['firstName'] as String?,
        secondName: data['secondName'] as String?,
        thirdName: data['thirdName'] as String?,
        familyName: data['familyName'] as String?,
        arabicName: data['arabicName'] as String?,
        latinFirstName: data['latinFirstName'] as String?,
        latinSecondName: data['latinSecondName'] as String?,
        latinThirdName: data['latinThirdName'] as String?,
        latinFamilyName: data['latinFamilyName'] as String?,
        latinFullName: data['latinFullName'] as String?,
        nationalityName: data['nationalityName'] as String?,
        sexTypeName: data['sexTypeName'] as String?,
        maritalStatusName: data['maritalStatusName'] as String?,
        hijriBirthDate: data['hijriBirthDate'] as String?,
        gregorianBirthDate: data['gregorianBirthDate'] as String?,
        assignmentGovernmentalHireDate:
            data['assignmentGovernmentalHireDate'] as String?,
        hiringDate: data['hiringDate'] as String?,
        lastPromotionDate: data['lastPromotionDate'] as String?,
        employeeTypeName: data['employeeTypeName'] as String?,
        lastJobEmploymentGroupName:
            data['lastJobEmploymentGroupName'] as String?,
        lastJobRankName: data['lastJobRankName'] as String?,
        jobRankSerial: data['jobRankSerial'] as int?,
        lastJobName: data['lastJobName'] as String?,
        employeeLocationUnitName: data['employeeLocationUnitName'] as String?,
        employeeDepartmentUnitName:
            data['employeeDepartmentUnitName'] as String?,
        collegeName: data['collegeName'] as String?,
        sectionName: data['sectionName'] as String?,
        levelOneDepartmentID: data['levelOneDepartmentID'] as int?,
    levelTwoDepartmentID: data['levelTwoDepartmentID'] as int?,
    highestQualificationName: data['highestQualificationName'] as String?,
        lastMainSpecialtyName: data['lastMainSpecialtyName'] as String?,
        lastSubSpecialtyName: data['lastSubSpecialtyName'] as String?,
        lastAccurateSpecialty: data['lastAccurateSpecialty'] as String?,
        phoneNo: data['phoneNo'] as String?,
        emailAddress: data['emailAddress'] as String?,
        employeeStatusName: data['employeeStatusName'] as String?,
        isAcadimic: data['isAcadimic'] as int?,
        fileExtension: data['fileExtension'] as String?,
        imageBody: data['imageBody'] as String?,
        vacationBalance: data['vacationBalance'] as int?,

  );

  Map<String, dynamic> toMap() => {
        'assignmentCivilRecordNumber': assignmentCivilRecordNumber,
    'employeeid':employeeid,
        'recordNumber': recordNumber,
        'firstName': firstName,
        'secondName': secondName,
        'thirdName': thirdName,
        'familyName': familyName,
        'arabicName': arabicName,
        'latinFirstName': latinFirstName,
        'latinSecondName': latinSecondName,
        'latinThirdName': latinThirdName,
        'latinFamilyName': latinFamilyName,
        'latinFullName': latinFullName,
        'nationalityName': nationalityName,
        'sexTypeName': sexTypeName,
        'maritalStatusName': maritalStatusName,
        'hijriBirthDate': hijriBirthDate,
        'gregorianBirthDate': gregorianBirthDate,
        'assignmentGovernmentalHireDate': assignmentGovernmentalHireDate,
        'hiringDate': hiringDate,
        'lastPromotionDate': lastPromotionDate,
        'employeeTypeName': employeeTypeName,
        'lastJobEmploymentGroupName': lastJobEmploymentGroupName,
        'lastJobRankName': lastJobRankName,
        'jobRankSerial': jobRankSerial,
        'lastJobName': lastJobName,
        'employeeLocationUnitName': employeeLocationUnitName,
        'employeeDepartmentUnitName': employeeDepartmentUnitName,
        'collegeName': collegeName,
        'sectionName': sectionName,
    'levelOneDepartmentID': levelOneDepartmentID,
    'levelTwoDepartmentID': levelTwoDepartmentID,
        'highestQualificationName': highestQualificationName,
        'lastMainSpecialtyName': lastMainSpecialtyName,
        'lastSubSpecialtyName': lastSubSpecialtyName,
        'lastAccurateSpecialty': lastAccurateSpecialty,
        'phoneNo': phoneNo,
        'emailAddress': emailAddress,
        'employeeStatusName': employeeStatusName,
        'isAcadimic': isAcadimic,
        'fileExtension': fileExtension,
        'imageBody': imageBody,
        'vacationBalance' : vacationBalance,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

}
