import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget withBackground(bool show) {
    if (!show) {
      return SizedBox(child: this);
    }
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xff3993D6),
              Color(0xff030B5C),
            ],
            // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: this);
  }

  Widget toButton({bool? secondary}) {
    return Container(
      decoration: BoxDecoration(
        border: secondary != null ? Border.all(color: Colors.cyan) : null,
        shape: BoxShape.rectangle,
        color: secondary != null ? Colors.transparent : Colors.cyan,
      ),
      child: this,
    );
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
}
