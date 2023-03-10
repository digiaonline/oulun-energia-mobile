import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/flavors.dart';
import 'package:oulun_energia_mobile/views/splash_screen.dart';

import 'router_notifier.dart';

final _key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

// Cache router
final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: _key,
    refreshListenable: notifier,
    debugLogDiagnostics: F.appFlavor == Flavor.dev,
    initialLocation: SplashScreen.routePath,
    routes: notifier.routes,
    redirect: notifier.redirect,
  );
});
