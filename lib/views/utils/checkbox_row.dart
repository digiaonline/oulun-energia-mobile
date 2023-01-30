import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';

class CheckboxRow extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool value;
  final void Function(bool?) onChanged;

  const CheckboxRow({
    super.key,
    required this.value,
    required this.onChanged,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.inputMargin),
      child: Row(
        children: [
          Checkbox(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              side: color == null
                  ? null
                  : MaterialStateBorderSide.resolveWith(
                      (states) => BorderSide(width: 1.5, color: color!),
                    ),
              checkColor: color == null ? null : color!,
              value: value,
              onChanged: onChanged),
          const SizedBox(width: 8.0),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
