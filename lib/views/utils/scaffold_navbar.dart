import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/bottom_navbar.dart';
import 'package:oulun_energia_mobile/views/utils/navigation_drawer.dart';
import 'package:oulun_energia_mobile/views/utils/snackbar.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class ScaffoldNavbar extends ConsumerWidget {
  const ScaffoldNavbar(
      {Key? key,
      this.title,
      this.backRoutePath,
      required this.initialExpanded,
      required this.secondaryAppBar,
      this.hideAppBar = false,
      this.secondaryAppBarStyle,
      required this.bottomBarIndex,
      required this.child})
      : super(key: key);

  final Widget child;
  final bool initialExpanded;
  final bool secondaryAppBar;
  final bool? secondaryAppBarStyle;
  final bool hideAppBar;
  final String? backRoutePath;
  final String? title;
  final int bottomBarIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginNotifier = ref.read(loginProvider.notifier);
    var userAuth = ref.watch(loginProvider);
    var theme = Theme.of(context);
    var locals = AppLocalizations.of(context)!;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: const Drawer(
        child: NavigationDrawer(),
      ),
      body: CustomScrollView(
        slivers: [
          if (!hideAppBar)
            buildMainAppBar(
              context,
              backgroundColor:
                  secondaryAppBarStyle ?? secondaryAppBar ? Colors.white : null,
              foregroundColor: secondaryAppBarStyle ?? secondaryAppBar
                  ? iconColorBlue
                  : Colors.white,
              iconThemeData: secondaryAppBarStyle ?? secondaryAppBar
                  ? appBarIconThemeSecondary
                  : null,
              forceElevated:
                  secondaryAppBarStyle ?? secondaryAppBar ? true : null,
              toolbarHeight:
                  !secondaryAppBar ? theme.appBarTheme.toolbarHeight : 100,
              actions: secondaryAppBar
                  ? null
                  : [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20.0,
                        ),
                        child: PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              _createMenuItem(locals.popupMenuItemUserInfo, () {
                                showSnackbar("TODO");
                              }, icon: Icons.face_outlined),
                              if (userAuth.loggedIn())
                                _createMenuItem(locals.popupMenuItemLogout, () {
                                  showSnackbar("TODO but still logged out");
                                  loginNotifier.logout();
                                }, icon: Icons.logout),
                              if (!userAuth.loggedIn())
                                _createMenuItem(locals.popupMenuItemLogin,
                                    () => context.goNamed(LoginView.routeName),
                                    icon: Icons.login)
                            ];
                          },
                          icon: Icon(
                            Icons.face,
                            size: Sizes.appBarIconSize,
                            color: theme.appBarTheme.iconTheme?.color,
                          ),
                        ),
                      )
                    ],
              leading: !secondaryAppBar
                  ? Builder(
                      builder: (context) => InkWell(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: const Icon(Icons.menu),
                      ),
                    )
                  : null,
              titleWidget: secondaryAppBar
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: Sizes.marginViewBorderSize),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (backRoutePath != null) {
                                      context.go(backRoutePath!);
                                    }
                                  },
                                  child: const Icon(Icons.arrow_back),
                                ),
                                const SizedBox(
                                  height: Sizes.marginViewBorderSize,
                                ),
                                Text(
                                  title ?? '',
                                  style: textTheme.headline2
                                      ?.copyWith(color: Colors.black),
                                ),
                              ]),
                          const Icon(Icons.help),
                        ],
                      ),
                    )
                  : null,
            ),
          SliverFillRemaining(child: child),
        ],
      ).withBackground(),
      bottomNavigationBar: BottomNavbar(
          initialExpanded: initialExpanded, currentIndex: bottomBarIndex),
    );
  }

  PopupMenuItem _createMenuItem(String text, Function() onTap,
      {String? iconSvg, IconData? icon}) {
    return PopupMenuItem(
      onTap: onTap,
      value: 1,
      child: Row(children: [
        if (icon != null)
          Icon(
            icon,
            color: popupMenuItemColor,
          ),
        if (icon != null)
          const SizedBox(
            width: Sizes.itemDefaultSpacing,
          ),
        if (iconSvg != null) SvgPicture.asset(iconSvg),
        Text(
          text,
        ),
      ]),
    );
  }
}
