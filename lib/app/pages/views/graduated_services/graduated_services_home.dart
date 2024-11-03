import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/bottom_navbar.dart';
import 'package:eservices/app/data/models/student_event.dart';
import 'package:eservices/app/pages/views/graduated_services/graduated_services.dart';
import 'package:eservices/config/theme/app_colors.dart';

class GraduatedServices extends StatelessWidget {
  final String code;
  final List<Event> invites;
  final List<Event> relInvites;
  final List<Map<String, dynamic>> codes;

  const GraduatedServices(
      {Key? key,
      required this.invites,
      required this.codes,
      required this.relInvites,
      required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<GradServController>(
        init: GradServController(),
        builder: (gradServController) {
          return buildBottomNavBar(
            controller: gradServController,
            firstLabel: 'دعواتى',
            secondlabel: 'دعوات الأقارب',
            thirdLabel: 'أكوادي',
            firstIcon: FontAwesomeIcons.envelope,
            secondIcon: FontAwesomeIcons.peopleGroup,
            thirdIcon: FontAwesomeIcons.barcode,
          );
        },
      ),
      body: GetBuilder<GradServController>(
        init: GradServController(),
        builder: (gradServController) => SingleChildScrollView(
          child: buildService(gradServController.index),
        ),
      ),
    );
  }

  Widget buildService(int index) {
    switch (index) {
      case 0:
        return MyInvites(
          title: 'دعواتى',
          invites: invites,
          relInvites: relInvites,
          codes: codes,
        );

      case 1:
        return MyInvites(
          title: 'دعوات الأقارب',
          invites: invites,
          relInvites: relInvites,
          codes: codes,
        );
      default:
        return MyInvites(
          title: 'أكوادي',
          invites: invites,
          relInvites: relInvites,
          codes: codes,
        );
      // default:
      //   return MyInvites(title: 'العباءة', code: code);
    }
  }
}

class GradServController extends GetxController {
  int index = 0;

  void changeIndex(int newValue) {
    index = newValue;
    update();
  }
}
