import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/bottom_navbar.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class ScaffoldNavbar extends StatefulWidget {
  const ScaffoldNavbar(
      {Key? key,
      required this.title,
      required this.routePath,
      required this.initialExpanded,
      required this.secondaryAppBar,
      required this.currentIndex,
      required this.child})
      : super(key: key);

  final Widget child;
  final bool initialExpanded;
  final bool secondaryAppBar;
  final String routePath;
  final String title;
  final int currentIndex;

  @override
  State<ScaffoldNavbar> createState() => _ScaffoldNavbarState();
}

class _ScaffoldNavbarState extends State<ScaffoldNavbar> {
  final ExpandableController bottomNavigationBarController =
      ExpandableController(initialExpanded: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildMainAppBar(
            context,
            backgroundColor: widget.currentIndex != 0 ? Colors.white : null,
            foregroundColor:
                widget.currentIndex != 0 ? iconColorBlue : Colors.white,
            iconThemeData:
                widget.currentIndex != 0 ? appBarIconThemeSecondary : null,
            forceElevated: widget.currentIndex != 0 ? true : null,
            toolbarHeight: !widget.secondaryAppBar
                ? defaultTheme.appBarTheme.toolbarHeight
                : 100,
            actions: widget.secondaryAppBar
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
            leading: !widget.secondaryAppBar
                ? InkWell(
                    onTap: () => context.go(LoginView.routePath),
                    child: const Icon(Icons.menu),
                  )
                : null,
            titleWidget: widget.secondaryAppBar
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
                                  context.go(widget.routePath);
                                },
                                child: const Icon(Icons.arrow_back),
                              ),
                              const SizedBox(
                                height: Sizes.marginViewBorderSize,
                              ),
                              Text(
                                widget.title,
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
          SliverFillRemaining(child: widget.child),
        ],
      ).withBackground(widget.currentIndex == 0),
      bottomNavigationBar: BottomNavbar(
          initialExpanded: widget.initialExpanded,
          currentIndex: widget.currentIndex),
    );
  }
}
