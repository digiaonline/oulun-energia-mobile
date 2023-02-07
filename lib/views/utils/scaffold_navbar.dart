import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/user/user_details.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/bottom_navbar.dart';
import 'package:oulun_energia_mobile/views/utils/home_navigation_drawer.dart';
import 'package:oulun_energia_mobile/views/utils/snackbar.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class ScaffoldNavbar extends ConsumerWidget {
  const ScaffoldNavbar(
      {Key? key,
      this.title,
      required this.initialExpanded,
      required this.secondaryAppBar,
      this.hasScrollBody,
      this.hideAppBar = false,
      this.secondaryAppBarStyle,
      this.bottomSheet,
      this.onTapHelp,
      required this.child})
      : super(key: key);

  final Widget child;
  final Widget? bottomSheet;
  final bool initialExpanded;
  final bool secondaryAppBar;
  final bool? secondaryAppBarStyle;
  final bool? hasScrollBody;
  final void Function()? onTapHelp;
  final bool hideAppBar;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginNotifier = ref.read(loginProvider.notifier);
    var userAuth = ref.watch(loginProvider);
    var theme = Theme.of(context);
    var locals = AppLocalizations.of(context)!;
    return Scaffold(
      bottomSheet: bottomSheet,
      drawerEnableOpenDragGesture: false,
      drawer: const Drawer(
        child: HomeNavigationDrawer(),
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
                              _createMenuItem(
                                  locals.popupMenuItemUserInfo,
                                  () => context.goNamed(
                                      UserDetailsView.routeName,
                                      extra: GoRouter.of(context).location),
                                  icon: Icons.face_outlined,
                                  enabled: userAuth.loggedIn()),
                              if (userAuth.loggedIn())
                                _createMenuItem(locals.popupMenuItemLogout, () {
                                  showSnackbar("TODO but still logged out");
                                  loginNotifier.logout();
                                }, icon: Icons.logout),
                              if (!userAuth.loggedIn())
                                _createMenuItem(
                                    locals.popupMenuItemLogin,
                                    () => context.goNamed(LoginView.routeName,
                                        extra: GoRouter.of(context).location),
                                    icon: Icons.login)
                            ];
                          },
                          icon: Icon(
                            Icons.face,
                            size: Sizes.appBarIconSize,
                            color: secondaryAppBarStyle ?? secondaryAppBar
                                ? iconColorBlue
                                : theme.appBarTheme.iconTheme?.color,
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
                                    String? backRoutePath =
                                        GoRouterState.of(context).extra
                                            as String?;
                                    if (backRoutePath != null) {
                                      context.go(backRoutePath);
                                    } else if (context.canPop()) {
                                      context.pop();
                                    }
                                  },
                                  child: const Icon(Icons.arrow_back),
                                ),
                                const SizedBox(
                                  height: Sizes.marginViewBorderSize,
                                ),
                                Text(
                                  title ?? '',
                                  style: textTheme.displayMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                              ]),
                          if (onTapHelp != null)
                            InkWell(
                              onTap: onTapHelp!,
                              child: const Icon(Icons.help),
                            ),
                        ],
                      ),
                    )
                  : null,
            ),
          SliverFillRemaining(
            hasScrollBody: hasScrollBody == null ? true : false,
            child: child,
          ),
        ],
      ).withBackground(),
      bottomNavigationBar: BottomNavbar(initialExpanded: initialExpanded),
    );
  }

  PopupMenuItem _createMenuItem(String text, Function() onTap,
      {String? iconSvg, IconData? icon, bool enabled = true}) {
    return PopupMenuItem(
      onTap: enabled ? onTap : null,
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
      ]).toDisabledOpacity(disabled: !enabled),
    );
  }
}
