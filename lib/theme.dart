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
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      headline1: TextStyle(
        color: Color(0xffD5E9F4),
        fontSize: 60.0,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        color: Color(0xffD5E9F4),
        fontSize: 26.0,
      ),
      headline3: TextStyle(
        color: Color(0xffD5E9F4),
        fontSize: 40.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
