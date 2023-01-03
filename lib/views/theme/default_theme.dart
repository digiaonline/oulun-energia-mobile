import 'package:flutter/material.dart';

TextTheme textTheme = const TextTheme(
  bodyText2: TextStyle(
      fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w600),
  bodyText1: TextStyle(
      fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600),
  headline1: TextStyle(
      fontSize: 32.0, color: Colors.white, fontWeight: FontWeight.w600),
  headline2: TextStyle(
      fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w600),
);

ThemeData defaultTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(size: 20, color: appBarIconColor),
    toolbarHeight: 60,
    backgroundColor: appBarBackgroundColor,
    foregroundColor: Colors.black,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    indicatorColor: Color(0xFFF1F0F4),
  ),
  fontFamily: 'Eina',
  useMaterial3: true,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide.none,
    ),
  ),
  textTheme: textTheme,
  iconTheme: const IconThemeData(color: Colors.white, size: 40),
  colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.white),
);

const Color appBarIconColor = Colors.white;
const Color appBarBackgroundColor = Colors.transparent;
