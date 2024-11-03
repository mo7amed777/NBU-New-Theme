class MeetingModel {
  int? id;
  String? titleAr;
  String? meetingStatusNameAr;
  String? intro;
  String? place;
  String? date;
  String? startTime;
  String? endTime;
  String? commentsCloseDate;
  bool? allowComments;
  String? voteCloseDate;
  bool? allowVote;
  bool? isigned;

  MeetingModel(
      {this.id,
        this.titleAr,
        this.meetingStatusNameAr,
        this.intro,
        this.place,
        this.date,
        this.startTime,
        this.endTime,
        this.commentsCloseDate,
        this.allowComments,
        this.voteCloseDate,
        this.isigned,
        this.allowVote});

  MeetingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['titleAr'];
    meetingStatusNameAr = json['meetingStatusNameAr'];
    intro = json['intro'];
    place = json['place'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    commentsCloseDate = json['commentsCloseDate'];
    allowComments = json['allowComments'];
    voteCloseDate = json['voteCloseDate'];
    allowVote = json['allowVote'];
    isigned = json['isigned'];
  }
}
