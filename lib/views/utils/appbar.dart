import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';

AppBar buildMainAppBar(BuildContext context,
    {String? title, Widget? titleWidget}) {
  return AppBar(
    centerTitle: true,
    title: titleWidget ?? (title != null ? Text(title) : null),
    leading: InkWell(
      onTap: () => Navigator.of(context).pushNamed(LoginView.routeName),
      child: const Icon(Icons.menu),
    ),
    actions: const [Icon(Icons.face)],
  );
}
