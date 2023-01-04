import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/views/usage/usage_default_view.dart';

class UsageView extends StatefulWidget {
  static String routeName = 'usage_view';

  UsageViews usageView;
  MyUsageViews myUsageView;

  UsageView(
      {Key? key,
      this.usageView = UsageViews.usage,
      this.myUsageView = MyUsageViews.main})
      : super(key: key);

  @override
  State<UsageView> createState() => _UsageViewState();
}

class _UsageViewState extends State<UsageView> {
  late UsageViews _usageView = widget.usageView;
  late final MyUsageViews _myUsageView = widget.myUsageView;

  void onChangePage(UsageViews view) {
    setState(() {
      _usageView = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        const SizedBox.shrink(),
        UsageDefaultView(myUsageView: _myUsageView),
      ][_usageView.index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            if (index == 0) {
              Navigator.of(context).pop();
            }

            onChangePage(UsageViews.values[index]);
          },
          selectedIndex: 1,
          surfaceTintColor: Colors.red,
          backgroundColor: Colors.white,
          destinations: <Widget>[
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/home.svg',
                  width: 20.0, height: 20.0),
              label: AppLocalizations.of(context)!.usageViewHome,
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/monitoring.svg',
                  width: 20.0, height: 20.0),
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
