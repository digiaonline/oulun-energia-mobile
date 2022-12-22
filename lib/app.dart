import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/views/main/main_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class OEApp extends StatelessWidget {
  final String appName;

  const OEApp({super.key, required this.appName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      scaffoldMessengerKey: messengerKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: defaultTheme,
      initialRoute: MainView.routeName,
      routes: {
        MainView.routeName: (context) => MainView(),
      },
    );
  }
}
