import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_send_message_view.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_view.dart';
import 'package:oulun_energia_mobile/views/first_time/first_time_view.dart';
import 'package:oulun_energia_mobile/views/fishway/fish_way.dart';
import 'package:oulun_energia_mobile/views/help/help_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_fault_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_map_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notice_popup_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notices_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_selections_view.dart';
import 'package:oulun_energia_mobile/views/login/forgot_password_view.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/login/privacy_view.dart';
import 'package:oulun_energia_mobile/views/login/register_view.dart';
import 'package:oulun_energia_mobile/views/main/home_view.dart';
import 'package:oulun_energia_mobile/views/newsletter/newsletter_view.dart';
import 'package:oulun_energia_mobile/views/splash_screen.dart';
import 'package:oulun_energia_mobile/views/terms/service_terms.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_selections_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';
import 'package:oulun_energia_mobile/views/user/user_details.dart';
import 'package:oulun_energia_mobile/views/utils/config.dart';
import 'package:oulun_energia_mobile/views/utils/scaffold_navbar.dart';
import 'package:oulun_energia_mobile/views/utils/snackbar.dart';
import 'package:oulun_energia_mobile/views/webview/OEWebView.dart';

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

    if (!userAuthState.loading && loggedInStatus == LoggedInStatus.failed) {
      showSnackbar('Kirjautuminen ep??onnistui!');
    }

    if (state.location == '/splash') {
      if (!userAuthState.loading &&
          userAuthState.loggedInStatus != LoggedInStatus.loggedIn) {
        return FirstTimeView.routePath;
      } else if (userAuthState.loggedInStatus == LoggedInStatus.loggedIn) {
        return HomeView.routePath;
      }
    }

    if (state.location == '/home/login') {
      if (!userAuthState.loading && loggedInStatus == LoggedInStatus.loggedIn) {
        showSnackbar('Kirjautuminen onnistui!');
        return HomeView.routePath;
      }
    }

    if (state.location.startsWith('/home/usage')) {
      if (loggedInStatus == LoggedInStatus.loggedOut) {
        return HomeView.routePath;
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
        ShellRoute(
            routes: <RouteBase>[
              GoRoute(
                name: HomeView.routeName,
                path: HomeView.routePath,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeView();
                },
                routes: [
                  GoRoute(
                      path: NewsletterView.routePath,
                      name: NewsletterView.routeName,
                      builder: (BuildContext context, GoRouterState state) {
                        return const NewsletterView();
                      }),
                  GoRoute(
                      path: UserDetailsView.routePath,
                      name: UserDetailsView.routeName,
                      builder: (BuildContext context, GoRouterState state) {
                        return const UserDetailsView();
                      }),
                  GoRoute(
                    path: FishWay.routePath,
                    name: FishWay.routeName,
                    builder: (BuildContext context, GoRouterState state) {
                      return const FishWay();
                    },
                  ),
                  GoRoute(
                    path: HelpView.routePath,
                    name: HelpView.routeName,
                    builder: (BuildContext context, GoRouterState state) {
                      return const HelpView();
                    },
                  ),
                  GoRoute(
                      path: LoginView.routePath,
                      name: LoginView.routeName,
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return CustomTransitionPage(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: const LoginView(),
                        );
                      },
                      routes: [
                        GoRoute(
                          path: PrivacyView.routePath,
                          name: PrivacyView.routeName,
                          builder: (BuildContext context, GoRouterState state) {
                            return OEWebView();
                          },
                        ),
                        GoRoute(
                          path: RegisterView.routePath,
                          name: RegisterView.routeName,
                          builder: (BuildContext context, GoRouterState state) {
                            return OEWebView();
                          },
                        ),
                        GoRoute(
                          path: ForgotPasswordView.routePath,
                          name: ForgotPasswordView.routeName,
                          builder: (BuildContext context, GoRouterState state) {
                            return OEWebView();
                          },
                        ),
                        GoRoute(
                          path: ServiceTermsView.routePath,
                          name: ServiceTermsView.routeName,
                          builder: (BuildContext context, GoRouterState state) {
                            return const ServiceTermsView();
                          },
                        ),
                      ]),
                  GoRoute(
                      path: ContactUsView.routePath,
                      name: ContactUsView.routeName,
                      builder: (BuildContext context, GoRouterState state) {
                        return const ContactUsView();
                      },
                      routes: [
                        GoRoute(
                          path: ContactUsSendMessageView.routePath,
                          name: ContactUsSendMessageView.routeName,
                          builder: (BuildContext context, GoRouterState state) {
                            return const ContactUsSendMessageView();
                          },
                        ),
                      ]),
                  GoRoute(
                      path: UsageSelectionsView.routePath,
                      name: UsageSelectionsView.routeName,
                      builder: (BuildContext context, GoRouterState state) {
                        return const UsageSelectionsView();
                      },
                      routes: [
                        GoRoute(
                          path: UsageSettingsView.routePath,
                          name: UsageSettingsView.routeName,
                          builder: (BuildContext context, GoRouterState state) {
                            return const UsageSettingsView();
                          },
                        ),
                        GoRoute(
                            path: UsageInfoView.routePath,
                            name: UsageInfoView.routeName,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return const UsageInfoView();
                            }),
                      ]),
                  GoRoute(
                    path: InterruptionsSelectionsView.routePath,
                    name: InterruptionsSelectionsView.routeName,
                    builder: (BuildContext context, GoRouterState state) {
                      return const InterruptionsSelectionsView();
                    },
                    routes: [
                      GoRoute(
                          path: InterruptionsMapView.routePath,
                          name: InterruptionsMapView.routeName,
                          builder: (BuildContext context, GoRouterState state) {
                            return OEWebView();
                          }),
                      GoRoute(
                          path: InterruptionsFaultView.routePath,
                          name: InterruptionsFaultView.routeName,
                          builder: (BuildContext context, GoRouterState state) {
                            return const InterruptionsFaultView();
                          }),
                      GoRoute(
                        path: InterruptionsNoticesView.routePath,
                        name: InterruptionsNoticesView.routeName,
                        builder: (BuildContext context, GoRouterState state) {
                          return const InterruptionsNoticesView();
                        },
                        routes: [
                          GoRoute(
                            path: InterruptionNoticePopupView.routePath,
                            name: InterruptionNoticePopupView.routeName,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return const InterruptionNoticePopupView();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
            builder: (BuildContext context, GoRouterState state, Widget child) {
              var location = getLocation(state);

              Map<String, dynamic> config =
                  Config.getUserRouteSettings(context)[location]!;

              return ScaffoldNavbar(
                  title: config['title'],
                  hideAppBar: config['hideAppBar'],
                  secondaryAppBar: config['secondaryAppBar'],
                  secondaryAppBarStyle: config['secondaryAppBarStyle'],
                  initialExpanded: config['initialExpanded'],
                  hasScrollBody: config['hasScrollBody'],
                  bottomSheet: config['bottomSheet'],
                  onTapHelp: config['onTapHelp'],
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

String getLocation(GoRouterState state) {
  var locations = state.location
      .split('/')
      .where((element) =>
          !element.contains('http') &&
          element.isNotEmpty &&
          double.tryParse(element) == null)
      .toList();

  if (locations.isEmpty) {
    return HomeView.routeName;
  }
  return locations[locations.length - 1];
}

final routerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(() {
  return RouterNotifier();
});
