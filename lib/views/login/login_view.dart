import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/login/forgot_password_view.dart';
import 'package:oulun_energia_mobile/views/login/privacy_view.dart';
import 'package:oulun_energia_mobile/views/login/register_view.dart';
import 'package:oulun_energia_mobile/views/terms/service_terms.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/checkbox_row.dart';
import 'package:oulun_energia_mobile/views/utils/input_box.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class LoginView extends ConsumerWidget {
  static const String routePath = "login";
  static const String routeName = "login";

  const LoginView({super.key});

  static Map<String, dynamic> getSettings() {
    return {
      'title': '',
      'secondaryAppBar': false,
      'secondaryAppBarStyle': false,
      'initialExpanded': false,
      'hasScrollBody': false,
      'hideAppBar': true,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController =
        TextEditingController(text: "mira.juola@icloud.com");
    final passwordController = TextEditingController(text: "Vaihda123456");
    var userAuth = ref.watch(loginProvider);
    var loginNotifier = ref.read(loginProvider.notifier);
    var theme = Theme.of(context);
    var locals = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildMainAppBar(context,
              leading: null, foregroundColor: Colors.white),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: Sizes.marginViewBorder,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locals.loginViewLogin,
                      style: theme.textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InputBox(
                            hintText: locals.loginViewUsernameHint,
                            title: locals.loginViewUsername,
                            keyboardType: TextInputType.text,
                            multiline: false,
                            controller: usernameController,
                            textStyle:
                                defaultTheme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            )),
                        InputBox(
                          hintText: locals.loginViewPasswordHint,
                          title: locals.loginViewPassword,
                          keyboardType: TextInputType.visiblePassword,
                          multiline: false,
                          obscureText: true,
                          controller: passwordController,
                          textStyle:
                              defaultTheme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                        ),
                        CheckboxRow(
                          color: Colors.white,
                          value: userAuth.rememberSignIn,
                          onChanged: (value) =>
                              loginNotifier.rememberSignIn(value ?? false),
                          child: Text(
                            locals.loginViewRememberSignIn,
                            style: defaultTheme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                        CheckboxRow(
                          color: Colors.white,
                          value: userAuth.termsAccepted,
                          onChanged: (value) =>
                              loginNotifier.acceptTerms(value ?? false),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: locals.loginViewTermsLinkPrefix,
                                  style: defaultTheme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                  children: [
                                    TextSpan(
                                      text: locals.loginViewTermsLink,
                                      style: defaultTheme.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: Colors.white,
                                        decorationColor: Colors.white,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ).toClickable(
                                  onTap: () => _openTermsLink(context)),
                              Text(
                                locals.loginViewPrivacyStatementLink,
                                style:
                                    defaultTheme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  decorationColor: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ).toClickable(
                                  onTap: () => _openPrivacyStatement(context)),
                            ],
                          ),
                        ),
                        userAuth.loading
                            ? const Center(child: CircularProgressIndicator())
                            : TextButton(
                                onPressed: userAuth.termsAccepted
                                    ? () => _doLogin(
                                        ref,
                                        usernameController.text,
                                        passwordController.text,
                                        userAuth.rememberSignIn)
                                    : null,
                                child: Text(
                                  locals.loginViewLoginButton,
                                  style: defaultTheme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                              ).toButton(enabled: userAuth.termsAccepted)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locals.loginViewForgotPasswordLink,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            decorationColor: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ).toClickable(
                            onTap: () => _openForgotPassword(context)),
                        const SizedBox(
                          height: Sizes.marginViewBorderSize,
                        ),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: locals.loginViewRegisterLinkPrefix,
                            style: defaultTheme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                            children: [
                              TextSpan(
                                text: locals.loginViewRegisterLink,
                                style:
                                    defaultTheme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  decorationColor: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ).toClickable(onTap: () => _openRegistering(context)),
                      ],
                    ),
                  ]),
            ),
          ),
        ],
      ).withBackground().withWillPopScope(context),
    );
  }

  void _doLogin(
      WidgetRef ref, String username, String password, bool rememberSignIn) {
    var loginProviderNotifier = ref.read(loginProvider.notifier);
    loginProviderNotifier.login(username, password, rememberSignIn);
  }

  void _openRegistering(BuildContext context) {
    context.goNamed(RegisterView.routeName, params: {
      "url": "https://www.energiatili.fi/eServices/Online/RegisterIndex"
    });
  }

  void _openForgotPassword(BuildContext context) {
    context.goNamed(ForgotPasswordView.routeName, params: {
      "url": "https://www.energiatili.fi/eServices/Online/ForgotPassword"
    });
  }

  void _openPrivacyStatement(BuildContext context) {
    context.goNamed(PrivacyView.routeName, params: {
      "url":
          "https://www.oulunenergia.fi/tietosuojaselosteet/tietosuojaseloste-asiakkaille/"
    });
  }

  void _openTermsLink(BuildContext context) {
    context.goNamed(ServiceTermsView.routeName);
  }
}
