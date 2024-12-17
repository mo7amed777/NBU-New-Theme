import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eservices/config/theme/app_colors.dart';

class InputField extends StatefulWidget {
  final String hint;
  final bool obsecured;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final int maxLines;
  final bool validate;
  const InputField(
      {Key? key,
      required this.hint,
      required this.controller,
      this.obsecured = false,
      this.validate = false,
      this.maxLines = 1,
      this.keyboardType})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

bool show = true;

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Container(
        height: 37.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: colorPrimaryLight,
          ),
        ),
        child: TextFormField(
          obscureText: !widget.obsecured ? false : show,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          maxLines: widget.maxLines,
          controller: widget.controller,
          validator: widget.validate
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'هذا الحقل مطلوب *';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: TextStyle(
                fontWeight:
                    widget.obsecured ? FontWeight.bold : FontWeight.normal),
            contentPadding:
                EdgeInsets.only(right: 8.w, top: widget.validate ? 12.h : 2.h),
            suffixIcon: !widget.obsecured
                ? SizedBox(
                    height: 1,
                    width: 1,
                  )
                : InkWell(
                    onTap: (() {
                      setState(() {
                        if (show) {
                          show = !show;
                        } else {
                          show = !show;
                        }
                      });
                    }),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        show ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                        size: 20.sp,
                        color: Color(0xffE4E6E2),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
