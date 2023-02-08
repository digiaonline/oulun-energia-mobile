import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_selections_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/content.dart';
import 'package:oulun_energia_mobile/views/utils/send_message_form.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class InterruptionsFaultView extends StatelessWidget {
  static const String routePath = 'fault';
  static const String routeName = 'fault';
  const InterruptionsFaultView({super.key});

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title':
          AppLocalizations.of(context)?.interruptionsViewFault ?? 'No title',
      'secondaryAppBar': true,
      'initialExpanded': true,
      'hideAppBar': false,
    };
  }

  void onSubmit(Map<String, dynamic> formState, BuildContext context) {
    // TODO Submit
    // TODO Show success message
    context.goNamed(InterruptionsSelectionsView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;

    return Content(
        title: locals.interruptionsViewFaultTitle,
        text: locals.interruptionsViewFaultText,
        children: [
          const FaultServiceInfo(),
          const SizedBox(height: 32.0),
          SendMessageForm(
            onSubmit: onSubmit,
          ),
          const SizedBox(height: Sizes.inputMargin)
        ]).withBackgroundColor(Colors.white).withWillPopScope(context);
  }
}

class FaultServiceInfo extends StatelessWidget {
  const FaultServiceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      width: double.infinity,
      height: 104,
      color: const Color(0xFF1360A8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    locals.interruptionsViewFaultElectric,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () async => launchUrl(Uri.parse('tel:0855843222')),
                  child: Text(
                    '08 5584 3222',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      height: 1.48,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              'assets/icons/support_agent.svg',
              width: Sizes.bannerIconSize,
              height: Sizes.bannerIconSize,
              color: appBarIconColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(locals.interruptionsViewFaultHeat,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
                GestureDetector(
                  onTap: () async => launchUrl(Uri.parse('tel:0855843425')),
                  child: Text(
                    '08 5584 3425',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      height: 1.48,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
