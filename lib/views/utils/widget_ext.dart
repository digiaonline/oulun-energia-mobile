import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

const double disabledOpacity = 0.6;

extension WidgetExt on Widget {
  Widget withBackground({bool img = false, bool dimBackground = false}) {
    if (img) {
      return Stack(
        children: [
          Image.asset(
            "assets/images/background.jpg",
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          !dimBackground
              ? this
              : withBackgroundColor(Colors.black54.withOpacity(0.8))
        ],
      );
    }
    return Container(color: Colors.white, child: this);
  }

  Widget withBackgroundColor(Color color) {
    return Container(color: color, child: this);
  }

  Widget withWillPopScope(BuildContext context) => WillPopScope(
        onWillPop: () async {
          String? backRoutePath = GoRouterState.of(context).extra as String?;
          if (backRoutePath != null) {
            context.go(backRoutePath);
            return false;
          }
          return true;
        },
        child: this,
      );

  Widget toButton({bool? secondary, bool? enabled}) {
    var container = Container(
      decoration: BoxDecoration(
        border: secondary != null
            ? Border.all(color: buttonPrimaryBackground)
            : null,
        shape: BoxShape.rectangle,
        color: secondary != null ? Colors.transparent : buttonPrimaryBackground,
      ),
      child: this,
    );

    if (enabled ?? true) {
      return container;
    }

    return container.toDisabledOpacity();
  }

  Widget toBottomBarIcon({bool? selected}) {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 4),
        decoration: BoxDecoration(
            color: selected ?? false
                ? const Color(0xFFF1F0F4)
                : Colors.transparent,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: this);
  }

  Expanded toExpanded() {
    return Expanded(child: this);
  }

  Flexible toFlexible() {
    return Flexible(child: this);
  }

  InkWell toClickable({required Function()? onTap}) {
    return InkWell(onTap: onTap, child: this);
  }

  Widget toOpacity({required double opacity}) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }

  Widget toDisabledOpacity({bool disabled = true}) {
    return disabled
        ? Opacity(
            opacity: disabledOpacity,
            child: this,
          )
        : this;
  }
}
