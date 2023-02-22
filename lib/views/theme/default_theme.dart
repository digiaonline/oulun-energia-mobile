import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

IconThemeData bottomNavigationIconTheme =
    const IconThemeData(color: Colors.white, size: 20);

TextStyle kFontSize12W400 = const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    fontFamily: "Eina",
    color: Colors.black);

TextStyle popupMenuStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    fontFamily: "Eina",
    color: popupMenuItemColor);

TextTheme textTheme = const TextTheme(
    bodySmall: TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w700, fontFamily: "Eina"),
    bodyMedium: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, fontFamily: "Eina"),
    bodyLarge: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: "Eina"),
    displayLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.w400, fontFamily: "Eina"),
    displayMedium: TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w400, fontFamily: "Eina"),
    displaySmall: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Eina"),
    headlineMedium: TextStyle(
        fontSize: 28.0, fontWeight: FontWeight.w600, fontFamily: "Eina"),
    headlineLarge: TextStyle(
        fontSize: 42.0, fontWeight: FontWeight.w600, fontFamily: "Eina"));

TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStatePropertyAll(textTheme.bodySmall),
    backgroundColor: const MaterialStatePropertyAll(buttonNavigation),
  ),
);

ButtonThemeData buttonPrimaryTheme = ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide.none,
    ),
    colorScheme: ColorScheme.fromSwatch(backgroundColor: buttonNavigation));

ButtonStyle secondaryButtonStyle = ButtonStyle(
  textStyle: MaterialStatePropertyAll(
      textTheme.bodyMedium?.copyWith(color: buttonNavigation)),
  backgroundColor: const MaterialStatePropertyAll(buttonSecondary),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: buttonNavigation, width: 1),
    ),
  ),
);

ButtonStyle primaryButtonStyle = secondaryButtonStyle.copyWith(
  textStyle: MaterialStatePropertyAll(
      textTheme.bodyMedium?.copyWith(color: buttonSecondary)),
  backgroundColor: const MaterialStatePropertyAll(buttonPrimary),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

IconThemeData appBarIconTheme =
    const IconThemeData(size: 20, color: appBarIconColor);
IconThemeData appBarIconThemeSecondary =
    const IconThemeData(size: 20, color: iconColorBlue);

ThemeData defaultTheme = ThemeData(
    snackBarTheme: SnackBarThemeData(
        elevation: 1.0,
        showCloseIcon: false,
        backgroundColor: iconColorBlueLight,
        contentTextStyle: textTheme.bodyMedium,
        actionTextColor: Colors.white),
    appBarTheme: AppBarTheme(
        toolbarTextStyle: textTheme.displayMedium,
        titleTextStyle: textTheme.displayMedium,
        iconTheme: appBarIconTheme,
        shape: const Border.fromBorderSide(BorderSide(
            width: 1.0,
            strokeAlign: BorderSide.strokeAlignOutside,
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
      elevation: 0.1,
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
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0.0,
      backgroundColor: iconColorBlueLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
    fontFamily: 'Eina',
    useMaterial3: true,
    buttonTheme: buttonPrimaryTheme,
    textButtonTheme: textButtonTheme,
    textTheme: textTheme,
    iconTheme: const IconThemeData(color: Colors.white, size: 40),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: buttonSecondary,
        secondary: buttonNavigation,
        background: buttonSecondary),
    radioTheme: const RadioThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: textTheme.displayMedium?.copyWith(color: Colors.red),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      filled: true,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      hintStyle: textTheme.bodyLarge?.copyWith(color: hintTextColor),
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
      checkColor: const MaterialStatePropertyAll(buttonNavigation),
      fillColor: const MaterialStatePropertyAll(Colors.transparent),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      side: MaterialStateBorderSide.resolveWith(
        (states) => const BorderSide(width: 1.5, color: borderColor),
      ),
    ),
    dividerColor: const Color(0xFF949494),
    listTileTheme: const ListTileThemeData(horizontalTitleGap: 0),
    popupMenuTheme: PopupMenuThemeData(
        textStyle: textTheme.bodyLarge?.copyWith(color: popupMenuItemColor),
        elevation: 1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)))));

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
const Color ftuNavigationSelected = Colors.black;
const Color ftuNavigationUnSelected = Color.fromRGBO(34, 34, 34, 0.2);
const Color containerTitleColor = Colors.black;
const Color popupMenuItemColor = Color(0xFF1C1B1F);
const Color buttonPrimary = iconColorBlueLight;
const Color buttonSecondary = Colors.white;
const Color buttonNavigation = Colors.black;
