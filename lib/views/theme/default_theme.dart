import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

IconThemeData bottomNavigationIconTheme =
    const IconThemeData(color: Colors.white, size: 20);

TextStyle kFontSize12W400 = const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    fontFamily: "Eina",
    color: Colors.black);

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
  headline4: TextStyle(
      fontSize: 28.0, fontWeight: FontWeight.w600, fontFamily: "Eina"),
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
        shape: const Border.fromBorderSide(BorderSide(
            width: 1.0,
            strokeAlign: StrokeAlign.outside,
            color: tabBorderColor)),
        toolbarHeight: 60,
        elevation: 1,
        backgroundColor: appBarBackgroundColor,
        foregroundColor: iconColorBlue,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: iconColorBlue)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0.0,
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
    radioTheme: const RadioThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: textTheme.headline2?.copyWith(color: Colors.red),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      filled: true,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      hintStyle: textTheme.bodyText1?.copyWith(color: hintTextColor),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: borderColor, width: 1),
      ),
      contentPadding: const EdgeInsets.only(left: 16.0, top: 16.0),
    ),
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity),
      checkColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          return Colors.white;
        },
      ),
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          return Colors.transparent;
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      side: MaterialStateBorderSide.resolveWith(
        (states) => const BorderSide(width: 1.0, color: Colors.white),
      ),
    ),
    dividerColor: const Color(0xFF949494),
    listTileTheme: const ListTileThemeData(horizontalTitleGap: 0));

const Color secondaryActiveButtonColor = Color(0xFF009EB5);
const Color dividerColor = Color(0xFFDFE2EB);
const Color borderColor = Color(0xFF949494);
const Color hintTextColor = Color(0xFF8D8D8D);
const Color containerColor = Color(0xFFF1F0F4);
const Color tabBorderColor = Color(0xFFE0E0E0);
const Color iconColorBlue = Color(0xFF002B59);
const Color iconColorBlack = Color(0xFF002B59);
const Color iconColorBlueLight = Color(0xFF0F5EA6);
const Color appBarIconColor = Colors.white;
const Color appBarBackgroundColor = Colors.transparent;
const Color buttonPrimaryBackground = Color(0xFF009EB5);
const Color ftuNavigationSelected = Color(0xFFFFFFFF);
const Color ftuNavigationUnSelected = Color(0xFF1A4590);
const Color containerTitleColor = Colors.black;
