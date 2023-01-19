import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/snackbar.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class LoginView extends ConsumerWidget {
  static const String routePath = "/login";
  static const String routeName = "login_view";

  const LoginView({super.key});

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
                      style: theme.textTheme.headline2?.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locals.loginViewUsername,
                          style: defaultTheme.textTheme.bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText: locals.loginViewUsernameHint),
                          maxLines: 1,
                          autofillHints: const [AutofillHints.username],
                          controller: usernameController,
                        ),
                        const SizedBox(
                          height: Sizes.marginViewBorderSize,
                        ),
                        Text(
                          locals.loginViewPassword,
                          style: defaultTheme.textTheme.bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText: locals.loginViewPasswordHint),
                          maxLines: 1,
                          obscureText: true,
                          enableSuggestions: false,
                          autofillHints: const [AutofillHints.password],
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: Sizes.marginViewBorderSize,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: userAuth.rememberSignIn,
                              onChanged: (value) =>
                                  loginNotifier.rememberSignIn(value ?? false),
                            ),
                            Text(
                              locals.loginViewRememberSignIn,
                              style: defaultTheme.textTheme.bodyText2
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: Sizes.marginViewBorderSize,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: userAuth.termsAccepted,
                              onChanged: (value) =>
                                  loginNotifier.acceptTerms(value ?? false),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: locals.loginViewTermsLinkPrefix,
                                    style: defaultTheme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.white),
                                    children: [
                                      TextSpan(
                                        text: locals.loginViewTermsLink,
                                        style: defaultTheme.textTheme.bodyText2
                                            ?.copyWith(
                                                color: Colors.white,
                                                decoration:
                                                    TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                ).toClickable(onTap: () => _openTermsLink()),
                                Text(
                                  locals.loginViewPrivacyStatementLink,
                                  style: defaultTheme.textTheme.bodyText2
                                      ?.copyWith(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline),
                                ).toClickable(
                                    onTap: () =>
                                        _openPrivacyStatement(context)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: Sizes.marginViewBorderSize,
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
                                  style: defaultTheme.textTheme.bodyText1
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
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ).toClickable(
                            onTap: () => _openForgotPassword(context)),
                        Text.rich(
                          TextSpan(
                            text: locals.loginViewRegisterLinkPrefix,
                            style: defaultTheme.textTheme.bodyText2
                                ?.copyWith(color: Colors.white),
                            children: [
                              TextSpan(
                                text: locals.loginViewRegisterLink,
                                style: defaultTheme.textTheme.bodyText2
                                    ?.copyWith(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline),
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
      ).withBackground(),
    );
  }

  void _doLogin(
      WidgetRef ref, String username, String password, bool rememberSignIn) {
    var loginProviderNotifier = ref.read(loginProvider.notifier);
    loginProviderNotifier.login(username, password, rememberSignIn);
  }

  void _openRegistering(BuildContext context) {
    context.goNamed("register", params: {
      "title": AppLocalizations.of(context)!.registerPageTitle,
      "url": "https://www.energiatili.fi/eServices/Online/RegisterIndex"
    });
  }

  void _openForgotPassword(BuildContext context) {
    context.goNamed("register", params: {
      "title": AppLocalizations.of(context)!.forgotPasswordPageTitle,
      "url": "https://www.energiatili.fi/eServices/Online/ForgotPassword"
    });
  }

  void _openPrivacyStatement(BuildContext context) {
    context.goNamed("register", params: {
      "title": AppLocalizations.of(context)!.loginViewPrivacyStatementLink,
      "url":
          "https://www.oulunenergia.fi/tietosuojaselosteet/tietosuojaseloste-asiakkaille/"
    });
  }

  void _openTermsLink() {
    showSnackbar("TODO open page to Terms of service");
  }
}
