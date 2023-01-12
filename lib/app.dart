import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/router/router.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

final messengerKey =
    GlobalKey<ScaffoldMessengerState>(debugLabel: 'messengerKey');

class OEApp extends ConsumerWidget {
  final String appName;

  const OEApp({super.key, required this.appName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: appName,
      scaffoldMessengerKey: messengerKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: defaultTheme,
      routerConfig: router,
    );
  }
}
