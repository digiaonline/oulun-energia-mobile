import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';

class InputBox extends StatelessWidget {
  final String hintText;
  final String title;
  final TextInputType inputType;
  final bool? showError;
  final String? errorText;
  final bool multiline;

  final void Function(String) onChanged;

  const InputBox(
      {super.key,
      required this.hintText,
      required this.title,
      required this.inputType,
      required this.onChanged,
      this.showError,
      this.errorText,
      required this.multiline});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: textTheme.headline3),
      const SizedBox(height: 6.0),
      SizedBox(
        // 144
        height: multiline
            ? (showError != null && showError == true)
                ? 168
                : 144
            : (showError != null && showError == true)
                ? 72
                : 48,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: onChanged,
          keyboardType: inputType,
          minLines: multiline ? null : 1,
          maxLines: multiline ? 20 : 1,
          decoration: InputDecoration(
            errorText: (showError == true) ? errorText : null,
            hintText: hintText,
            hintStyle: textTheme.bodyText1?.copyWith(color: hintTextColor),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            enabled: true,
            contentPadding: const EdgeInsets.only(left: 16.0, top: 16.0),
            labelStyle: textTheme.bodyText2,
          ),
        ),
      ),
      SizedBox(
          height: (showError != null && showError == true)
              ? 0.0
              : Sizes.inputMargin),
    ]);
  }
}
