import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/providers/app_state.dart';
import 'package:oulun_energia_mobile/views/first_time/first_time_view.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/main/main_view.dart';
import 'package:oulun_energia_mobile/views/splash_screen.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();
final mainNavigatorKey = GlobalKey<NavigatorState>();

class OEApp extends ConsumerWidget {
  final String appName;

  const OEApp({super.key, required this.appName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _checkState(ref);
    return MaterialApp(
      title: appName,
      navigatorKey: mainNavigatorKey,
      scaffoldMessengerKey: messengerKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: defaultTheme,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        FirstTimeView.routeName: (context) => FirstTimeView(),
        MainView.routeName: (context) => const MainView(),
        LoginView.routeName: (context) => LoginView()
      },
    );
  }

  void _checkState(WidgetRef ref) {
    var appState = ref.watch(appStateProvider);
    var routeName = SplashScreen.routeName;
    switch (appState.current) {
      case AppStates.firstTimeView:
        routeName = FirstTimeView.routeName;
        break;
      case AppStates.loginView:
        routeName = LoginView.routeName;
        mainNavigatorKey.currentState?.pushNamed(routeName);
        return;
      case AppStates.mainView:
        routeName = MainView.routeName;
        break;
      case AppStates.notInitialized:
        break;
      default:
        break;
    }
    print("$appName: DEBUG -> $routeName ${appState.current}");
    mainNavigatorKey.currentState
        ?.popUntil((route) => routeName == route.settings.name);

    if (mainNavigatorKey.currentState?.canPop() ?? false) {
      mainNavigatorKey.currentState?.pushReplacementNamed(routeName);
    } else {
      mainNavigatorKey.currentState?.pushNamed(routeName);
    }
  }
}
