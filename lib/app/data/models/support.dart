class SupportRequest {
  int? id;
  String? title;
  String? encId;
  int? statusId;
  String? statusNameEn;
  String? statusNameAr;
  int? parentWorkBesideId;
  String? workBesideNameAr;
  String? workBesideNameEn;
  int? totalItem;
  int? rate;

  SupportRequest(
      {this.id,
      this.title,
      this.encId,
      this.statusId,
      this.statusNameEn,
      this.statusNameAr,
      this.parentWorkBesideId,
      this.workBesideNameAr,
      this.workBesideNameEn,
      this.rate,
      this.totalItem});

  SupportRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    encId = json['encId'];
    statusId = json['statusId'];
    statusNameEn = json['statusNameEn'];
    statusNameAr = json['statusNameAr'];
    parentWorkBesideId = json['parentWorkBesideId'];
    workBesideNameAr = json['workBesideNameAr'];
    workBesideNameEn = json['workBesideNameEn'];
    totalItem = json['totalItem'];
    rate = json['rate'];
  }
}
