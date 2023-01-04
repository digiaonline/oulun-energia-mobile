import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';

SliverAppBar buildMainAppBar(
  BuildContext context, {
  String? title,
  Widget? titleWidget,
  double? expandedHeight,
  Color? backgroundColor,
  Color? foregroundColor,
  IconThemeData? iconThemeData,
  bool? forceElevated,
}) {
  return SliverAppBar(
    forceElevated: forceElevated ?? false,
    shadowColor: foregroundColor,
    iconTheme: iconThemeData,
    foregroundColor: foregroundColor,
    backgroundColor: backgroundColor,
    toolbarHeight:
        expandedHeight ?? Theme.of(context).appBarTheme.toolbarHeight ?? 40,
    centerTitle: true,
    title: titleWidget ??
        (title != null
            ? Text(title)
            : SvgPicture.asset(
                'assets/images/oe_logo.svg',
                color: foregroundColor,
                width: 200,
              )),
    leading: InkWell(
      onTap: () => Navigator.of(context).pushNamed(LoginView.routeName),
      child: const Icon(Icons.menu),
    ),
    actions: const [
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
  );
}
