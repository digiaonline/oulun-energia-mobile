import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/views/usage/usage_app_bar.dart';

class UsageSettingsView extends StatelessWidget {
  static String routeName = 'usage_settings_view';

  final Function(MyUsageViews) onChangePage;

  const UsageSettingsView({Key? key, required this.onChangePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: usageAppBar(
          context,
          title: AppLocalizations.of(context)!.usageViewSettings,
          onTap: () => onChangePage(MyUsageViews.main),
        ),
        body: null);
  }
}
