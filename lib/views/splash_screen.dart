import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class SplashScreen extends ConsumerWidget {
  static const String routeName = "splash_screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/splash_logo.svg",
            color: Colors.white,
          ),
          const SizedBox(
            height: Sizes.marginViewBorderSize,
          ),
          SvgPicture.asset("assets/images/oe_logo.svg", color: Colors.white)
        ],
      ).withBackground(),
    );
  }
}
