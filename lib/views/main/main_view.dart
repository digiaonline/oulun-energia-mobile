import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/main/home_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_selections_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class MainView extends ConsumerStatefulWidget {
  static const String routeName = "home_page";

  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MainViewState();
  }
}

class MainViewState extends ConsumerState<MainView> {
  int _selectedIndex = 0;
  bool _secondaryAppBar = false;
  String? _appBarTitle;
  bool _bottomBarExpanded = false;
  final homeViewNavigatorKey = GlobalKey<NavigatorState>();
  final usageViewNavigatorKey = GlobalKey<NavigatorState>();

  final ExpandableController bottomNavigationBarController =
      ExpandableController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locals = AppLocalizations.of(context)!;
    bottomNavigationBarController.expanded = _bottomBarExpanded;

    var appBar = buildMainAppBar(
      context,
      backgroundColor: _selectedIndex != 0 ? Colors.white : null,
      foregroundColor: _selectedIndex != 0 ? iconColorBlue : Colors.white,
      iconThemeData: _selectedIndex != 0 ? appBarIconThemeSecondary : null,
      forceElevated: _selectedIndex != 0 ? true : null,
      toolbarHeight: !_secondaryAppBar ? theme.appBarTheme.toolbarHeight : 100,
      actions: _secondaryAppBar
          ? null
          : const [
              Padding(
                padding: EdgeInsets.only(
                  right: 20.0,
                ),
                child: Icon(
                  Icons.face,
                  size: 28.5,
                ),
              )
            ],
      leading: !_secondaryAppBar
          ? InkWell(
              onTap: () => Navigator.of(context).pushNamed(LoginView.routeName),
              child: const Icon(Icons.menu),
            )
          : null,
      titleWidget: _secondaryAppBar
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
                            usageViewNavigatorKey.currentState?.pop();
                            setState(() {
                              _secondaryAppBar = false;
                            });
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(
                          height: Sizes.marginViewBorderSize,
                        ),
                        Text(
                          _appBarTitle!,
                          style: textTheme.headline2
                              ?.copyWith(color: Colors.black),
                        ),
                      ]),
                  const Icon(Icons.help),
                ],
              ),
            )
          : null,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          appBar,
          SliverFillRemaining(
            child: Navigator(
              key: homeViewNavigatorKey,
              initialRoute: HomeView.routeName,
              onGenerateRoute: (settings) {
                late Widget view;
                _secondaryAppBar = false;
                switch (settings.name) {
                  case HomeView.routeName:
                    view = _buildHomeView(locals);
                    break;
                  case UsageSelectionsView.routeName:
                    view = Container(
                      color: Colors.white,
                      child: Navigator(
                          key: usageViewNavigatorKey,
                          initialRoute: UsageSelectionsView.routeName,
                          onGenerateRoute: (settings) {
                            late Widget view;
                            switch (settings.name) {
                              case UsageSettingsView.routeName:
                                _appBarTitle = locals.usageViewSettings;
                                _secondaryAppBar = true;
                                view = UsageSettingsView(
                                  onCancel: () {
                                    usageViewNavigatorKey.currentState?.pop();
                                    setState(() {
                                      _secondaryAppBar = false;
                                    });
                                  },
                                );
                                break;
                              case UsageInfoView.routeName:
                                _appBarTitle = locals.usageViewUsageInfo;
                                _secondaryAppBar = true;
                                view = const UsageInfoView();
                                break;
                              default:
                                _appBarTitle = locals.usageViewMyConsumption;
                                _secondaryAppBar = false;
                                view = const UsageSelectionsView();
                            }

                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              setState(() {
                                _appBarTitle = _appBarTitle;
                                _secondaryAppBar = _secondaryAppBar;
                              });
                            });

                            return MaterialPageRoute(
                                settings: settings,
                                builder: (context) => Container(
                                      color: Colors.white,
                                      child: view,
                                    ));
                          }),
                    );
                    break;
                }

                return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => view,
                );
              },
            ),
          ),
        ],
      ).withBackground(),
      bottomNavigationBar: ExpandableNotifier(
        child: Expandable(
          controller: bottomNavigationBarController,
          expanded: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 1,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  width: 20.0,
                  height: 20.0,
                  color: _selectedIndex == 0
                      ? theme.bottomNavigationBarTheme.selectedItemColor
                      : theme.bottomNavigationBarTheme.unselectedItemColor,
                ).toBottomBarIcon(selected: _selectedIndex == 0),
                label: locals.usageViewHome,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/monitoring.svg',
                  width: Sizes.mainViewIconSize,
                  height: Sizes.mainViewIconSize,
                  color: _selectedIndex == 1
                      ? theme.bottomNavigationBarTheme.selectedItemColor
                      : theme.bottomNavigationBarTheme.unselectedItemColor,
                ).toBottomBarIcon(selected: _selectedIndex == 1),
                label: locals.usageViewMyUsage,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.fmd_bad_outlined,
                  size: Sizes.mainViewIconSize,
                ).toBottomBarIcon(selected: _selectedIndex == 2),
                label: locals.usageViewInterruptions,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.support_agent_outlined,
                  size: Sizes.mainViewIconSize,
                ).toBottomBarIcon(selected: _selectedIndex == 3),
                label: locals.usageViewContact,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (index) => _selectedMainContent(index),
          ),
          collapsed: const SizedBox.shrink(),
        ),
      ),
    ).withBackground();
  }

  HomeView _buildHomeView(AppLocalizations locals) {
    var loginState = ref.watch(loginProvider);
    var isLoggedIn = loginState.loggedInStatus == LoggedInStatus.loggedIn;
    return HomeView(
      mainControls: [
        buildHomeViewButton(
            locals.homeViewUsageInfo, 'assets/icons/monitoring.svg',
            onTap: isLoggedIn ? () => _selectedMainContent(1) : null,
            marker: !isLoggedIn
                ? const Icon(
                    Icons.lock_outline,
                    size: 14,
                  )
                : null),
        buildHomeViewButton(
            locals.homeViewInterruptions, 'assets/icons/news.svg'),
        buildHomeViewButton(
            locals.homeViewContact, 'assets/icons/support_agent.svg'),
        buildHomeViewButton(
            locals.homeViewFishHunt, 'assets/icons/set_meal.svg'),
        buildHomeViewButton(
            locals.homeViewErrorReporting, 'assets/icons/calendar.svg'),
        buildHomeViewButton(locals.homeViewHelp, 'assets/icons/menu_book.svg'),
      ],
    );
  }

  _selectedMainContent(int index) {
    switch (index) {
      case 0:
        homeViewNavigatorKey.currentState
            ?.pushReplacementNamed(HomeView.routeName);
        break;
      case 1:
        homeViewNavigatorKey.currentState
            ?.pushReplacementNamed(UsageSelectionsView.routeName);
        break;
      default:
        return; // no known route
    }
    setState(() {
      _selectedIndex = index;
      _bottomBarExpanded = index != 0;
    });
  }
}

Widget buildHomeViewButton(
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
