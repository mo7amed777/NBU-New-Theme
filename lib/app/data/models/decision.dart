class Decision {
  String? decisionNO;
  String? decisionName;
  String? fromDate;
  String? toDate;
  String? presenceDate;
  String? effectiveDate;
  double? basicSalary;

  Decision(
      {this.decisionNO,
        this.decisionName,
        this.fromDate,
        this.toDate,
        this.presenceDate,
        this.effectiveDate,
        this.basicSalary});

  Decision.fromJson(Map<String, dynamic> json) {
    decisionNO = json['decisionNO'];
    decisionName = json['decisionName'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    presenceDate = json['presenceDate'];
    effectiveDate = json['effectiveDate'];
    basicSalary = json['basicSalary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['decisionNO'] = decisionNO;
    data['decisionName'] = decisionName;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['presenceDate'] = presenceDate;
    data['effectiveDate'] = effectiveDate;
    data['basicSalary'] = basicSalary;
    return data;
  }
}
