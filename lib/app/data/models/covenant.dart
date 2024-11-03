class Covenant {
  String? idNumber;
  String? employeeName;
  String? itemNumber;
  String? itemName;
  String? itemUnitName;
  int? itemsCount;

  Covenant(
      {this.idNumber,
        this.employeeName,
        this.itemNumber,
        this.itemName,
        this.itemUnitName,
        this.itemsCount});

  Covenant.fromJson(Map<String, dynamic> json) {
    idNumber = json['idNumber'];
    employeeName = json['employeeName'];
    itemNumber = json['itemNumber'];
    itemName = json['itemName'];
    itemUnitName = json['itemUnitName'];
    itemsCount = json['itemsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNumber'] = idNumber;
    data['employeeName'] = employeeName;
    data['itemNumber'] = itemNumber;
    data['itemName'] = itemName;
    data['itemUnitName'] = itemUnitName;
    data['itemsCount'] = itemsCount;
    return data;
  }
}






