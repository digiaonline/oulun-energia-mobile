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

  const BaseFullScreenWidget(
      {this.appBarTitle,
      this.title,
      this.additionalTitle,
      this.description,
      this.child,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border.fromBorderSide(BorderSide(
            width: 0.0,
            strokeAlign: StrokeAlign.outside,
            color: Colors.transparent)),
        centerTitle: false,
        title: appBarTitle != null
            ? Text(appBarTitle!,
                style: textTheme.headline2?.copyWith(color: Colors.black))
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
        child: Container(
          padding: const EdgeInsets.fromLTRB(
              Sizes.itemDefaultSpacing,
              Sizes.itemDefaultSpacing / 2,
              Sizes.itemDefaultSpacing,
              Sizes.itemDefaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) Text(title!, style: textTheme.headline1),
              if (additionalTitle != null)
                const SizedBox(height: Sizes.itemDefaultSpacing),
              if (additionalTitle != null)
                Text(additionalTitle!, style: textTheme.headline3),
              if (description != null)
                const SizedBox(height: Sizes.itemDefaultSpacing),
              if (description != null)
                Text(description!, style: textTheme.bodyText1),
              if (child != null)
                const SizedBox(height: Sizes.itemDefaultSpacing),
              if (child != null) child!,
            ],
          ),
        ),
      ),
    ).withWillPopScope(context);
  }
}
