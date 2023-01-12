import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_selections_view.dart';
import 'package:oulun_energia_mobile/views/main/home_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/usage/usage_selections_view.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar(
      {Key? key, required this.initialExpanded, required this.currentIndex})
      : super(key: key);

  final bool initialExpanded;
  final int currentIndex;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late ExpandableController bottomNavigationBarController =
      ExpandableController(initialExpanded: widget.initialExpanded);

  @override
  Widget build(BuildContext context) {
    bottomNavigationBarController.expanded = widget.initialExpanded;
    var locals = AppLocalizations.of(context)!;

    return ExpandableNotifier(
      child: Expandable(
        controller: bottomNavigationBarController,
        expanded: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 1,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: Sizes.mainViewIconSize,
                height: Sizes.mainViewIconSize,
                color: widget.currentIndex == 0
                    ? defaultTheme.bottomNavigationBarTheme.selectedItemColor
                    : defaultTheme.bottomNavigationBarTheme.unselectedItemColor,
              ).toBottomBarIcon(selected: widget.currentIndex == 0),
              label: locals.usageViewHome,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/monitoring.svg',
                width: Sizes.mainViewIconSize,
                height: Sizes.mainViewIconSize,
                color: widget.currentIndex == 1
                    ? defaultTheme.bottomNavigationBarTheme.selectedItemColor
                    : defaultTheme.bottomNavigationBarTheme.unselectedItemColor,
              ).toBottomBarIcon(selected: widget.currentIndex == 1),
              label: locals.usageViewMyUsage,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.fmd_bad_outlined,
                size: Sizes.mainViewIconSize,
              ).toBottomBarIcon(selected: widget.currentIndex == 2),
              label: locals.usageViewInterruptions,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.support_agent_outlined,
                size: Sizes.mainViewIconSize,
              ).toBottomBarIcon(selected: widget.currentIndex == 3),
              label: locals.usageViewContact,
            ),
          ],
          currentIndex: widget.currentIndex,
          onTap: (int index) {
            switch (index) {
              case 0:
                context.go(HomeView.routePath);
                break;
              case 1:
                context.go(UsageSelectionsView.routePath);
                break;
              case 2:
                context.go(InterruptionsSelectionsView.routePath);
                break;
              case 3:
                context.go(ContactUsView.routePath);
                break;
              default:
                context.go(HomeView.routePath);
                break;
            }
          },
        ),
        collapsed: const SizedBox.shrink(),
      ),
    );
  }
}
