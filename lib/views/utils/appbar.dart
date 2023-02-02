import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

SliverAppBar buildMainAppBar(
  BuildContext context, {
  String? title,
  Widget? titleWidget,
  double? toolbarHeight,
  Color? backgroundColor,
  Color? foregroundColor,
  IconThemeData? iconThemeData,
  bool? forceElevated,
  bool? removeBorder,
  List<Widget>? actions,
  Widget? leading,
  Widget? flexibleSpace,
  bool? centerTitle = true,
}) {
  return SliverAppBar(
    automaticallyImplyLeading: false,
    flexibleSpace: flexibleSpace,
    forceElevated: forceElevated ?? false,
    iconTheme: iconThemeData,
    shape: (backgroundColor == null)
        ? const Border.fromBorderSide(BorderSide(
            width: 0.0,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Colors.transparent))
        : defaultTheme.appBarTheme.shape,
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
