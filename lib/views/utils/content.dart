import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class Content extends StatelessWidget {
  const Content({
    Key? key,
    required this.title,
    required this.text,
    this.assetName,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;
  final String title;
  final String text;
  final String? assetName;

  getImageAsset(String? assetName) {
    if (assetName == null) {
      return const SizedBox.shrink();
    }

    return Image.asset(assetName, width: double.infinity, fit: BoxFit.fitWidth);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getImageAsset(assetName),
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
