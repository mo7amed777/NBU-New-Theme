class CouncilModel {
  int? id;
  String? title;
  String? startDate;
  String? mainTypeName;
  String? commTypeName;
  String? subTypeName;
  String? counContName;
  String? sideName;
  String? encCounNo;

  CouncilModel(
      {this.id,
        this.title,
        this.startDate,
        this.mainTypeName,
        this.commTypeName,
        this.subTypeName,
        this.counContName,
        this.sideName,
        this.encCounNo});

  CouncilModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['startDate'];
    mainTypeName = json['mainTypeName'];
    commTypeName = json['commTypeName'];
    subTypeName = json['subTypeName'];
    counContName = json['counContName'];
    sideName = json['sideName'];
    encCounNo = json['encCounNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['startDate'] = startDate;
    data['mainTypeName'] = mainTypeName;
    data['commTypeName'] = commTypeName;
    data['subTypeName'] = subTypeName;
    data['counContName'] = counContName;
    data['sideName'] = sideName;
    data['encCounNo'] = encCounNo;
    return data;
  }
}
