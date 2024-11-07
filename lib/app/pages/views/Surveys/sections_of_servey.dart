import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/routes/app_pages.dart';
import 'package:eservices/app/services/base_client.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/custom_button.dart';
import 'package:eservices/app/components/custom_loading_overlay.dart';
import 'package:eservices/app/components/custom_snackbar.dart';
import 'package:eservices/app/pages/views/Surveys/survey_section.dart';
import 'package:eservices/config/theme/app_colors.dart';

import '../../controllers/api_controller.dart';

// ignore: must_be_immutable
class SectionsOfServey extends StatelessWidget {
  late List<SurveySection> surveySections;
  late int surveyID, surveyPeriodID;
  late String surveyName, surveyDescription;
  final Map<String, dynamic> userData;
  Map<int, dynamic> submit_answers = {};
  List missedTitles = [];

  SectionsOfServey({
    Key? key,
    required this.surveySections,
    required this.surveyID,
    required this.surveyName,
    required this.surveyDescription,
    required this.surveyPeriodID,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Positioned(
                top: Get.height * 0.07,
                right: 12.w,
                left: 32.w,
                child: Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: colorPrimary,
                    ),
                    child: Text(
                      surveyName,
                      style: largeTitleStyle.copyWith(color: colorWhite),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: surveyName.length >= 44
                    ? Get.height * 0.08
                    : Get.height * 0.066,
                left: 0.0,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: surveySections.map(
                  (surveySection) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildInnerWidget(surveySection),
                    );
                  },
                ).toList()
                  ..add(Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        padding: 8,
                        fontSize: 18,
                        callBack: () {
                          //Every Answer is one except checkbox many answers
                          //Map<int QuestionID,dynamic answer>
                          //Example: {
                          // 1 : also one id if radio or dropdown
                          // 2 : string if input filed
                          // 3 : list of ids if checkbox
                          //}
                          //print(submit_answers.keys); //Questions ids
                          //print(submit_answers.values); // answers ids
                          validate(surveySections: surveySections);
                        },
                        label: 'إجابة'),
                  )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validate({required List<SurveySection> surveySections}) async {
    missedTitles.clear();
    List<Map<String, dynamic>> answers = [];
    int fullLength = 0;
    for (var surveySection in surveySections) {
      fullLength += surveySection.questions.length;
    }
    if (fullLength == submit_answers.keys.length) {
      for (int questionID in submit_answers.keys) {
        if (submit_answers[questionID] == null ||
            submit_answers[questionID] == '') {
          CustomSnackBar.showCustomErrorToast(
            message: 'يجب الإجابه علي جميع الأسئله !',
          );
          for (var section in surveySections) {
            for (var question in section.questions) {
              if (!missedTitles.contains(question['title']) &&
                  question['id'] == questionID) {
                missedTitles.add(question['title']);
              }
              //print(missedTitles);
            }
            return;
          }
        } else {
          for (var section in surveySections) {
            for (var question in section.questions) {
              if (missedTitles.contains(question['title']) &&
                  question['id'] == questionID) {
                missedTitles.remove(question['title']);
              }
            }
          }
        }
        answers.clear();
        submit_answers.forEach((qID, ansID) {
          if (ansID is List) {
            for (var ans in ansID) {
              answers.add({
                "surveyQuestionId": qID,
                "answerValue": ans.toString(),
              });
            }
          } else {
            answers.add({
              "surveyQuestionId": qID,
              "answerValue": ansID.toString(),
            });
          }
        });
      }
      Map<String, dynamic> body = {
        "surveyId": surveyID,
        "surveyPeriodId": surveyPeriodID,
        "nid": userData['NID'].toString(),
        'targetTypeId': userData['TargetTypeId'],
        'gender': userData['Gender'],
        'collegeCode': userData['CollegeCode'].toString(),
        'sectionCode': userData['SectionCode'].toString(),
        "deviceType": 2,
        "userAnswerDVM": answers,
      };
      APIController controller = APIController(
          url: "https://mobileapi.nbu.edu.sa/api/SurveyExternalApi/PostAnswer",
          requestType: RequestType.post,
          body: body);
      await showLoadingOverlay(asyncFunction: () async {
        await controller.getData();
      });
      if (controller.data == null) {
        MySharedPref.setSurveyCount(MySharedPref.getSurveyCount() - 1);
        Get.toNamed(Routes.HOME);

        CustomSnackBar.showCustomSnackBar(
            title: 'نجاح', message: 'تم الإرسال بنجاح');
      } else {
        CustomSnackBar.showCustomErrorToast(
          message: 'خطآ في الإتصال بالإنترنت',
        );
      }
    } else {
      CustomSnackBar.showCustomErrorToast(
        message: 'You have to answer all Questions!',
      );
      for (var section in surveySections) {
        for (var question in section.questions) {
          if (!submit_answers.containsKey(question['id'])) {
            if (!missedTitles.contains(question['title'])) {
              missedTitles.add(question['title']);
            }
          }
        }
      }
    }
  }

  Widget dropDownlist({required List answers, required int questionID}) {
    return GetBuilder<DropDownController>(
      tag: questionID.toString(),
      init: DropDownController(),
      builder: (controller) => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: answers.asMap().entries.map<DropdownMenuItem<String>>((entry) {
            return DropdownMenuItem<String>(
              value: entry.key.toString(),
              child: Text(
                entry.value['title'],
                style: TextStyle(fontSize: 12.sp, overflow: TextOverflow.fade),
              ),
            );
          }).toList(),
          value: controller.currentValue,
          hint: Text('اختر اجابة'),
          onChanged: (selectedValue) {
            controller.changeValue(selectedValue!);
            int selectedIndex = int.parse(selectedValue);
            submit_answers[questionID] = answers[selectedIndex]['id'];
          },
        ),
      ),
    );
  }

  List<Widget> radioButtonlist(
      {required List answers, required int questionID}) {
    return answers
        .map(
          (answer) => GetBuilder<RadioController>(
            init: RadioController(),
            tag: questionID.toString(),
            builder: (controller) => RadioListTile<String>(
              value: answer['title'],
              contentPadding: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
              groupValue: controller.currentValue,
              title: Text(answer['title']),
              onChanged: (String? value) {
                controller.changeValue(value!);
                submit_answers.addAll({
                  questionID: answers[answers.indexOf(answer)]['id'],
                });
              },
            ),
          ),
        )
        .toList();
  }

  Widget buildQuestion({
    required String title,
    required answersWidget,
    required bool isList,
  }) {
    return GetBuilder<ExpandController>(
      init: ExpandController(),
      tag: title,
      builder: (controller) => Card(
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(controller.currentValue ? 0 : 30)),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
          title: Text(
            title,
            style: TextStyle(
                color:
                    missedTitles.contains(title) ? Colors.red : colorPrimary),
          ),
          onExpansionChanged: ((value) {
            controller.changeValue(value);
          }),
          children: isList ? answersWidget : [answersWidget],
        ),
      ),
    );
  }

  Widget _buildInnerWidget(SurveySection surveySection) {
    return Stack(
      children: [
        Column(
          children: surveySection.questions.map((question) {
            switch (question['questionTypeId']) {
              case 1:
                return buildQuestion(
                    title: question['title'],
                    isList: true,
                    answersWidget: (question['answers'] as List)
                        .map(
                          (ans) => CheckBoxList(
                            answer: ans,
                            questionID: ans['surveyQuestionId'],
                          ),
                        )
                        .toList());
              case 2:
                return buildQuestion(
                  title: question['title'],
                  isList: true,
                  answersWidget: radioButtonlist(
                    answers: question['answers'],
                    questionID: question['id'],
                  ),
                );
              case 3:
                return buildQuestion(
                  title: question['title'],
                  isList: false,
                  answersWidget: GetBuilder<TextFieldController>(
                    init: TextFieldController(),
                    tag: question['title'],
                    builder: (control) => TextFormField(
                      textInputAction: TextInputAction.done,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: control.controller,
                      onChanged: (value) {
                        control.changeValue(value);
                        submit_answers.addAll({
                          question['id']: control.controller.text,
                        });
                      },
                      decoration: InputDecoration(
                        label: Text('اكتب اجابتك هنا ...'),
                      ),
                    ),
                  ),
                );
              case 4:
                return buildQuestion(
                  title: question['title'],
                  isList: false,
                  answersWidget: dropDownlist(
                    answers: question['answers'],
                    questionID: question['id'],
                  ),
                );
              default:
                //print(question);
                return Container();
            }
          }).toList(),
        ),
        Center(child: Text(surveySection.name)),
      ],
    );
  }

  Widget CheckBoxList(
      {Key? key, required dynamic answer, required int questionID}) {
    return GetBuilder<CheckboxController>(
      init: CheckboxController(),
      tag: answer['title'],
      builder: (control) => CheckboxListTile(
        value: control.currentValue,
        title: Text(answer['title']),
        onChanged: (value) {
          if (value!) {
            if (submit_answers[questionID] == null) {
              submit_answers.addAll({
                questionID: [],
              });
            }
            submit_answers[questionID].add(answer['id']);
          } else {
            submit_answers[questionID].remove(answer['id']);
            if (submit_answers[questionID].isEmpty) {
              submit_answers.remove(questionID);
            }
          }
          control.changeValue(value);

          //print('answersID: ${submit_answers[questionID]}');
          //print('submit_answers: $submit_answers');
        },
      ),
    );
  }
}

class DropDownController extends GetxController {
  String? currentValue;

  void changeValue(String newValue) {
    currentValue = newValue;
    update();
  }
}

class RadioController extends GetxController {
  String? currentValue;

  void changeValue(String newValue) {
    currentValue = newValue;
    update();
  }
}

class ExpandController extends GetxController {
  bool currentValue = false;

  void changeValue(bool newValue) {
    currentValue = newValue;
    update();
  }
}

class TextFieldController extends GetxController {
  TextEditingController controller = TextEditingController();
  void changeValue(String newValue) {
    controller.text = newValue;
    update();
  }
}

class CheckboxController extends GetxController {
  bool currentValue = false;

  void changeValue(bool newValue) {
    currentValue = newValue;
    update();
  }
}
