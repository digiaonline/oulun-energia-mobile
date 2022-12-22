import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(size: 48, color: appBarIconColor),
        toolbarHeight: 60,
        color: appBarBackgroundColor));

const Color appBarIconColor = Colors.black;
const Color appBarBackgroundColor = Colors.white;
