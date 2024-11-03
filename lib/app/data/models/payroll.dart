class Payroll {
  String? payNumber;
  String? masterPayName;
  String? payName;
  double? totalDeduction;
  double? totalCompensation;
  double? totalSalary;
  String? payDate;
  String? gregorianYear;
  String? periodName;

  Payroll(
      {this.payNumber,
        this.masterPayName,
        this.payName,
        this.totalDeduction,
        this.totalCompensation,
        this.totalSalary,
        this.payDate,
        this.gregorianYear,
        this.periodName});

  Payroll.fromJson(Map<String, dynamic> json) {
    payNumber = json['payNumber'];
    masterPayName = json['masterPayName'];
    payName = json['payName'];
    totalDeduction = json['totalDeduction'];
    totalCompensation = json['totalCompensation'];
    totalSalary = json['totalSalary'];
    payDate = json['payDate'];
    gregorianYear = json['gregorianYear'];
    periodName = json['periodName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payNumber'] = payNumber;
    data['masterPayName'] = masterPayName;
    data['payName'] = payName;
    data['totalDeduction'] = totalDeduction;
    data['totalCompensation'] = totalCompensation;
    data['totalSalary'] = totalSalary;
    data['payDate'] = payDate;
    data['gregorianYear'] = gregorianYear;
    data['periodName'] = periodName;
    return data;
  }
}
