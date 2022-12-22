import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/app.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.STAGING;
  runApp(OEApp(appName: F.title));
}
