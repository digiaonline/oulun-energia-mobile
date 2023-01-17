import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/bottom_navbar.dart';
import 'package:oulun_energia_mobile/views/utils/navigation_drawer.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class ScaffoldNavbar extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
              toolbarHeight: !secondaryAppBar
                  ? defaultTheme.appBarTheme.toolbarHeight
                  : 100,
              actions: secondaryAppBar
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
}
