import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/administration/University%20President%20Office/President%20Subordinating%20Units/Advisors%20Office.dart';
import 'package:eservices/app/pages/views/main_screens/administration/University%20President%20Office/President%20Subordinating%20Units/General%20Administration.dart';
import 'package:eservices/app/pages/views/main_screens/administration/University%20President%20Office/President%20Subordinating%20Units/Project%20Management%20Office.dart';
import 'package:eservices/app/pages/views/main_screens/administration/University%20President%20Office/President%20Subordinating%20Units/Risk%20Management%20Unit.dart';
import 'package:eservices/app/pages/views/main_screens/administration/University%20President%20Office/President%20Subordinating%20Units/Self-generated%20Monitoring.dart';
import 'package:eservices/app/pages/views/main_screens/administration/University%20President%20Office/President%20Subordinating%20Units/decision_support.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PresidentSubordinatingUnits extends StatefulWidget {
  const PresidentSubordinatingUnits({Key? key}) : super(key: key);

  @override
  State<PresidentSubordinatingUnits> createState() =>
      _PresidentSubordinatingUnitsState();
}

class _PresidentSubordinatingUnitsState
    extends State<PresidentSubordinatingUnits> {
  List icons=[
    FontAwesomeIcons.userTie,
    FontAwesomeIcons.bookOpen,
    FontAwesomeIcons.users,
    FontAwesomeIcons.triangleExclamation,
    FontAwesomeIcons.layerGroup,
    FontAwesomeIcons.check,
  ];

  List items = [
    'مكتب المستشارون',
    'مكتب إدارة المشاريع',
    'وحدة مراقبة الموارد الذاتية',
    'وحدة إدارة المخاطر',
    'الإدارة العامة للتخطيط الإستراتيجي وتحقيق الرؤية',
    'وحدة دعم اتخاذ القرار',
  ];
  bool multiple = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: Appbar(
                title: 'الوحدات التابعة لرئيس الجامعة',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                shrinkWrap: true,
                childAspectRatio: 1,
                children: List.generate(
                  items.length,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              child: Card(

                                elevation: 0.0,
                                margin: EdgeInsets.all(8.sp),
                                color: Colors.white,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)
                                    // Adjust the bottom right border radius
                                  ),
                                  side: BorderSide(
                                    color: Color(0xff337c3d), // Change this color to the desired border color
                                    // Change this value to the desired border width
                                  ),

                                ),

                                shadowColor: Color(0xff9ab83d),

                                child: InkWell(
                                  onTap: () => callBack(items[index]!),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset('assets/images/pettrenback.png',height: Get.height,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          Container(
                                            width: 75,
                                            height: 75,

                                            decoration: BoxDecoration(

                                              border: Border.all(
                                                color: Color(0xff9ab83d), // Change this color to the desired border color
                                                width: 1.9, // Change this value to the desired border width
                                              ),

                                              borderRadius: BorderRadius.circular(50.0),), // Optional: Add border radius for rounded corners
                                            child: Icon(
                                              icons[index]!,
                                              size: 28.sp,
                                              color: Color(0xff217445),

                                            ),),

                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            items[index]!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xff659d43),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp


                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void callBack(String key) async {

    switch (key) {
      case 'مكتب المستشارون':
        Get.to(() => AdvisorsOffice(title: 'مكتب المستشارون'));
        break;
      case 'مكتب إدارة المشاريع':
        Get.to(() => ProjectManagementOffice(title: 'مكتب إدارة المشاريع'));
        break;
      case 'وحدة مراقبة الموارد الذاتية':
        Get.to(() => SelfGeneratedResourcesMonitoringUnit(title: 'وحدة مراقبة الموارد الذاتية'));
        break;
      case 'وحدة إدارة المخاطر':
        Get.to(() => RiskManagementUnit(title: 'وحدة إدارة المخاطر'));
        break;
      case 'الإدارة العامة للتخطيط الإستراتيجي وتحقيق الرؤية':
        Get.to(() => GeneralAdministration(title: 'الإدارة العامة للتخطيط الإستراتيجي'));
        break;
      case 'وحدة دعم اتخاذ القرار':
        Get.to(() => DecisionSupport(title: 'وحدة دعم اتخاذ القرار'));
        break;
    }
  }
}
