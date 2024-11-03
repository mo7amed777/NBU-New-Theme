class SupportData {
  RequestInfo? requestInfo;
  List<RequestAttachment>? requestAttachment;
  List<WorkFlowTask>? workFlowTask;
  List<TaskNotes>? taskNotes;

  SupportData(
      {this.requestInfo,
      this.requestAttachment,
      this.workFlowTask,
      this.taskNotes});

  SupportData.fromJson(Map<String, dynamic> json) {
    requestInfo = json['requestInfo'] != null
        ? RequestInfo.fromJson(json['requestInfo'])
        : null;
    if (json['requestAttachment'] != null) {
      requestAttachment = <RequestAttachment>[];
      json['requestAttachment'].forEach((v) {
        requestAttachment!.add(RequestAttachment.fromJson(v));
      });
    }
    if (json['workFlowTask'] != null) {
      workFlowTask = <WorkFlowTask>[];
      json['workFlowTask'].forEach((v) {
        workFlowTask!.add(WorkFlowTask.fromJson(v));
      });
    }
    if (json['taskNotes'] != null) {
      taskNotes = <TaskNotes>[];
      json['taskNotes'].forEach((v) {
        taskNotes!.add(TaskNotes.fromJson(v));
      });
    }
  }
}

class RequestInfo {
  int? id;
  int? finalStatusId;
  String? date;
  String? statusNameAr;
  String? statusNameEn;
  int? parentWorkBesideId;
  String? parentWorkBesideNameAr;
  String? parentWorkBesideNameEn;
  String? workBesideUserCreateRequestNameAr;
  String? title;
  String? serviceNameAr;
  String? executionPlace;
  String? executedDate;
  String? executedTime;
  String? notes;
  int? rate;
  String? rateNotes;
  int? requestTypeId;
  String? requestTypeNameAr;
  String? requestTypeNameEn;

  RequestInfo(
      {this.id,
      this.finalStatusId,
      this.date,
      this.statusNameAr,
      this.statusNameEn,
      this.parentWorkBesideId,
      this.parentWorkBesideNameAr,
      this.parentWorkBesideNameEn,
      this.workBesideUserCreateRequestNameAr,
      this.title,
      this.executionPlace,
      this.executedDate,
      this.executedTime,
      this.serviceNameAr,
      this.notes,
      this.rate,
      this.rateNotes,
      this.requestTypeId,
      this.requestTypeNameAr,
      this.requestTypeNameEn});

  RequestInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    finalStatusId = json['finalStatusId'];
    date = json['date'];
    statusNameAr = json['statusNameAr'];
    statusNameEn = json['statusNameEn'];
    parentWorkBesideId = json['parentWorkBesideId'];
    parentWorkBesideNameAr = json['parentWorkBesideNameAr'];
    parentWorkBesideNameEn = json['parentWorkBesideNameEn'];
    workBesideUserCreateRequestNameAr =
        json['workBesideUserCreateRequestNameAr'];
    title = json['title'];
    executionPlace = json['executionPlace'];
    serviceNameAr = json['serviceNameAr'];
    executedDate = json['executedDate'];
    executedTime = json['executedTime'];
    notes = json['notes'];
    rate = json['rate'];
    rateNotes = json['rateNotes'];
    requestTypeId = json['requestTypeId'];
    requestTypeNameAr = json['requestTypeNameAr'];
    requestTypeNameEn = json['requestTypeNameEn'];
  }
}

class RequestAttachment {
  int? id;
  String? attachmentId;
  String? extention;
  int? attachmentTypeId;
  String? path;

  RequestAttachment(
      {this.id,
      this.attachmentId,
      this.extention,
      this.attachmentTypeId,
      this.path});

  RequestAttachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attachmentId = json['attachmentId'];
    extention = json['extention'];
    attachmentTypeId = json['attachmentTypeId'];
    path = json['path'];
  }
}

class WorkFlowTask {
  int? id;
  String? date;
  int? statusId;
  String? statusNameEn;
  String? statusNameAr;
  int? workBesideId;
  String? workBesideNameAr;
  String? workBesideNameEn;
  int? userId;
  String? userNameAr;
  String? userNameEn;
  int? createdById;
  String? createdByNameAr;
  String? createdByNameEn;

  WorkFlowTask(
      {this.id,
      this.date,
      this.statusId,
      this.statusNameEn,
      this.statusNameAr,
      this.workBesideId,
      this.workBesideNameAr,
      this.workBesideNameEn,
      this.userId,
      this.userNameAr,
      this.userNameEn,
      this.createdById,
      this.createdByNameAr,
      this.createdByNameEn});

  WorkFlowTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    statusId = json['statusId'];
    statusNameEn = json['statusNameEn'];
    statusNameAr = json['statusNameAr'];
    workBesideId = json['workBesideId'];
    workBesideNameAr = json['workBesideNameAr'];
    workBesideNameEn = json['workBesideNameEn'];
    userId = json['userId'];
    userNameAr = json['userNameAr'];
    userNameEn = json['userNameEn'];
    createdById = json['createdById'];
    createdByNameAr = json['createdByNameAr'];
    createdByNameEn = json['createdByNameEn'];
  }
}

class TaskNotes {
  int? id;
  String? notes;
  String? createdByNameAr;
  String? createdByNameEn;
  String? date;
  String? creationDate;
  String? attachmentId;
  String? path;
  String? extention;
  int? attachmentTypeId;

  TaskNotes(
      {this.id,
      this.notes,
      this.createdByNameAr,
      this.createdByNameEn,
      this.date,
      this.creationDate,
      this.attachmentId,
      this.path,
      this.extention,
      this.attachmentTypeId});

  TaskNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notes = json['notes'];
    createdByNameAr = json['createdByNameAr'];
    createdByNameEn = json['createdByNameEn'];
    date = json['date'];
    creationDate = json['creationDate'];
    attachmentId = json['attachmentId'];
    path = json['path'];
    extention = json['extention'];
    attachmentTypeId = json['attachmentTypeId'];
  }
}
