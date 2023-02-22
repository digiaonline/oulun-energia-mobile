import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/core/authentication/authentication.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/utils/snackbar.dart';

handleAppErrors(BuildContext context, WidgetRef ref, Object error) {
  if (error is AuthenticationError) {
    var locals = AppLocalizations.of(context)!;
    switch (error) {
      case AuthenticationError.unauthorized:
        var loginNotifier = ref.read(loginProvider.notifier);
        showSnackbar(locals.errorLoginExpired,
            action: SnackBarAction(
              label: locals.errorLoginExpiredSnackReLogin,
              onPressed: () => loginNotifier.tryReLogin().then((success) {
                if (!success) {
                  context.goNamed(LoginView.routeName);
                }
              }),
            ));
        break;
    }
  }
}
