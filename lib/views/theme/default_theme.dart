import 'package:flutter/material.dart';

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
);

const Color appBarIconColor = Colors.black;
const Color appBarBackgroundColor = Colors.white;
