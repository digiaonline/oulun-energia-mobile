import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/app.dart';
import 'package:oulun_energia_mobile/flavors.dart';

void main() {
  F.appFlavor = Flavor.DEV;
  runApp(OEApp(appName: F.title));
}
