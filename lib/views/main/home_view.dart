import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_view.dart';
import 'package:oulun_energia_mobile/views/fishway/fish_way.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_fault_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notices_view.dart';
import 'package:oulun_energia_mobile/views/newsletter/newsletter_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';

class HomeView extends ConsumerWidget {
  static const String routePath = "/home";
  static const String routeName = "home";

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title': '',
      'secondaryAppBar': false,
      'initialExpanded': false,
      'bottomSheet': newsletterButton(context),
      'hideAppBar': false,
    };
  }

  static Widget newsletterButton(BuildContext context) {
    // TODO check if user has signed up for a newsletter
    // TODO hide if user has signed up for a newsletter?
    return ListTile(
      onTap: () {
        context.goNamed(NewsletterView.routeName);
      },
      minVerticalPadding: 0.0,
      textColor: Colors.white,
      tileColor: Colors.transparent,
      title: Text(
        AppLocalizations.of(context)!.homeViewOrderNewsletter,
        style: textTheme.bodyLarge,
      ),
      leading: Icon(
        Icons.mail_outline,
        size: Sizes.navigationDrawerIconSize,
        color: appBarIconTheme.color,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: Sizes.navigationDrawerIconSize,
        color: appBarIconTheme.color,
      ),
    );
  }

  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var textTheme = Theme.of(context).textTheme;
    var loginStatus = ref.watch(loginProvider);
    var locals = AppLocalizations.of(context)!;
    bool isLoggedIn = loginStatus.loggedInStatus == LoggedInStatus.loggedIn;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            isLoggedIn
                ? locals.homeViewWelcomeUser(
                    loginStatus.userAuth?.customerInfo.firstName ?? "")
                : locals.homeViewWelcome,
            style: textTheme.displayMedium?.copyWith(color: Colors.white),
          ),
          Container(
            margin: Sizes.marginViewBorder * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loginStatus.loggedIn()
                    ? const SizedBox.shrink()
                    : const Icon(Icons.lock_outline, size: 16),
                Expanded(
                  child: Text(
                    locals.homeViewMessageSumUp(isLoggedIn ? 0 : -1),
                    // todo get message count
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Wrap(
        runAlignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.center,
        children: _buildControls(context, isLoggedIn, locals),
      ),
    ]);
  }
}

List<Widget> _buildControls(
    BuildContext context, bool isLoggedIn, AppLocalizations locals) {
  return [
    buildHomeViewButton(locals.homeViewUsageInfo, 'assets/icons/monitoring.svg',
        onTap: isLoggedIn
            ? () => context.goNamed(
                  UsageInfoView.routeName,
                  extra: GoRouter.of(context).location,
                )
            : null,
        marker: !isLoggedIn
            ? const Icon(
                Icons.lock_outline,
                size: 14,
              )
            : null),
    buildHomeViewButton(locals.homeViewInterruptions, 'assets/icons/news.svg',
        onTap: () => context.goNamed(
              InterruptionsNoticesView.routeName,
              extra: GoRouter.of(context).location,
            )),
    buildHomeViewButton(
        locals.homeViewContact, 'assets/icons/support_agent.svg',
        onTap: () => context.goNamed(
              ContactUsView.routeName,
              extra: GoRouter.of(context).location,
            )),
    buildHomeViewButton(
      locals.homeViewFishHunt,
      'assets/icons/set_meal.svg',
      onTap: () => context.goNamed(FishWay.routeName),
    ),
    buildHomeViewButton(
        locals.homeViewErrorReporting, 'assets/icons/calendar.svg',
        onTap: () => context.goNamed(
              InterruptionsFaultView.routeName,
              extra: GoRouter.of(context).location,
            )),
    buildHomeViewButton(locals.homeViewHelp, 'assets/icons/menu_book.svg'),
  ];
}

Widget buildHomeViewButton(String title, String iconAsset,
    {Function()? onTap,
    Widget? marker,
    double avatarSize = Sizes.mainViewIconAvatarSize,
    double iconSize = Sizes.mainViewIconSize,
    double fontSize = 13}) {
  return Opacity(
    opacity: onTap == null ? 0.6 : 1.0,
    child: SizedBox(
      width: avatarSize,
      child: TextButton(
        onPressed: onTap,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CircleAvatar(
                  radius: avatarSize / 4,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    iconAsset,
                    width: iconSize,
                    height: iconSize,
                    color: iconColorBlue,
                  ),
                ),
                marker != null
                    ? CircleAvatar(
                        radius: avatarSize / 8,
                        backgroundColor: iconColorBlueLight,
                        child: marker,
                      )
                    : const SizedBox.shrink()
              ],
            ),
            const SizedBox(
              height: Sizes.marginViewBorderSize,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    ),
  );
}
