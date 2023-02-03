import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InterruptionsMapView {
  static const String routePath = 'map/:url';
  static const String routeName = 'map';
  static const String targetUrl =
      'https://keskeytyskartta.oulunenergia.fi/OutageMap/';

  static Map<String, dynamic> getSettings(BuildContext context) {
    var isLandscapeMode =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return {
      'title': AppLocalizations.of(context)!.interruptionsViewMap,
      'secondaryAppBar': !isLandscapeMode,
      'secondaryAppBarStyle': true,
      'initialExpanded': !isLandscapeMode,
      'hideAppBar': false,
    };
  }
}
