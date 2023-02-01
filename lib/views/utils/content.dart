import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class Content extends StatelessWidget {
  const Content({
    Key? key,
    required this.title,
    required this.text,
    this.image,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;
  final String title;
  final String text;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (image != null) image!,
          // TODO Show the image here if assigned, Container is a placeholder for the image for now
          if (image is SizedBox)
            Container(
              color: Colors.grey,
              width: double.infinity,
              height: 235.0,
            ),
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.itemDefaultSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Sizes.itemDefaultSpacing),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      title,
                      style:
                          textTheme.displayLarge?.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: Sizes.itemDefaultSpacing),
                  Text(
                    text,
                    style: defaultTheme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: Sizes.itemDefaultSpacing),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  ),
                ],
              ))
        ],
      ),
    ).withBackgroundColor(Colors.white);
  }
}
