import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/bottom_navbar.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class ScaffoldNavbar extends StatelessWidget {
  const ScaffoldNavbar(
      {Key? key,
      this.title,
      this.routePath,
      required this.initialExpanded,
      required this.secondaryAppBar,
      this.hideAppBar = false,
      required this.currentIndex,
      required this.child})
      : super(key: key);

  final Widget child;
  final bool initialExpanded;
  final bool secondaryAppBar;
  final bool hideAppBar;
  final String? routePath;
  final String? title;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (!hideAppBar)
            buildMainAppBar(
              context,
              backgroundColor: currentIndex != 0 ? Colors.white : null,
              foregroundColor: currentIndex != 0 ? iconColorBlue : Colors.white,
              iconThemeData:
                  currentIndex != 0 ? appBarIconThemeSecondary : null,
              forceElevated: currentIndex != 0 ? true : null,
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
                  ? InkWell(
                      onTap: () => context.go(LoginView.routePath),
                      child: const Icon(Icons.menu),
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
                                    if (routePath != null) {
                                      context.go(routePath!);
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
          initialExpanded: initialExpanded, currentIndex: currentIndex),
    );
  }
}
