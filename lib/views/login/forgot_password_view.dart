import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordView {
  static const String routePath = "forgot_password/:url";
  static const String routeName = "forgot_password";

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title': AppLocalizations.of(context)!.loginViewForgotPasswordLink,
      'secondaryAppBar': true,
      'initialExpanded': false,
      'hideAppBar': false,
    };
  }
}
