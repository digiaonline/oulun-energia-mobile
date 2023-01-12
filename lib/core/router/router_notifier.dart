import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_view.dart';
import 'package:oulun_energia_mobile/views/first_time/first_time_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_selections_view.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/main/home_view.dart';
import 'package:oulun_energia_mobile/views/splash_screen.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_selections_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';
import 'package:oulun_energia_mobile/views/utils/scaffold_navbar.dart';
import 'package:oulun_energia_mobile/views/utils/snackbar.dart';

/*
    Used Riverpod official example Riverpod + Go Router
    https://github.com/lucavenir/go_router_riverpod/blob/master/complete_example/lib/router/router_notifier.dart
 */
class RouterNotifier extends AutoDisposeAsyncNotifier<void>
    implements Listenable {
  VoidCallback? routerListener;
  late UserAuthState userAuthState;

  @override
  Future<void> build() async {
    // Can add more provider to watch

    userAuthState = ref.watch(loginProvider);

    ref.listenSelf((_, __) {
      // Additional redirection logic goes here

      if (state.isLoading) return;
      routerListener?.call();
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    if (this.state.isLoading || this.state.hasError) return null;

    LoggedInStatus loggedInStatus = userAuthState.loggedInStatus;

    if (state.location == '/splash') {
      if (!userAuthState.loading) {
        return FirstTimeView.routePath;
      }
    }

    if (state.location == '/login') {
      if (!userAuthState.loading && loggedInStatus == LoggedInStatus.loggedIn) {
        showSnackbar('Jee! Kirjauduit sisään!');
        return HomeView.routePath;
      }

      if (!userAuthState.loading && loggedInStatus == LoggedInStatus.failed) {
        showSnackbar('Kirjautuminen epäonnistui!');
      }
    }

    return null;
  }

  List<RouteBase> get routes => <RouteBase>[
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
                  path: UsageInfoView.routePath,
                  name: UsageInfoView.routeName,
                  builder: (BuildContext context, GoRouterState state) {
                    return const UsageInfoView();
                  }),
              GoRoute(
                  path: UsageSettingsView.routePath,
                  name: UsageSettingsView.routeName,
                  builder: (BuildContext context, GoRouterState state) {
                    return const UsageSettingsView();
                  }),
              GoRoute(
                  path: InterruptionsSelectionsView.routePath,
                  name: InterruptionsSelectionsView.routeName,
                  builder: (BuildContext context, GoRouterState state) {
                    return const InterruptionsSelectionsView();
                  }),
              GoRoute(
                  path: ContactUsView.routePath,
                  name: ContactUsView.routeName,
                  builder: (BuildContext context, GoRouterState state) {
                    return const ContactUsView();
                  }),
            ],
            builder: (BuildContext context, GoRouterState state, Widget child) {
              var isLandscapeMode =
                  MediaQuery.of(context).orientation == Orientation.landscape;

              var locals = AppLocalizations.of(context)!;
              String title = '';
              bool secondaryAppBar = true;
              bool initialExpanded = true;
              bool hideAppBar = false;
              int currentIndex = 0;

              switch (state.location) {
                case '/usage/settings':
                  title = locals.usageViewSettings;
                  currentIndex = 1;
                  break;
                case '/usage/info':
                  if (isLandscapeMode) {
                    secondaryAppBar = false;
                    initialExpanded = false;
                    hideAppBar = true;
                  }
                  title = locals.usageViewUsageInfo;
                  currentIndex = 1;
                  break;
                case '/usage':
                  currentIndex = 1;
                  secondaryAppBar = false;
                  break;
                case '/interruptions':
                  currentIndex = 2;
                  secondaryAppBar = false;
                  break;
                case '/contact_us':
                  currentIndex = 3;
                  secondaryAppBar = false;
                  break;
                default:
                  secondaryAppBar = false;
                  break;
              }
              return ScaffoldNavbar(
                  title: title,
                  hideAppBar: hideAppBar,
                  routePath: UsageSelectionsView.routePath,
                  currentIndex: currentIndex,
                  secondaryAppBar: secondaryAppBar,
                  initialExpanded: initialExpanded,
                  child: child);
            }),
      ];

  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}

final routerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(() {
  return RouterNotifier();
});
