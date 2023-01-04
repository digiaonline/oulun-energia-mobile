import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/usage/usage_view.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class MainView extends StatefulWidget {
  static const String routeName = "home_page";

  const MainView({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainViewState();
  }
}

class MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  bool _bottomBarExpanded = false;
  final homeViewNavigatorKey = GlobalKey<NavigatorState>();

  final ExpandableController bottomNavigationBarController =
      ExpandableController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locals = AppLocalizations.of(context)!;
    bottomNavigationBarController.expanded = _bottomBarExpanded;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildMainAppBar(context,
              backgroundColor: _selectedIndex != 0 ? Colors.white : null,
              foregroundColor:
                  _selectedIndex != 0 ? iconColorBlue : Colors.white,
              iconThemeData:
                  _selectedIndex != 0 ? appBarIconThemeSecondary : null,
              forceElevated: _selectedIndex != 0 ? true : null),
          SliverFillRemaining(
            child: Navigator(
              key: homeViewNavigatorKey,
              initialRoute: HomeView.routeName,
              onGenerateRoute: (settings) {
                late Widget view;
                switch (settings.name) {
                  case HomeView.routeName:
                    view = HomeView(
                      mainControls: [
                        _buildHomeViewButton(locals.usageViewMyConsumption,
                            'assets/icons/monitoring.svg'),
                        _buildHomeViewButton(locals.usageViewMyConsumption,
                            'assets/icons/monitoring.svg'),
                        _buildHomeViewButton(locals.usageViewMyConsumption,
                            'assets/icons/monitoring.svg'),
                        _buildHomeViewButton(locals.usageViewMyConsumption,
                            'assets/icons/monitoring.svg'),
                        _buildHomeViewButton(locals.usageViewMyConsumption,
                            'assets/icons/monitoring.svg'),
                      ],
                    );
                    break;
                  case UsageView.routeName:
                    view = Container(color: Colors.white, child: UsageView());
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
                  width: 20.0,
                  height: 20.0,
                  color: _selectedIndex == 1
                      ? theme.bottomNavigationBarTheme.selectedItemColor
                      : theme.bottomNavigationBarTheme.unselectedItemColor,
                ).toBottomBarIcon(selected: _selectedIndex == 1),
                label: locals.usageViewMyUsage,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.fmd_bad_outlined,
                  size: 20,
                ).toBottomBarIcon(selected: _selectedIndex == 2),
                label: locals.usageViewInterruptions,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.support_agent_outlined,
                  size: 20,
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

  Widget _buildHomeViewButton(
    String title,
    String iconAsset,
  ) {
    return SizedBox(
      width: 100,
      child: TextButton(
        onPressed: () => _selectedMainContent(1),
        child: Column(
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 20.0,
              height: 20.0,
              color: Colors.white,
            ),
            Text(
              title,
              style: textTheme.bodyText2?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
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
            ?.pushReplacementNamed(UsageView.routeName);
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

class HomeView extends ConsumerWidget {
  static const String routeName = "home_route";

  final List<Widget> mainControls;

  const HomeView({super.key, required this.mainControls});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var textTheme = Theme.of(context).textTheme;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Column(
        children: [
          Text(
            'Hello Dude!',
            style: textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          Text(
            'no messages',
            style: textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
        ],
      ),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: mainControls,
      ),
    ]);
  }
}
