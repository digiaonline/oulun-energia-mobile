import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

IconThemeData bottomNavigationIconTheme =
    const IconThemeData(color: Colors.white, size: 20);

TextTheme textTheme = const TextTheme(
  bodyText2: TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Eina"),
  bodyText1: TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, fontFamily: "Eina"),
  headline1: TextStyle(
      fontSize: 32.0, fontWeight: FontWeight.w600, fontFamily: "Eina"),
  headline2: TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w600, fontFamily: "Eina"),
);

IconThemeData appBarIconTheme =
    const IconThemeData(size: 20, color: appBarIconColor);
IconThemeData appBarIconThemeSecondary =
    const IconThemeData(size: 20, color: iconColorBlue);

ThemeData defaultTheme = ThemeData(
  appBarTheme: AppBarTheme(
      toolbarTextStyle: textTheme.headline2,
      titleTextStyle: textTheme.headline2,
      iconTheme: appBarIconTheme,
      toolbarHeight: 60,
      elevation: 2,
      shadowColor: iconColorBlue,
      backgroundColor: appBarBackgroundColor,
      foregroundColor: iconColorBlue,
      surfaceTintColor: Colors.white,
      centerTitle: true,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: iconColorBlue)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 4,
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
