import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/domain/user_auth.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/app_state.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

import '../utils/snackbar.dart';

class LoginView extends ConsumerWidget {
  static const String routeName = "login_view";
  var usernameController = TextEditingController(text: "mira.juola@icloud.com");

  var passwordController = TextEditingController(text: "Vaihda123456");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userAuth = ref.watch(loginProvider);
    if (userAuth.loggedIn == LoggedInStatus.loggedIn ||
        userAuth.loggedIn == LoggedInStatus.failed) {
      _onLogin(context, ref, userAuth.userAuth);
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Login",
              style: defaultTheme.textTheme.bodyText1,
            ),
          ),
          SliverFillRemaining(
            child: Container(
              margin: Sizes.marginViewBorder,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username:",
                      style: defaultTheme.textTheme.bodyText1,
                    ),
                    TextField(
                      maxLines: 1,
                      controller: usernameController,
                    ),
                    Text(
                      "Password:",
                      style: defaultTheme.textTheme.bodyText1,
                    ),
                    TextField(
                      maxLines: 1,
                      controller: passwordController,
                    ),
                    TextButton(
                      onPressed: () => _doLogin(ref, usernameController.text,
                          passwordController.text),
                      child: Text(
                        "Login",
                        style: defaultTheme.textTheme.bodyText1,
                      ),
                    ).toButton()
                  ]),
            ),
          ),
        ],
      ).withBackground(),
    );
  }

  void _doLogin(WidgetRef ref, String username, String password) {
    var loginProviderNotifier = ref.read(loginProvider.notifier);
    loginProviderNotifier.login(username, password);
  }

  void _onLogin(BuildContext context, WidgetRef ref, UserAuth? success) {
    return success != null
        ? loginSuccess(context, ref)
        : showSnackbar("Kirjautuminen epäonnistui!");
  }

  void loginSuccess(BuildContext context, WidgetRef ref) {
    ref.read(appStateProvider.notifier).loggedIn();
    showSnackbar("Jee kirjauduit sisään!");
  }
}
