import 'package:eservices/app/pages/views/main_screens/About%20the%20University/University%20Council/appbar.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FactsandFigures extends StatefulWidget {
  final String title;
  const FactsandFigures({required this.title});

  @override
  State<FactsandFigures> createState() => _FactsandFiguresState();
}

class _FactsandFiguresState extends State<FactsandFigures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 6),
            child: Appbar(
              title: 'المرصد الجامعي',
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: [
                card(title: 'الطلاب', number: 71445),
                card(title: 'الكليات', number: 16154),
                card(title: 'الخريجين', number: 26243),
                card(title: 'المنح الخارجية', number: 231),
                card(title: 'أعضاء هيئة التدريس', number: 697),
                card(title: 'أعضاء الكليات', number: 1068),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget card({required String title, required int number}) => Card(
        margin: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: colorLightGreen,
            )),
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorBlackLight,
                      fontSize: 16.sp)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(number.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorPrimary,
                      fontSize: 18.sp)),
            ),
          ],
        ),
      );
}
