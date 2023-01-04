import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_selections_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';

class UsageDefaultView extends StatefulWidget {
  static String routeName = 'usage_default_view';
  final MyUsageViews myUsageView;

  const UsageDefaultView({Key? key, this.myUsageView = MyUsageViews.main})
      : super(key: key);

  @override
  State<UsageDefaultView> createState() => _UsageDefaultViewState();
}

class _UsageDefaultViewState extends State<UsageDefaultView> {
  late MyUsageViews _myUsageView = widget.myUsageView;

  void onChangePage(MyUsageViews page) {
    setState(() {
      _myUsageView = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      UsageSelectionsView(
        onChangePage: onChangePage,
      ),
      UsageDataView(onChangePage: onChangePage),
      UsageSettingsView(onChangePage: onChangePage),
    ];

    return views[_myUsageView.index];
  }
}
