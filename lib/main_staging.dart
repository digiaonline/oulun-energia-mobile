import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/app.dart';

import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.staging;
  runApp(ProviderScope(child: OEApp(appName: F.title)));
}
