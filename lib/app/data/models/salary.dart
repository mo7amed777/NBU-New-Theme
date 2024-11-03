class SalaryDefinition {
  String? nid;
  String? emNo;
  String? empName;
  String? englishName;
  String? nationalityName;
  String? englishNationalityName;
  String? jobName;
  String? jobNameEN;
  String? rankName;
  String? degree;
  String? governmentalHireDate;
  String? bankName;
  String? swiftCode;
  String? bankAccountNumber;
  double? salary;
  double? monthlyAllowance;
  double? monthlyDeduction;
  double? monthlyLoan;
  double? totalDeduction;
  double? netSalary;

  SalaryDefinition(
      {this.nid,
      this.emNo,
      this.empName,
      this.englishName,
      this.nationalityName,
      this.englishNationalityName,
      this.jobName,
      this.jobNameEN,
      this.rankName,
      this.degree,
      this.governmentalHireDate,
      this.bankName,
      this.swiftCode,
      this.bankAccountNumber,
      this.salary,
      this.monthlyAllowance,
      this.monthlyDeduction,
      this.monthlyLoan,
      this.totalDeduction,
      this.netSalary});

  SalaryDefinition.fromJson(Map<String, dynamic> json) {
    nid = json['nid'];
    emNo = json['emNo'];
    empName = json['empName'];
    englishName = json['englishName'];
    nationalityName = json['nationalityName'];
    englishNationalityName = json['englishNationalityName'];
    jobName = json['jobName'];
    jobNameEN = json['jobNameEN'];
    rankName = json['rankName'];
    degree = json['degree'];
    governmentalHireDate = json['governmentalHireDate'];
    bankName = json['bankName'];
    swiftCode = json['swiftCode'];
    bankAccountNumber = json['bankAccountNumber'];
    salary = json['salary'];
    monthlyAllowance = json['monthlyAllowance'];
    monthlyDeduction = json['monthlyDeduction'];
    monthlyLoan = json['monthlyLoan'];
    totalDeduction = json['totalDeduction'];
    netSalary = json['netSalary'];
  }
}
