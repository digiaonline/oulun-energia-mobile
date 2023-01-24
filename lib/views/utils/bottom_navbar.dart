import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/utils/config.dart';

class BottomNavbar extends ConsumerStatefulWidget {
  const BottomNavbar({Key? key, required this.initialExpanded})
      : super(key: key);

  final bool initialExpanded;

  @override
  ConsumerState<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends ConsumerState<BottomNavbar> {
  late ExpandableController bottomNavigationBarController =
      ExpandableController(initialExpanded: widget.initialExpanded);

  int currentIndex = 0;

  List<BottomNavigationBarItem> get _items =>
      Config.getUserItems(context, ref, _currentIndex);
  List<String> get _locationNames => Config.getUserRouteNames(context, ref);

  int get _currentIndex =>
      _locationToIndex(_locationNames, GoRouter.of(context).location);

  int _locationToIndex(List<String> routes, String location) {
    var locations = location.split('/');
    var idx = locations.length > 2 ? 2 : 1;
    final index =
        routes.indexWhere((route) => locations[idx].startsWith(route));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    bottomNavigationBarController.expanded = widget.initialExpanded;

    return ExpandableNotifier(
      child: Expandable(
        controller: bottomNavigationBarController,
        expanded: BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          items: _items,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
            var location = _locationNames[index];
            context.goNamed(location);
          },
        ),
        collapsed: const SizedBox.shrink(),
      ),
    );
  }
}
