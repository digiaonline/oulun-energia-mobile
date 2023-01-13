import 'package:flutter/material.dart';
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
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
