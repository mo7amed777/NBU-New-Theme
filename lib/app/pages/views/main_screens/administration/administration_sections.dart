import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/app/pages/views/main_screens/administration/ProfM_AlShihri.dart';
import 'package:eservices/app/pages/views/main_screens/administration/University%20President%20Office/PresidentOffice.dart';
import 'package:eservices/app/pages/views/main_screens/administration/University%20President%20Office/members.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Administrations extends StatefulWidget {
  const Administrations({Key? key}) : super(key: key);

  @override
  State<Administrations> createState() => _AdministrationsState();
}

class _AdministrationsState extends State<Administrations> {
  List items = [
    'رئيس الجامعة' ,
    'مكتب رئيس الجامعة',
    'المنسوبون' ,
  ];
  List icons=[
    FontAwesomeIcons.userTie,
    FontAwesomeIcons.peopleRoof,
    FontAwesomeIcons.users,

  ];
  bool multiple = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Appbar(
                title: 'إدارة الجامعة'.tr,
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                crossAxisCount: 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 5,
                shrinkWrap: true,
                childAspectRatio: 16 / 9,
                children: List.generate(
                  items.length,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      columnCount: 1,
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
                                        style: TextStyle(
                                            color: Color(0xff659d43),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18


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
                    ),);
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
      case 'رئيس الجامعة':
        Get.to(ProfM_AlShihri());
        break;
      case 'مكتب رئيس الجامعة':
        Get.to(UniversityPresidentOffice());
        break;
      case 'المنسوبون':
        Get.to(OfficeMembers());
        break;

    }
  }
}
