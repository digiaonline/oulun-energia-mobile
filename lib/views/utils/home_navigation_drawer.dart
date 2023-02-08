import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/flavors.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/providers/settings_provider.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_view.dart';
import 'package:oulun_energia_mobile/views/fishway/fish_way.dart';
import 'package:oulun_energia_mobile/views/help/help_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_fault_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_map_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notices_view.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class HomeNavigationDrawer extends ConsumerWidget {
  const HomeNavigationDrawer({super.key});

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
                style: theme.textTheme.displayMedium,
              ),
              const SizedBox(
                height: Sizes.marginViewBorderSize,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  locals.usageViewMyUsage,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ).toDisabledOpacity(disabled: !userAuth.loggedIn()),
                if (!userAuth.loggedIn())
                  Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: Sizes.navigationDrawerIconSize,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                      Text(
                        locals.navigationDrawerLogin,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )
                    ],
                  ).toClickable(onTap: () {
                    Scaffold.of(context).closeDrawer();
                    context.goNamed(LoginView.routeName,
                        extra: GoRouter.of(context).location);
                  }),
              ]),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/icons/monitoring.svg",
                  height: Sizes.navigationDrawerIconSize,
                  width: Sizes.navigationDrawerIconSize,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                title: Text(
                  locals.usageViewUsage,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                onTap: userAuth.loggedIn()
                    ? () {
                        Scaffold.of(context).closeDrawer();
                        context.goNamed(UsageInfoView.routeName,
                            extra: GoRouter.of(context).location);
                      }
                    : null,
              ).toDisabledOpacity(disabled: !userAuth.loggedIn()),
              ListTile(
                leading: Icon(
                  Icons.settings_outlined,
                  color: theme.textTheme.bodyMedium?.color,
                  size: Sizes.navigationDrawerIconSize,
                ),
                onTap: userAuth.loggedIn()
                    ? () {
                        Scaffold.of(context).closeDrawer();
                        context.goNamed(UsageSettingsView.routeName,
                            extra: GoRouter.of(context).location);
                      }
                    : null,
                title: Text(
                  locals.usageViewSettings,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ).toDisabledOpacity(disabled: !userAuth.loggedIn()),
              const Divider(),
              Text(
                locals.usageViewInterruptions,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.goNamed(InterruptionsMapView.routeName,
                      params: {"url": InterruptionsMapView.targetUrl},
                      extra: GoRouter.of(context).location);
                },
                leading: SvgPicture.asset(
                  "assets/icons/monitoring.svg",
                  height: Sizes.navigationDrawerIconSize,
                  width: Sizes.navigationDrawerIconSize,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                title: Text(
                  locals.interruptionsViewMap,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.goNamed(InterruptionsNoticesView.routeName,
                      extra: GoRouter.of(context).location);
                },
                leading: SvgPicture.asset(
                  "assets/icons/news.svg",
                  height: Sizes.navigationDrawerIconSize,
                  width: Sizes.navigationDrawerIconSize,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                title: Text(
                  locals.interruptionsViewNotices,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.goNamed(InterruptionsFaultView.routeName,
                      extra: GoRouter.of(context).location);
                },
                leading: SvgPicture.asset(
                  "assets/icons/calendar.svg",
                  height: Sizes.navigationDrawerIconSize,
                  width: Sizes.navigationDrawerIconSize,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                title: Text(
                  locals.interruptionsViewFault,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const Divider(),
              Text(
                locals.homeViewFishHunt,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ).toClickable(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.goNamed(FishWay.routeName);
                },
              ),
              const Divider(),
              Text(
                locals.contactUs,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ).toClickable(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.goNamed(ContactUsView.routeName);
                },
              ),
              const Divider(),
              Text(
                locals.homeViewHelp,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ).toClickable(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.goNamed(HelpView.routePath);
                },
              ),
              const Divider(),
              IntrinsicHeight(
                child: Row(
                  children: AppLocalizations.supportedLocales
                      .expand(
                        (e) => [
                          Text(
                            e.languageCode.toUpperCase(),
                            style: theme.textTheme.bodyMedium?.copyWith(
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
