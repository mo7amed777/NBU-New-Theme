class CommentModel {
  int? id;
  String? comment;
  String? creationDate;
  User? user;

  CommentModel({this.id, this.comment, this.creationDate, this.user});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    creationDate = json['creationDate'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['creationDate'] = creationDate;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? nameAr;
  String? nameEn;

  User({this.nameAr, this.nameEn});

  User.fromJson(Map<String, dynamic> json) {
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameAr'] = nameAr;
    data['nameEn'] = nameEn;
    return data;
  }
}
