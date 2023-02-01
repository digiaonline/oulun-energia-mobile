import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertColors;
  final bool disabled;

  const SubmitButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.disabled = false,
      this.invertColors = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: disabled
                ? Colors.white
                : invertColors
                    ? Colors.white
                    : secondaryActiveButtonColor,
            backgroundColor: disabled
                ? borderColor
                : invertColors
                    ? secondaryActiveButtonColor
                    : Colors.white,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            side: BorderSide(
              color: disabled ? Colors.white : secondaryActiveButtonColor,
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: textTheme.displaySmall,
        ),
      ),
    );
  }
}
