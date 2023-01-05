import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

IconThemeData bottomNavigationIconTheme =
    const IconThemeData(color: Colors.white, size: 20);

TextTheme textTheme = const TextTheme(
  bodyText2: TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w400, fontFamily: "Eina"),
  bodyText1: TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: "Eina"),
  headline1: TextStyle(
      fontSize: 32.0, fontWeight: FontWeight.w400, fontFamily: "Eina"),
  headline2: TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w400, fontFamily: "Eina"),
  headline3: TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Eina"),
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
      shadowColor: iconColorBlue,
      backgroundColor: appBarBackgroundColor,
      foregroundColor: iconColorBlue,
      surfaceTintColor: Colors.white,
      centerTitle: true,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: iconColorBlue)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 1,
    unselectedLabelStyle: textTheme.labelMedium,
    selectedLabelStyle: textTheme.labelMedium,
    selectedItemColor: iconColorBlue,
    unselectedItemColor: iconColorBlue,
    backgroundColor: Colors.white,
    selectedIconTheme: bottomNavigationIconTheme.copyWith(
      color: iconColorBlack,
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

const Color secondaryActiveButtonColor = Color(0xFF009EB5);
const Color dividerColor = Color(0xFFDFE2EB);
const Color borderColor = Color(0xFF949494);
const Color iconColorBlue = Color(0xFF002B59);
const Color iconColorBlack = Color(0xFF002B59);
const Color appBarIconColor = Colors.white;
const Color appBarBackgroundColor = Colors.transparent;
