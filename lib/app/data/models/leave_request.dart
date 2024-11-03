class LeaveRequest {
  int? reqNO;
  String? kind;
  String? execusKind;
  String? leaveDate;
  String? leaveTime;
  String? returnTime;
  String? reason;
  String? leaveExcuseApprovalStatus;
  String? mangerUserName;
  String? actaulIN;
  String? actaulOUT;

  LeaveRequest(
      {this.reqNO,
        this.kind,
        this.execusKind,
        this.leaveDate,
        this.leaveTime,
        this.returnTime,
        this.reason,
        this.leaveExcuseApprovalStatus,
        this.mangerUserName,
        this.actaulIN,
        this.actaulOUT});

  LeaveRequest.fromJson(Map<String, dynamic> json) {
    reqNO = json['reqNO'];
    kind = json['kind'];
    execusKind = json['execusKind'];
    leaveDate = json['leaveDate'];
    leaveTime = json['leaveTime'];
    returnTime = json['returnTime'];
    reason = json['reason'];
    leaveExcuseApprovalStatus = json['leaveExcuseApprovalStatus'];
    mangerUserName = json['mangerUserName'];
    actaulIN = json['actaulIN'];
    actaulOUT = json['actaulOUT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reqNO'] = reqNO;
    data['kind'] = kind;
    data['execusKind'] = execusKind;
    data['leaveDate'] = leaveDate;
    data['leaveTime'] = leaveTime;
    data['returnTime'] = returnTime;
    data['reason'] = reason;
    data['leaveExcuseApprovalStatus'] = leaveExcuseApprovalStatus;
    data['mangerUserName'] = mangerUserName;
    data['actaulIN'] = actaulIN;
    data['actaulOUT'] = actaulOUT;
    return data;
  }
}
