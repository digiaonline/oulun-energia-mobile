import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

class Dropdown extends StatelessWidget {
  final dynamic selectedValue;
  final String title;
  final Function(dynamic) onChanged;
  final List<DropdownMenuItem<dynamic>> items;

  const Dropdown(
      {Key? key,
      required this.selectedValue,
      required this.onChanged,
      required this.items,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
          width: double.infinity,
          child: Text(
            title,
            style: textTheme.headline3,
            textAlign: TextAlign.left,
          ),
        ),
        DropdownButtonFormField<dynamic>(
          isExpanded: true,
          value: selectedValue,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: borderColor, width: 1)),
            enabled: false,
            contentPadding: const EdgeInsets.only(left: 15.0),
            labelStyle: textTheme.bodyText2,
          ),
          icon: const Icon(Icons.expand_more, color: iconColorBlack),
          items: items,
          onChanged: (value) => onChanged,
        ),
      ],
    );
  }
}
