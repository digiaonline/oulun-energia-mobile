import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/usage/usage_app_bar.dart';

class UsageScaffold extends StatelessWidget {
  final Function() onTap;
  final String title;
  final Widget? icon;
  final Widget body;

  const UsageScaffold(
      {Key? key,
      required this.onTap,
      required this.body,
      required this.title,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: usageAppBar(
        onTap: onTap,
        title: title,
        trailing: Container(
          padding: const EdgeInsets.only(right: 20.0),
          child: icon,
        ),
      ),
      body: body,
    );
  }
}
