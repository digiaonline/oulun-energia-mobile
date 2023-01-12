import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
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

    var usernameController =
        TextEditingController(text: "mira.juola@icloud.com");
    var passwordController = TextEditingController(text: "Vaihda123456");
    bool _acceptedTerms = false; // todo move to a provider

    var theme = Theme.of(context);
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
                      "Kirjaudu palveluun",
                      style: theme.textTheme.headline2?.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Username:",
                          style: defaultTheme.textTheme.bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              hintText: "Type user name here"),
                          maxLines: 1,
                          controller: usernameController,
                        ),
                        const SizedBox(
                          height: Sizes.marginViewBorderSize,
                        ),
                        Text(
                          "Password:",
                          style: defaultTheme.textTheme.bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              hintText: "Type password here"),
                          maxLines: 1,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: Sizes.marginViewBorderSize,
                        ),
                        Row(
                          children: [
                            const Checkbox(value: false, onChanged: null),
                            Flexible(
                                child: Text(
                              "Hyväksyn sovelluksen käyttöehdot\nTutustu tietosuojaselosteeseen",
                              style: defaultTheme.textTheme.bodyText2
                                  ?.copyWith(color: Colors.white),
                            )),
                          ],
                        ),
                        userAuth.loading
                            ? const Center(child: CircularProgressIndicator())
                            : TextButton(
                                onPressed: () => _doLogin(
                                    ref,
                                    usernameController.text,
                                    passwordController.text),
                                child: Text(
                                  "Login",
                                  style: defaultTheme.textTheme.bodyText1
                                      ?.copyWith(color: Colors.white),
                                ),
                              ).toButton()
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Tai tunnistaudu",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: Sizes.marginViewBorderSize,
                        ),
                        TextButton(
                          onPressed: null,
                          child: Text(
                            "Pankkitunnuksella",
                            style: theme.textTheme.bodyText2
                                ?.copyWith(color: Colors.cyan),
                          ),
                        ).toButton(secondary: true),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Unohtuiko",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText2
                                ?.copyWith(color: Colors.white)),
                        Text(
                          "Eikö ole tunnusta",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
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
}
