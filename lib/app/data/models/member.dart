class MemberModel {
  String? userNID;
  String? userNameAr;
  String? userNameEn;
  int? order;
  int? privilegeId;
  String? privilegeNameAr;
  String? privilegeNameEn;

  MemberModel(
      {this.userNID,
        this.userNameAr,
        this.userNameEn,
        this.order,
        this.privilegeId,
        this.privilegeNameAr,
        this.privilegeNameEn});

  MemberModel.fromJson(Map<String, dynamic> json) {
    userNID = json['userNID'];
    userNameAr = json['userNameAr'];
    userNameEn = json['userNameEn'];
    order = json['order'];
    privilegeId = json['privilegeId'];
    privilegeNameAr = json['privilegeNameAr'];
    privilegeNameEn = json['privilegeNameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userNID'] = userNID;
    data['userNameAr'] = userNameAr;
    data['userNameEn'] = userNameEn;
    data['order'] = order;
    data['privilegeId'] = privilegeId;
    data['privilegeNameAr'] = privilegeNameAr;
    data['privilegeNameEn'] = privilegeNameEn;
    return data;
  }
}
