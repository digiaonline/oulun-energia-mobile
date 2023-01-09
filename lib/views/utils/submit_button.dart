import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertColors;

  const SubmitButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.invertColors = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor:
                invertColors ? Colors.white : secondaryActiveButtonColor,
            backgroundColor:
                invertColors ? secondaryActiveButtonColor : Colors.white,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            side: const BorderSide(
              color: secondaryActiveButtonColor,
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: textTheme.headline3,
        ),
      ),
    );
  }
}
