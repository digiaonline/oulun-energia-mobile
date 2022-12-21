import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/main.dart';
import 'app.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.STAGING;
  runApp(const MyApp());
}
