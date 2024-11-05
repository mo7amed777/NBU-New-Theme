import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eservices/config/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpandedTile extends StatefulWidget {
  final String mainTitle;
  final String? title;
  final List<String>? TwoItemsRow;
  final Widget? trailing, leading;
  final String? CourseDate;
  final Function? onEyeTapped;
  final bool? expanded;
  const ExpandedTile(
      {Key? key,
      required this.mainTitle,
      this.title,
      this.TwoItemsRow,
      this.trailing,
      this.leading,
      this.onEyeTapped,
      this.CourseDate,
      this.expanded = false})
      : super(key: key);

  @override
  State<ExpandedTile> createState() => _ExpandedTileState();
}

class _ExpandedTileState extends State<ExpandedTile> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.sp),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(expanded ? 10 : 30)),
      child: ExpansionTile(
          backgroundColor: Colors.white,
          trailing: Icon(
            FontAwesomeIcons.circleArrowDown,
            size: 17,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(30),
          ),
          iconColor: Color(0xff659d43),
          collapsedIconColor: Color(0xff0a3456),
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.mainTitle.length < 30
                      ? widget.mainTitle
                      : "${widget.mainTitle.substring(0, 30)}..",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colorPrimary,
                    fontSize: widget.mainTitle.length > 30 ? 9.sp : 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.CourseDate ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colorBlackLight,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          initiallyExpanded: expanded,
          onExpansionChanged: ((value) {
            setState(() {
              expanded = value;
            });
          }),
          children: [
            ListTile(
              trailing: widget.trailing,
              leading: widget.leading,
              onTap: () {
                if (widget.onEyeTapped != null) widget.onEyeTapped!();
              },
              title: Text(
                widget.title ?? '',
                style: TextStyle(
                  color: colorLightGreen,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.fade,
                  fontSize: 10.sp,
                ),
              ),
              subtitle: widget.TwoItemsRow == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(widget.TwoItemsRow?.first ?? '',
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp)),
                            SizedBox(width: 8.w),
                            Text(widget.TwoItemsRow?.last ?? '',
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp)),
                          ],
                        ),
                      ),
                    ),
            ),
          ]),
    );
  }
}
