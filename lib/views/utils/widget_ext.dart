import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget withBackground() {
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

  Widget toButton() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.cyan,
      ),
      child: this,
    );
  }
}
