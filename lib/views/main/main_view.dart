import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/views/usage/usage_view.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

import '../../flavors.dart';

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
  final homeViewNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locals = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildMainAppBar(
            context,
          ),
          SliverFillRemaining(
            child: Navigator(
              key: homeViewNavigatorKey,
              initialRoute: HomeView.routeName,
              onGenerateRoute: (settings) {
                Widget view = HomeView();
                switch (settings.name) {
                  case HomeView.routeName:
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
      bottomNavigationBar: BottomNavigationBar(
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
        onTap: (index) {
          setState(() {
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
            _selectedIndex = index;
          });
        },
      ),
    ).withBackground();
  }
}

class HomeView extends StatelessWidget {
  static const String routeName = "home_route";

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(children: [
      Center(
        child: Text(
          'Hello ${F.title}',
          style: textTheme.bodyText1,
        ),
      ),
      /*FutureBuilder(
            initialData: Text("loading"),
            builder: (context, snapshot) =>
                IntrinsicHeight(child: snapshot.data!),
            future: LocalStorage().migrate()),*/
    ]);
  }
}
