import 'package:eservices/app/components/custom_row.dart';
import 'package:eservices/app/components/details_dialog.dart';
import 'package:eservices/app/components/mycard.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eservices/app/components/expandTile.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/data/models/covenant.dart';
import 'package:eservices/app/pages/views/hr/courses.dart';
import 'package:eservices/config/theme/app_colors.dart';

class Covenants extends StatelessWidget {
  const Covenants({Key? key, required this.covenants}) : super(key: key);

  final List covenants;

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
                child: covenants.isEmpty
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
                            'لا يوجد لديك عهد',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: covenants.map(((cove) {
                        Covenant covenant = Covenant.fromJson(cove);
                        return MyCard(
                          title: covenant.itemName ?? '',
                          desc: covenant.itemNumber ?? '',
                          icon: FontAwesomeIcons.chair,
                          onTap: () => showDetails(
                            title: covenant.itemName ?? '',
                            rows: [
                              CustomRow(
                                title: ' رقم الصنف: ',
                                trailing: covenant.itemNumber!,
                              ),
                              CustomRow(
                                title: ' اسم الصنف: ',
                                trailing: covenant.itemName!,
                              ),
                              CustomRow(
                                title: ' الكمية: ',
                                trailing: covenant.itemsCount.toString(),
                              ),
                              CustomRow(
                                title: ' الوحدة: ',
                                trailing: covenant.itemUnitName!,
                              ),
                            ],
                          ),
                          subTitle: covenant.itemUnitName ?? '',
                        );
                      })).toList())),
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
                  'كشف العهد',
                  style: largeTitleStyle.copyWith(color: colorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
