import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyView {
  static const String routePath = "privacy/:url";
  static const String routeName = "privacy";

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title': AppLocalizations.of(context)!.loginViewPrivacyStatementLink,
      'secondaryAppBar': true,
      'initialExpanded': false,
      'hideAppBar': false,
    };
  }
}
