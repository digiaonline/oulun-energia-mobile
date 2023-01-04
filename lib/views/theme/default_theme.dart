import 'package:flutter/material.dart';

IconThemeData bottomNavigationIconTheme =
    const IconThemeData(color: Colors.white, size: 20);

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
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 1,
    selectedItemColor: iconColorBlue,
    unselectedItemColor: iconColorBlue,
    backgroundColor: Colors.white,
    selectedIconTheme: bottomNavigationIconTheme.copyWith(
      color: Colors.black,
    ),
    unselectedIconTheme:
        bottomNavigationIconTheme.copyWith(color: iconColorBlue),
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
  colorScheme: ColorScheme.fromSwatch().copyWith(primary: iconColorBlue),
);

const Color iconColorBlue = Color(0xFF002B59);
const Color appBarIconColor = Colors.white;
const Color appBarBackgroundColor = Colors.transparent;
