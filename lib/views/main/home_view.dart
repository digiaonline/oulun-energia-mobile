import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

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
        children: _buildControls(isLoggedIn, locals),
      ),
    ]);
  }
}

List<Widget> _buildControls(bool isLoggedIn, AppLocalizations locals) {
  return [
    _buildHomeViewButton(
        locals.homeViewUsageInfo, 'assets/icons/monitoring.svg',
        onTap: isLoggedIn ? () => null : null,
        marker: !isLoggedIn
            ? const Icon(
                Icons.lock_outline,
                size: 14,
              )
            : null),
    _buildHomeViewButton(locals.homeViewInterruptions, 'assets/icons/news.svg'),
    _buildHomeViewButton(
        locals.homeViewContact, 'assets/icons/support_agent.svg'),
    _buildHomeViewButton(locals.homeViewFishHunt, 'assets/icons/set_meal.svg'),
    _buildHomeViewButton(
        locals.homeViewErrorReporting, 'assets/icons/calendar.svg'),
    _buildHomeViewButton(locals.homeViewHelp, 'assets/icons/menu_book.svg'),
  ];
}

Widget _buildHomeViewButton(
  String title,
  String iconAsset, {
  Function()? onTap,
  Widget? marker,
}) {
  return Opacity(
    opacity: onTap == null ? 0.6 : 1.0,
    child: SizedBox(
      width: Sizes.mainViewIconAvatarSize,
      child: TextButton(
        onPressed: onTap,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CircleAvatar(
                  radius: Sizes.mainViewIconAvatarSize / 4,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    iconAsset,
                    width: Sizes.mainViewIconSize,
                    height: Sizes.mainViewIconSize,
                    color: iconColorBlue,
                  ),
                ),
                marker != null
                    ? CircleAvatar(
                        radius: Sizes.mainViewIconAvatarSize / 8,
                        backgroundColor: iconColorBlueLight,
                        child: marker,
                      )
                    : const SizedBox.shrink()
              ],
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.bodyText2?.copyWith(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    ),
  );
}
