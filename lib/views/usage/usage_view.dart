import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/views/usage/usage_data_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_default_view.dart';

class UsageView extends StatefulWidget {
  static String routeName = 'usage_view';

  const UsageView({Key? key}) : super(key: key);

  @override
  State<UsageView> createState() => _UsageViewState();
}

class _UsageViewState extends State<UsageView> {
  int _currentPageIndex = 0;

  void onChangePage(int page) {
    setState(() {
      _currentPageIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        UsageDefaultView(onChangePage: onChangePage),
        UsageDataView(onChangePage: onChangePage),
        Container(child: null),
      ][_currentPageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: NavigationBar(
          selectedIndex: 1,
          surfaceTintColor: Colors.red,
          backgroundColor: Colors.white,
          destinations: <Widget>[
            NavigationDestination(
              icon: const Icon(Icons.home_filled),
              label: AppLocalizations.of(context)!.usageViewHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.bar_chart),
              label: AppLocalizations.of(context)!.usageViewMyUsage,
            ),
            NavigationDestination(
              icon: const Icon(Icons.fmd_bad_outlined),
              label: AppLocalizations.of(context)!.usageViewInterruptions,
            ),
            NavigationDestination(
              icon: const Icon(Icons.support_agent_outlined),
              label: AppLocalizations.of(context)!.usageViewContact,
            ),
          ],
        ),
      ),
    );
  }
}
