import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView {
  static const String routePath = "register/:url";
  static const String routeName = "register";

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title': AppLocalizations.of(context)!.registerPageTitle,
      'secondaryAppBar': true,
      'initialExpanded': false,
      'hideAppBar': false,
    };
  }
}
