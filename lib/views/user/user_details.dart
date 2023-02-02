import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class UserDetailsView extends ConsumerWidget {
  static const String routeName = "user_details";
  static const String routePath = "user_details";

  const UserDetailsView({super.key});

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title': AppLocalizations.of(context)!.popupMenuItemUserInfo,
      'secondaryAppBar': true,
      'initialExpanded': false,
      'hideAppBar': true,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userAuth = ref.read(loginProvider);
    var customer = userAuth.userAuth!.customerInfo;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Omat tiedot",
          style: theme.appBarTheme.titleTextStyle
              ?.copyWith(color: appBarIconThemeSecondary.color),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: appBarIconThemeSecondary.color,
        ).toClickable(onTap: () {
          String? backRoutePath = GoRouterState.of(context).extra as String?;
          if (backRoutePath != null) {
            context.go(backRoutePath);
          } else if (context.canPop()) {
            context.pop();
          }
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: containerColor,
              padding: Sizes.marginViewBorder,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${customer.firstName} ${customer.lastName}",
                    style: theme.textTheme.displayMedium,
                  ),
                  Column(
                    children: customer.customerCodes
                        .map((e) => Text(
                              e,
                              style: theme.textTheme.bodyLarge,
                            ))
                        .toList(),
                  ),
                  Text(
                    "Asiakasnumero",
                    style: theme.textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: Sizes.itemDefaultSpacing,
            ),
            Container(
              margin: Sizes.marginViewBorder,
              padding: Sizes.marginViewBorder,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2)),
              child: Column(
                children: [
                  const Text("Osoite"),
                  if (customer.street != null) Text(customer.street!),
                  if (customer.postPlace != null && customer.postcode != null)
                    Text("${customer.postcode!} ${customer.postPlace!}"),
                ],
              ),
            ),
            Container(
              margin: Sizes.marginViewBorder,
              padding: Sizes.marginViewBorder,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2)),
              child: Column(
                children: [
                  const Text("Puhelin"),
                  if (customer.phone != null) Text(customer.phone!),
                ],
              ),
            ),
            Container(
              margin: Sizes.marginViewBorder,
              padding: Sizes.marginViewBorder,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2)),
              child: Column(
                children: [
                  const Text("Sähköposti"),
                  if (customer.email != null) Text(customer.email!),
                ],
              ),
            )
          ],
        ),
      ),
    ).withWillPopScope(context);
  }
}
