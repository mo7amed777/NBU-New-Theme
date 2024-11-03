import 'package:eservices/app/pages/views/main_screens/About%20the%20University/ContactUS.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/FactsandFigures.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/UniversityCouncil.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/About%20the%20University/VisionandGoals.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MoreAboutTheUniversity extends StatefulWidget {
  const MoreAboutTheUniversity({Key? key}) : super(key: key);

  @override
  State<MoreAboutTheUniversity> createState() => _MoreAboutTheUniversityState();
}

class _MoreAboutTheUniversityState extends State<MoreAboutTheUniversity> {

  List icons=[
    FontAwesomeIcons.eye,
    FontAwesomeIcons.peopleRoof,
    FontAwesomeIcons.chartLine,
    FontAwesomeIcons.phone,

  ];
  List items = [
    'الرؤية والرسالة والأهداف',
    'مجلس الجامعة',
    'المرصد الجامعي',
    'اتصل بنا',
  ];
  bool multiple = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Appbar(
                title: 'عن الجامعة',
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                                      Image.asset('assets/images/pettrenback.png',height: Get.height,fit: BoxFit.fill,),
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
      case 'الرؤية والرسالة والأهداف':
        Get.to(() => VisionandGoals(title: 'الرؤية والرسالة والأهداف'));
        break;
      case 'مجلس الجامعة':
        Get.to(() => UniversityCouncil(title: 'مجلس الجامعة'));
        break;
      case 'المرصد الجامعي':
        Get.to(() => FactsandFigures(title: 'المرصد الجامعي'));
        break;
      case 'اتصل بنا':
        Get.to(() => ContactUS());
        break;
    }
  }
}
