import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/views/usage/usage_selections_view.dart';

class HomeView extends ConsumerWidget {
  static const String routePath = "/";
  static const String routeName = "home_route";

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
            'Tervetuloa!',
            style: textTheme.headline2?.copyWith(color: Colors.white),
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
                    loginStatus.loggedIn()
                        ? 'Ei tiedotteita TBD'
                        : 'Lukkosymbolilla merkityt osiot näet kirjautumalla palveluun',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText2?.copyWith(color: Colors.white),
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
        onTap:
            isLoggedIn ? () => context.go(UsageSelectionsView.routePath) : null,
        marker: !isLoggedIn
            ? const Icon(
                Icons.lock_outline,
                size: 14,
              )
            : null),
    buildHomeViewButton(locals.homeViewInterruptions, 'assets/icons/news.svg'),
    buildHomeViewButton(
        locals.homeViewContact, 'assets/icons/support_agent.svg'),
    buildHomeViewButton(locals.homeViewFishHunt, 'assets/icons/set_meal.svg'),
    buildHomeViewButton(
        locals.homeViewErrorReporting, 'assets/icons/calendar.svg'),
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
              style: textTheme.bodyText2?.copyWith(
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
