// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OEWebView extends StatelessWidget {
  final WebViewController controller =
      WebViewController.fromPlatformCreationParams(
          const PlatformWebViewControllerCreationParams());

  OEWebView({super.key});

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse(args['url']!));
    final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
      Factory(() => EagerGestureRecognizer())
    };

    return WillPopScope(
      child: Scaffold(
        body: WebViewWidget(
          controller: controller,
          gestureRecognizers: gestureRecognizers,
        ),
      ),
      onWillPop: () async {
        String? backRoutePath = GoRouterState.of(context).extra as String?;
        if (backRoutePath != null) {
          context.pop();
          context.go(backRoutePath);
          return false;
        }
        return true;
      },
    );
  }
}
