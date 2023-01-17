import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/flavors.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/providers/settingsProvider.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class NavigationDrawer extends ConsumerWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userAuth = ref.watch(loginProvider);
    var locals = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var currentLocale = Localizations.localeOf(context);
    var settingsNotifier = ref.read(settingsProvider.notifier);
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: Sizes.marginViewBorder,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                F.title,
                style: theme.textTheme.headline2,
              ),
              const SizedBox(
                height: Sizes.marginViewBorderSize,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  locals.usageViewMyUsage,
                  style: theme.textTheme.bodyText1
                      ?.copyWith(fontWeight: FontWeight.w700),
                ).toDisabledOpacity(disabled: !userAuth.loggedIn()),
                if (!userAuth.loggedIn())
                  Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: Sizes.navigationDrawerIconSize,
                        color: theme.textTheme.bodyText2?.color,
                      ),
                      Text(
                        locals.navigationDrawerLogin,
                        style: theme.textTheme.bodyText2
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )
                    ],
                  ).toClickable(onTap: () => context.go(LoginView.routePath)),
              ]),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/icons/monitoring.svg",
                  height: Sizes.navigationDrawerIconSize,
                  width: Sizes.navigationDrawerIconSize,
                  color: theme.textTheme.bodyText2?.color,
                ),
                title: Text(
                  locals.usageViewUsage,
                  style: theme.textTheme.bodyText2
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                onTap: userAuth.loggedIn()
                    ? () => context.go(UsageInfoView.routePath)
                    : null,
              ).toDisabledOpacity(disabled: !userAuth.loggedIn()),
              ListTile(
                leading: Icon(
                  Icons.settings_outlined,
                  color: theme.textTheme.bodyText2?.color,
                  size: Sizes.navigationDrawerIconSize,
                ),
                onTap: userAuth.loggedIn()
                    ? () => context.go(UsageSettingsView.routePath)
                    : null,
                title: Text(
                  locals.usageViewSettings,
                  style: theme.textTheme.bodyText2
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ).toDisabledOpacity(disabled: !userAuth.loggedIn()),
              const Divider(),
              Text(
                locals.usageViewInterruptions,
                style: theme.textTheme.bodyText1
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/icons/monitoring.svg",
                  height: Sizes.navigationDrawerIconSize,
                  width: Sizes.navigationDrawerIconSize,
                  color: theme.textTheme.bodyText2?.color,
                ),
                title: Text(
                  "KeskeytyskarttaL",
                  style: theme.textTheme.bodyText2
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/icons/news.svg",
                  height: Sizes.navigationDrawerIconSize,
                  width: Sizes.navigationDrawerIconSize,
                  color: theme.textTheme.bodyText2?.color,
                ),
                title: Text(
                  "KeskeytystiedotteetL",
                  style: theme.textTheme.bodyText2
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/icons/calendar.svg",
                  height: Sizes.navigationDrawerIconSize,
                  width: Sizes.navigationDrawerIconSize,
                  color: theme.textTheme.bodyText2?.color,
                ),
                title: Text(
                  "Ilmoita viastaL",
                  style: theme.textTheme.bodyText2
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const Divider(),
              Text(
                locals.homeViewFishHunt,
                style: theme.textTheme.bodyText2
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Divider(),
              Text(
                locals.homeViewContact,
                style: theme.textTheme.bodyText2
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Divider(),
              Text(
                locals.homeViewHelp,
                style: theme.textTheme.bodyText2
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Divider(),
              IntrinsicHeight(
                child: Row(
                  children: AppLocalizations.supportedLocales
                      .expand(
                        (e) => [
                          Text(
                            e.languageCode.toUpperCase(),
                            style: theme.textTheme.bodyText2?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: currentLocale == e ? Colors.blue : null),
                          ).toClickable(
                            onTap: () => settingsNotifier.setLocale(e),
                          ),
                          if (AppLocalizations.supportedLocales.last != e)
                            const VerticalDivider(
                              color: Colors.black,
                            )
                        ],
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}