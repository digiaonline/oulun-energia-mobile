import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/views/usage/usage_default_view.dart';

class UsageView extends StatefulWidget {
  static const String routeName = 'usage_view';

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
  late final MyUsageViews _myUsageView = widget.myUsageView;

  @override
  Widget build(BuildContext context) {
    return UsageDefaultView(myUsageView: _myUsageView);
  }
}
