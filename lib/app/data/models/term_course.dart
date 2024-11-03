class TermCourse {
  int? id;
  String? place;
  String? description;
  int? hours;
  bool? beforeUndoDays;
  String? fromDate;
  String? toDate;
  bool? maximumCapacity;
  bool? registeredBefore;
  Attendance? attendance;
  Course? course;
  Category? category;
  List<TermInstructors>? termInstructors;
  List<TermSchedules>? termSchedules;
  List<Levels>? levels;

  TermCourse(
      {this.id,
      this.place,
      this.description,
      this.hours,
      this.beforeUndoDays,
      this.fromDate,
      this.toDate,
      this.maximumCapacity,
      this.registeredBefore,
      this.attendance,
      this.course,
      this.category,
      this.termInstructors,
      this.termSchedules,
      this.levels});

  TermCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    place = json['place'];
    description = json['description'];
    hours = json['hours'];
    beforeUndoDays = json['beforeUndoDays'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    maximumCapacity = json['maximumCapacity'];
    registeredBefore = json['registeredBefore'];
    attendance = json['attendance'] != null
        ? Attendance.fromJson(json['attendance'])
        : null;
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['termInstructors'] != null) {
      termInstructors = <TermInstructors>[];
      json['termInstructors'].forEach((v) {
        termInstructors!.add(TermInstructors.fromJson(v));
      });
    }
    if (json['termSchedules'] != null) {
      termSchedules = <TermSchedules>[];
      json['termSchedules'].forEach((v) {
        termSchedules!.add(TermSchedules.fromJson(v));
      });
    }
    if (json['levels'] != null) {
      levels = <Levels>[];
      json['levels'].forEach((v) {
        levels!.add(Levels.fromJson(v));
      });
    }
  }
}

class Attendance {
  int? attendanceTypeId;
  String? arabicName;
  String? englishName;

  Attendance({this.attendanceTypeId, this.arabicName, this.englishName});

  Attendance.fromJson(Map<String, dynamic> json) {
    attendanceTypeId = json['attendanceTypeId'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
  }
}

class Course {
  int? courseId;
  String? arabicName;
  String? englishName;

  Course({this.courseId, this.arabicName, this.englishName});

  Course.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
  }
}

class Category {
  int? categoryId;
  String? arabicName;
  String? englishName;
  String? color;

  Category({this.categoryId, this.arabicName, this.englishName, this.color});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    color = json['color'];
  }
}

class TermInstructors {
  int? instructorId;
  String? arabicName;
  String? englishName;

  TermInstructors({this.instructorId, this.arabicName, this.englishName});

  TermInstructors.fromJson(Map<String, dynamic> json) {
    instructorId = json['instructorId'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
  }
}

class TermSchedules {
  String? arabicName;
  String? englishName;
  String? fromTime;
  String? toTime;

  TermSchedules(
      {this.arabicName, this.englishName, this.fromTime, this.toTime});

  TermSchedules.fromJson(Map<String, dynamic> json) {
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
  }
}

class Levels {
  int? levelId;
  String? arabicName;
  String? englishName;

  Levels({this.levelId, this.arabicName, this.englishName});

  Levels.fromJson(Map<String, dynamic> json) {
    levelId = json['levelId'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
  }
}
