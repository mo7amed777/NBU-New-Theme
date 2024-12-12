import 'dart:io';
import 'package:dio/dio.dart' as dio;

import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:get/get.dart';

final body = {
  'UniversityOrder': '',
  'CollegeName': '',
  'CollegeCode': '',
  'NidSectionPresident': '',
  'AcceptFile': '',
  'ISSN': '',
  'IsAcceptedFromNBU': '',
  'NameSectionPresident': '',
  'IBAN': '',
  'IsNotSupportFromAnyWorkBeside': '',
  'ScholarshipEndDate': '',
  'UniversityRanking': '',
  'TotalCountParticipant': '',
  'EmployeeId': '',
  'UniversityParticipantCount': '',
  'JobCode': '',
  'FinanceRequestTypeId': '',
  'ScholarshipDegree': '',
  'FinancePriortyId': '',
  'SectionName': '',
  'SectionCode': '',
  'ApplicantRoleId': '',
  'ProjectId': '',
  'ScholarshipCountry': '',
  'JobRankName': '',
  'MagazineSubjectCategory': '',
  'ResearchFile': '',
  'Title': '',
  'UniversityName': '',
  'EmployeeName': '',
  'OutsideUnivertstParticipantCount': '',
  'MagazineUrl': '',
  'FinalPublicationAcceptanceDate': '',
  'Bank': '',
  'ScholarshipId': '',
  'MagazineName': ''
};

void addRequest(
    {required String title,
    required String place,
    required String date,
    required String notes,
    required int deptID,
    required int serviceID,
    required int workBeside,
    required int requestTypeID,
    required int workBesideID,
    required int subWorkBesideID,
    required List<File> attachments}) async {
  await showLoadingOverlay(asyncFunction: () async {
    List<dio.MultipartFile> attatchments = attachments
        .map((file) => dio.MultipartFile.fromFileSync(file.path,
            filename: file.path.split('/').last))
        .toList();
    Map<String, dynamic> data = {
      "Id": '0',
      "Title": title,
      "ExecutionPlace": place,
      "ExecutedDate": date,
      "Notes": notes,
      "ParentWorkBesideId": deptID,
      "RequestTypeId": requestTypeID,
      "WorkBesideId": workBesideID,
      "WorkBesideUserCreateRequestId": workBeside,
      "SubWorkBesideId": subWorkBesideID,
      "Attachment": attatchments,
      "ServiceId": serviceID,
    };
    dio.FormData formData = dio.FormData.fromMap(data);

    APIController controller = APIController(
      url: 'https://crm.nbu.edu.sa/api/Request/AddRequest',
      body: formData,
      requestType: RequestType.post,
    );

    await controller.getData();
    if (controller.apiCallStatus == ApiCallStatus.success) {
      Get.back();
      CustomSnackBar.showCustomSnackBar(
          title: 'نجاح', message: 'تم اضافة الطلب بنجاح');
    }
  });
}
