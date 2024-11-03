import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/services/api_call_status.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/pages/controllers/api_controller.dart';
import 'package:eservices/app/pages/views/Surveys/sections_of_servey.dart';
import 'package:eservices/app/pages/views/Surveys/survey_section.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Surveys extends StatelessWidget {
  const Surveys({Key? key, required this.surveys, required this.userData})
      : super(key: key);
  final List surveys;
  final Map<String, dynamic> userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.17, left: 25.w, right: 25.w),
              child: surveys.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              'assets/images/no-data.gif',
                            )),
                        SizedBox(height: 32),
                        Text(
                          'لا يوجد',
                          style: TextStyle(
                            color: colorPrimary,
                            fontSize: 25.sp,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: surveys.map((survey) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyCard(
                          title: survey['surveyNameAr'] ?? '',
                          icon: FontAwesomeIcons.circleQuestion,
                          fullWidth: true,
                          margin: EdgeInsets.all(8.sp),
                          desc: survey['surveyDescription'] ??
                              survey['surveyNameAr'] ??
                              '',
                          subTitle: survey['startDate'].substring(0, 10) ?? '',
                          onTap: () {
                            getSurveyQuestionsByID(
                              surveyID: survey['surveyId'].toString(),
                              surveyName: survey['surveyNameAr'],
                              surveyDescription: survey['surveyDescriptionAr'],
                              surveyPeriodID: survey['periodId'],
                            );
                          },
                        ),
                      );
                    }).toList()),
            ),
          ),
          Positioned(
            top: Get.height * 0.065,
            left: 8.w,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            top: Get.height * 0.07,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorPrimary,
                ),
                child: Text(
                  'الإستبيانات',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getSurveyQuestionsByID({
    required String surveyID,
    required String surveyName,
    required String surveyDescription,
    required int surveyPeriodID,
  }) async {
    APIController apiController = APIController(
        url:
            "https://mobileapi.nbu.edu.sa/api/SurveyExternalApi/GetSurvey?surveyId=$surveyID&PeriodId=$surveyPeriodID");
    await showLoadingOverlay(asyncFunction: () async {
      await apiController.getData();
      if (apiController.apiCallStatus == ApiCallStatus.success) {
        List surveySections = apiController.data['sections'];
        List<SurveySection> sections = [];
        for (var section in surveySections) {
          sections.add(SurveySection.fromJson(section));
        }
        Get.to(() => SectionsOfServey(
              surveySections: sections,
              surveyID: int.parse(surveyID),
              surveyName: surveyName,
              surveyDescription: surveyDescription,
              surveyPeriodID: surveyPeriodID,
              userData: userData,
            ));
      }
    });
  }
}
