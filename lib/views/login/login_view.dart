import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/domain/user_auth.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';

import '../utils/snackbar.dart';

class LoginView extends ConsumerWidget {
  static const String routeName = "login_view";
  var usernameController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userAuth = ref.watch(loginProvider);
    if (userAuth.loggedIn != LoggedInStatus.loggedOut) {
      _onLogin(context, userAuth.userAuth);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(children: [
        Text("Username:"),
        TextField(
          maxLines: 1,
          controller: usernameController,
        ),
        Text("Password:"),
        TextField(
          maxLines: 1,
          controller: passwordController,
        ),
        MaterialButton(
          onPressed: () =>
              _doLogin(ref, usernameController.text, passwordController.text),
          child: Text("Login"),
        )
      ]),
    );
  }

  void _doLogin(WidgetRef ref, String username, String password) {
    var loginProviderNotifier = ref.read(loginProvider.notifier);
    loginProviderNotifier.login(username, password);
  }

  void _onLogin(BuildContext context, UserAuth? success) {
    return success != null
        ? loginSuccess(context)
        : showSnackbar("Kirjautuminen epäonnistui!");
  }

  void loginSuccess(BuildContext context) {
    Navigator.of(context).pop();
    showSnackbar("Jee kirjauduit sisään!");
  }
}
