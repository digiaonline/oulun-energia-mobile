import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';

class RadioSelector extends StatelessWidget {
  final Map<dynamic, String> selections;
  final String title;
  final dynamic target;
  final dynamic Function(dynamic) onChanged;

  const RadioSelector(
      {super.key,
      required this.title,
      required this.selections,
      required this.target,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.bodyText2,
        ),
        const SizedBox(height: 6.0),
        ...selections.entries
            .map((entry) => SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: entry.key,
                        groupValue: target,
                        onChanged: onChanged,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        entry.value,
                        style: textTheme.headline3,
                      ),
                    ],
                  ),
                ))
            .toList(),
        const SizedBox(height: Sizes.inputMargin),
      ],
    );
  }
}
