import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/utils/snackbar.dart';

AppBar buildMainAppBar(BuildContext context, {String? title, Widget? titleWidget}) {
  return AppBar(
    centerTitle: true,
    title: titleWidget ?? (title != null ? Text(title) : null),
    leading: InkWell(
      onTap: () => showSnackbar("menu here"),
      child: const Icon(Icons.menu),
    ),

    actions: const [Icon(Icons.face)],
  );
}
