class Attendance {
  String? tranDate;
  String? dateName;
  String? transactionStatusTitle;
  String? notes;
  String? shiftStart;
  String? shiftEnd;
  String? clockIn;
  String? clockOut;
  double? latency;

  Attendance(
      {this.tranDate,
        this.dateName,
        this.transactionStatusTitle,
        this.notes,
        this.shiftStart,
        this.shiftEnd,
        this.clockIn,
        this.clockOut,
        this.latency});

  Attendance.fromJson(Map<String, dynamic> json) {
    tranDate = json['tranDate'];
    dateName = json['dateName'];
    transactionStatusTitle = json['transactionStatusTitle'];
    notes = json['notes'];
    shiftStart = json['shiftStart'];
    shiftEnd = json['shiftEnd'];
    clockIn = json['clockIn'];
    clockOut = json['clockOut'];
    latency = json['latency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tranDate'] = tranDate;
    data['dateName'] = dateName;
    data['transactionStatusTitle'] = transactionStatusTitle;
    data['notes'] = notes;
    data['shiftStart'] = shiftStart;
    data['shiftEnd'] = shiftEnd;
    data['clockIn'] = clockIn;
    data['clockOut'] = clockOut;
    data['latency'] = latency;
    return data;
  }
}
