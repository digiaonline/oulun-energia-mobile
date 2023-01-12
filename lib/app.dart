import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/first_time/first_time_view.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/main/home_view.dart';
import 'package:oulun_energia_mobile/views/main/main_view.dart';
import 'package:oulun_energia_mobile/views/splash_screen.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_selections_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';
import 'package:oulun_energia_mobile/views/utils/scaffold_navbar.dart';
import 'package:oulun_energia_mobile/views/utils/snackbar.dart';

final messengerKey =
    GlobalKey<ScaffoldMessengerState>(debugLabel: 'messengerKey');
final _mainNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'mainKey');

GoRouter? _previousRouter;

final routerProvider = Provider<GoRouter>((ref) {
  UserAuthState userAuthState = ref.watch(loginProvider);

  return _previousRouter = GoRouter(
    initialLocation: _previousRouter?.location,
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) {
      LoggedInStatus loggedInStatus = userAuthState.loggedInStatus;
      if (loggedInStatus == LoggedInStatus.notInitialized) {
        // Change back to FirstTimeView.routePath;
        return UsageSelectionsView.routePath;
      }

      if (state.location == '/login') {
        if (!userAuthState.loading &&
            loggedInStatus == LoggedInStatus.loggedIn) {
          showSnackbar('Jee! Kirjauduit sisään!');
          return MainView.routePath;
        }

        if (!userAuthState.loading && loggedInStatus == LoggedInStatus.failed) {
          showSnackbar('Kirjautuminen epäonnistui!');
        }
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
          path: SplashScreen.routePath,
          name: SplashScreen.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          }),
      GoRoute(
          path: FirstTimeView.routePath,
          name: FirstTimeView.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const FirstTimeView();
          }),
      GoRoute(
        path: LoginView.routePath,
        name: LoginView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      ShellRoute(
          routes: <RouteBase>[
            GoRoute(
              name: HomeView.routeName,
              path: HomeView.routePath,
              builder: (BuildContext context, GoRouterState state) {
                return const HomeView();
              },
            ),
          ],
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return ScaffoldNavbar(
                title: '',
                routePath: '',
                initialExpanded: false,
                secondaryAppBar: false,
                currentIndex: 0,
                child: child);
          }),
      ShellRoute(
          routes: <RouteBase>[
            GoRoute(
                path: UsageSelectionsView.routePath,
                name: UsageSelectionsView.routeName,
                builder: (BuildContext context, GoRouterState state) {
                  return const UsageSelectionsView();
                }),
            GoRoute(
                path: UsageSettingsView.routePath,
                name: UsageSettingsView.routeName,
                builder: (BuildContext context, GoRouterState state) {
                  return const UsageSettingsView();
                }),
            GoRoute(
                path: UsageInfoView.routePath,
                name: UsageInfoView.routeName,
                builder: (BuildContext context, GoRouterState state) {
                  return const UsageInfoView();
                })
          ],
          builder: (BuildContext context, GoRouterState state, Widget child) {
            var locals = AppLocalizations.of(context)!;
            String title = '';
            bool secondaryAppBar = true;

            print(state.location);

            switch (state.location) {
              case '/usage/settings':
                title = locals.usageViewSettings;
                break;
              case '/usage/info':
                title = locals.usageViewUsageInfo;
                break;
              default:
                title = '';
                secondaryAppBar = false;
                break;
            }
            return ScaffoldNavbar(
                title: title,
                routePath: UsageSelectionsView.routePath,
                currentIndex: 1,
                secondaryAppBar: secondaryAppBar,
                initialExpanded: true,
                child: child);
          }),
    ],
  );
});

class OEApp extends ConsumerWidget {
  final String appName;

  OEApp({super.key, required this.appName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var router = ref.watch(routerProvider);
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
