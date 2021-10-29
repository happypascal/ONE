import 'package:flutter/material.dart';

class CustomThemeData {
  static final theme = ThemeData(
    primarySwatch: Colors.blueGrey,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Trebuchet MS',
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Color(0xffD5E9F4),
        fontWeight: FontWeight.w600,
      ),
      headline1: TextStyle(
        color: Color(0xffffffff),
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        color: Color(0xffffffff),
      ),
      headline3: TextStyle(
        color: Color(0xffD5E9F4),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
