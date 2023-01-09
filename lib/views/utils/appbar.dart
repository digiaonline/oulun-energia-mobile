import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

SliverAppBar buildMainAppBar(
  BuildContext context, {
  String? title,
  Widget? titleWidget,
  double? toolbarHeight,
  Color? backgroundColor,
  Color? foregroundColor,
  IconThemeData? iconThemeData,
  bool? forceElevated,
  List<Widget>? actions,
  Widget? leading,
  Widget? flexibleSpace,
  bool? centerTitle = true,
}) {
  return SliverAppBar(
    automaticallyImplyLeading: false,
    flexibleSpace: flexibleSpace,
    forceElevated: forceElevated ?? false,
    shadowColor: foregroundColor,
    iconTheme: iconThemeData,
    foregroundColor: foregroundColor,
    backgroundColor: backgroundColor,
    toolbarHeight: toolbarHeight ?? kToolbarHeight,
    centerTitle: centerTitle,
    title: titleWidget ??
        (title != null
            ? title.isNotEmpty
                ? Text(title)
                : null
            : SvgPicture.asset(
                'assets/images/oe_logo.svg',
                color: foregroundColor,
                width: 200,
              )),
    leading: leading,
    actions: actions,
  );
}
