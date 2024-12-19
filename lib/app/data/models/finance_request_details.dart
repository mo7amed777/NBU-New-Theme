class FinanceRequestDetails {
  RequestInfo? requestInfo;
  List<RequestAttachment>? requestAttachment;
  List<WorkFlowTask>? workFlowTask;

  FinanceRequestDetails(
      {this.requestInfo, this.requestAttachment, this.workFlowTask});

  FinanceRequestDetails.fromJson(Map<String, dynamic> json) {
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
  }
}

class RequestInfo {
  int? employeeId;
  String? employeeName;
  String? employeeNid;
  String? employeeEmail;
  String? employeePhone;
  dynamic scholarshipId;
  String? scholarshipCountry;
  String? scholarshipEndDate;
  String? scholarshipDegree;
  int? collegeCode;
  String? collegeName;
  int? sectionCode;
  String? sectionName;
  int? financeRequestType;
  String? arNameFinanceRequestType;
  String? enNameFinanceRequestType;
  String? jobCode;
  String? jobRankName;
  String? projectId;
  int? requestId;
  String? date;
  String? magazineSubjectCategory;
  String? finalPublicationAcceptanceDate;
  String? magazineName;
  String? magazineUrl;
  int? applicantRoleId;
  String? arNameApplicantRole;
  String? enNameApplicantRole;
  String? title;
  String? arNameFinanceStatus;
  String? enNameFinanceStatus;
  String? arNameFinancePriorty;
  String? enNameFinancePriorty;
  int? financeStatusId;
  String? bank;
  String? iban;
  bool? isAcceptedFromNBU;
  String? issn;
  bool? isNotSupportFromAnyWorkBeside;
  int? totalCountParticipant;
  int? outsideUnivertstParticipantCount;
  int? universityParticipantCount;
  String? universityName;
  dynamic universityOrder;
  String? nidSectionPresident;
  String? nameSectionPresident;
  int? universityRanking;
  int? financePriortyId;

  RequestInfo(
      {this.employeeId,
      this.employeeName,
      this.employeeNid,
      this.employeeEmail,
      this.employeePhone,
      this.scholarshipId,
      this.scholarshipCountry,
      this.scholarshipEndDate,
      this.scholarshipDegree,
      this.collegeCode,
      this.collegeName,
      this.sectionCode,
      this.sectionName,
      this.financeRequestType,
      this.arNameFinanceRequestType,
      this.enNameFinanceRequestType,
      this.jobCode,
      this.jobRankName,
      this.projectId,
      this.requestId,
      this.date,
      this.magazineSubjectCategory,
      this.finalPublicationAcceptanceDate,
      this.magazineName,
      this.magazineUrl,
      this.applicantRoleId,
      this.arNameApplicantRole,
      this.enNameApplicantRole,
      this.title,
      this.arNameFinanceStatus,
      this.enNameFinanceStatus,
      this.arNameFinancePriorty,
      this.enNameFinancePriorty,
      this.financeStatusId,
      this.bank,
      this.iban,
      this.isAcceptedFromNBU,
      this.issn,
      this.isNotSupportFromAnyWorkBeside,
      this.totalCountParticipant,
      this.outsideUnivertstParticipantCount,
      this.universityParticipantCount,
      this.universityName,
      this.universityOrder,
      this.nidSectionPresident,
      this.nameSectionPresident,
      this.universityRanking,
      this.financePriortyId});

  RequestInfo.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    employeeName = json['employeeName'];
    employeeNid = json['employeeNid'];
    employeeEmail = json['employeeEmail'];
    employeePhone = json['employeePhone'];
    scholarshipId = json['scholarshipId'];
    scholarshipCountry = json['scholarshipCountry'];
    scholarshipEndDate = json['scholarshipEndDate'];
    scholarshipDegree = json['scholarshipDegree'];
    collegeCode = json['collegeCode'];
    collegeName = json['collegeName'];
    sectionCode = json['sectionCode'];
    sectionName = json['sectionName'];
    financeRequestType = json['financeRequestType'];
    arNameFinanceRequestType = json['arNameFinanceRequestType'];
    enNameFinanceRequestType = json['enNameFinanceRequestType'];
    jobCode = json['jobCode'];
    jobRankName = json['jobRankName'];
    projectId = json['projectId'];
    requestId = json['requestId'];
    date = json['date'];
    magazineSubjectCategory = json['magazineSubjectCategory'];
    finalPublicationAcceptanceDate = json['finalPublicationAcceptanceDate'];
    magazineName = json['magazineName'];
    magazineUrl = json['magazineUrl'];
    applicantRoleId = json['applicantRoleId'];
    arNameApplicantRole = json['arNameApplicantRole'];
    enNameApplicantRole = json['enNameApplicantRole'];
    title = json['title'];
    arNameFinanceStatus = json['arNameFinanceStatus'];
    enNameFinanceStatus = json['enNameFinanceStatus'];
    arNameFinancePriorty = json['arNameFinancePriorty'];
    enNameFinancePriorty = json['enNameFinancePriorty'];
    financeStatusId = json['financeStatusId'];
    bank = json['bank'];
    iban = json['iban'];
    isAcceptedFromNBU = json['isAcceptedFromNBU'];
    issn = json['issn'];
    isNotSupportFromAnyWorkBeside = json['isNotSupportFromAnyWorkBeside'];
    totalCountParticipant = json['totalCountParticipant'];
    outsideUnivertstParticipantCount = json['outsideUnivertstParticipantCount'];
    universityParticipantCount = json['universityParticipantCount'];
    universityName = json['universityName'];
    universityOrder = json['universityOrder'];
    nidSectionPresident = json['nidSectionPresident'];
    nameSectionPresident = json['nameSectionPresident'];
    universityRanking = json['universityRanking'];
    financePriortyId = json['financePriortyId'];
  }
}

class RequestAttachment {
  int? id;
  String? attachmentId;
  String? extention;
  int? attachmentTypeId;
  int? type;
  String? path;

  RequestAttachment(
      {this.id,
      this.attachmentId,
      this.extention,
      this.attachmentTypeId,
      this.type,
      this.path});

  RequestAttachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attachmentId = json['attachmentId'];
    extention = json['extention'];
    attachmentTypeId = json['attachmentTypeId'];
    type = json['type'];
    path = json['path'];
  }
}

class WorkFlowTask {
  int? id;
  String? date;
  int? approveType;
  int? approveStatus;
  String? fromUserName;
  String? toUserName;
  String? toUserNid;
  String? notes;
  String? sessionDate;
  dynamic sessionNumber;

  WorkFlowTask(
      {this.id,
      this.date,
      this.approveType,
      this.approveStatus,
      this.fromUserName,
      this.toUserName,
      this.toUserNid,
      this.notes,
      this.sessionDate,
      this.sessionNumber});

  WorkFlowTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    approveType = json['approveType'];
    approveStatus = json['approveStatus'];
    fromUserName = json['fromUserName'];
    toUserName = json['toUserName'];
    toUserNid = json['toUserNid'];
    notes = json['notes'];
    sessionDate = json['sessionDate'];
    sessionNumber = json['sessionNumber'];
  }
}
