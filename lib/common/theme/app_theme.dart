import 'package:flutter/material.dart';
import 'package:for_test/common/theme/font.dart';

class AppTheme {

  static const Color whiteColor = Colors.white;
  static const Color greenColor = Colors.green;
  static const Color errorRedColor = Color(0xFFF43528);
  static const Color grayText = Color(0xFF747377);
  static const Color graySneakBarColor = Color(0xFFF3F3F4);
  static const Color grayColor = Color(0xFFB9B9B9);
  static const Color grayTextField = Color(0xFFE6E6E6);
  static const Color activeTextFieldAndButtonColor = Color(0xFF6A4DBA);
  static const Color itemBackground = Color(0xFF2C2E30);
  static const Color emptyProfileBackground = Color(0xffF3F3F3);
  static const Color green = Colors.greenAccent;

  static const Color textColor = Colors.black;


  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.light,
    dialogBackgroundColor: whiteColor,
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontFamily: bold700,
        fontSize: 16,
      ),
    ),
    hintColor: whiteColor,
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: textColor, fontFamily: bold700, fontSize: 32),
      titleMedium: TextStyle(color: textColor, fontFamily: bold700, fontSize: 24),
      bodyMedium: TextStyle(color: textColor, fontFamily: regular400, fontSize: 16),
      bodySmall: TextStyle(color: textColor, fontFamily: medium500, fontSize: 14),
    ),
  );
}
