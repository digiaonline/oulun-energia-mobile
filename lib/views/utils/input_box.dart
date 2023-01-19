import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';

class InputBox extends StatelessWidget {
  final String hintText;
  final String title;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final bool enableSuggestions;
  final bool obscureText;
  final Iterable<String> autofillHints;
  final bool? showError;
  final String? errorText;
  final bool multiline;
  final OutlineInputBorder? border;
  final TextEditingController? controller;

  final void Function(String)? onChanged;

  const InputBox(
      {super.key,
      required this.hintText,
      required this.title,
      required this.keyboardType,
      this.onChanged,
      this.textStyle,
      this.showError,
      this.errorText,
      this.controller,
      this.border,
      this.enableSuggestions = false,
      this.obscureText = false,
      this.autofillHints = const [],
      required this.multiline});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: textStyle ?? textTheme.headline3),
      const SizedBox(height: 6.0),
      SizedBox(
        height: multiline
            ? (showError != null && showError == true)
                ? Sizes.multilineInputboxHeightError
                : Sizes.multilineInputboxHeight
            : (showError != null && showError == true)
                ? Sizes.singelineInputboxHeightError
                : Sizes.singelineInputboxHeight,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          enableSuggestions: enableSuggestions,
          autofillHints: autofillHints,
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: keyboardType,
          minLines: multiline ? null : 1,
          maxLines: multiline ? 20 : 1,
          decoration: InputDecoration(
            enabledBorder: border,
            focusedBorder: border,
            errorText: (showError == true) ? errorText : null,
            hintText: hintText,
            enabled: true,
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
