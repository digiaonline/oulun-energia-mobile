import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class BaseFullScreenWidget extends ConsumerWidget {
  final String? appBarTitle;
  final String? title;
  final String? additionalTitle;
  final String? description;
  final Widget? child;
  final Widget? header;

  const BaseFullScreenWidget(
      {this.appBarTitle,
      this.title,
      this.additionalTitle,
      this.description,
      this.child,
      this.header,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const Border.fromBorderSide(BorderSide(
            width: 0.0,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Colors.transparent)),
        centerTitle: false,
        title: appBarTitle != null
            ? Text(appBarTitle!,
                style: textTheme.displayMedium?.copyWith(color: Colors.black))
            : null,
        iconTheme: appBarIconThemeSecondary,
        leading: InkWell(
          onTap: () {
            String? backRouteName = GoRouterState.of(context).extra as String?;
            if (backRouteName != null) {
              context.go(backRouteName);
            } else if (context.canPop()) {
              context.pop();
            }
          },
          child: const Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          if (header != null) header!,
          Container(
            padding: const EdgeInsets.fromLTRB(
                Sizes.itemDefaultSpacing,
                Sizes.itemDefaultSpacing / 2,
                Sizes.itemDefaultSpacing,
                Sizes.itemDefaultSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  const SizedBox(height: Sizes.itemDefaultSpacing),
                if (title != null) Text(title!, style: textTheme.displayLarge),
                if (additionalTitle != null)
                  const SizedBox(height: Sizes.itemDefaultSpacing),
                if (additionalTitle != null)
                  Text(additionalTitle!, style: textTheme.displaySmall),
                if (description != null)
                  const SizedBox(height: Sizes.itemDefaultSpacing),
                if (description != null)
                  Text(description!, style: textTheme.bodyLarge),
                if (child != null)
                  const SizedBox(height: Sizes.itemDefaultSpacing),
                if (child != null) child!,
              ],
            ),
          ),
        ]),
      ),
    ).withWillPopScope(context);
  }
}
