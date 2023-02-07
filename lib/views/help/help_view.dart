import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/content.dart';

class HelpView extends StatelessWidget {
  static const String routePath = "help_view";
  static const String routeName = "help_view";

  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;
    return IntrinsicHeight(
      child: Content(
          title: locals.homeViewHelp,
          text: locals.helpDescription,
          children: [
            Text(
              locals.helpSignInTitle,
              style: textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: Sizes.itemDefaultSpacing,
            ),
            Text(
              locals.helpSignInDescription,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(
              height: Sizes.itemDefaultSpacing,
            ),
            Text(
              locals.usageViewMyUsage,
              style: textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: Sizes.itemDefaultSpacing,
            ),
            Text(
              locals.helpEnergyConsumptionDescription,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(
              height: Sizes.itemDefaultSpacing,
            ),
            Text(
              locals.helpEnergyConsumptionUsagePlaceTitle,
              style: textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: Sizes.itemDefaultSpacing,
            ),
            Text(
              locals.helpEnergyConsumptionUsagePlaceDescription,
              style: textTheme.bodyLarge,
            ),
          ]),
    );
  }

  static Map<String, dynamic> getSettings() {
    return {
      'title': '',
      'secondaryAppBar': false,
      'secondaryAppBarStyle': true,
      'initialExpanded': true,
      'hideAppBar': false,
      'hasScrollBody': true,
    };
  }
}
