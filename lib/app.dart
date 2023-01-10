import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/providers/app_state.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/first_time/first_time_view.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/main/home_view.dart';
import 'package:oulun_energia_mobile/views/main/main_view.dart';
import 'package:oulun_energia_mobile/views/splash_screen.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

final messengerKey =
    GlobalKey<ScaffoldMessengerState>(debugLabel: 'messengerKey');
final _mainNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'mainKey');
final _routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

class OEApp extends ConsumerWidget {
  final String appName;

  OEApp({super.key, required this.appName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: appName,
      scaffoldMessengerKey: messengerKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: defaultTheme,
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: HomeView.routePath,
    routes: <RouteBase>[
      GoRoute(
        path: LoginView.routePath,
        name: LoginView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return LoginView();
        },
      ),
      ShellRoute(
          navigatorKey: _mainNavigatorKey,
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
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  buildMainAppBar(
                    context,
                    foregroundColor: Colors.white,
                    toolbarHeight: defaultTheme.appBarTheme.toolbarHeight,
                    actions: const [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 20.0,
                        ),
                        child: Icon(
                          Icons.face,
                          size: 28.5,
                        ),
                      )
                    ],
                    leading: InkWell(
                      onTap: () => context.go(LoginView.routePath),
                      child: const Icon(Icons.menu),
                    ),
                  ),
                  SliverFillRemaining(child: child),
                ],
              ).withBackground(),
            );
          }),
    ],
  );
}
