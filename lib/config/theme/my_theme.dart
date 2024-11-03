import 'package:eservices/config/theme/app_colors.dart';
import 'package:eservices/config/theme/app_styles.dart';
import 'package:flutter/material.dart';

final appThemeData = ThemeData(
  useMaterial3: true,
  fontFamily: 'NeoSans',
  colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
  scaffoldBackgroundColor: colorWhite,
  appBarTheme: const AppBarTheme(titleSpacing: 0),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: colorPrimary,
          textStyle: appTextStyle.copyWith(
              color: colorPrimary, fontSize: 16, fontWeight: FontWeight.bold))),
);
