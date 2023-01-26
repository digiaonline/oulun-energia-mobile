import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class ContactUsView extends StatelessWidget {
  static const String routePath = 'contact_us';
  static const String routeName = 'contact_us';

  const ContactUsView({Key? key}) : super(key: key);

  static Map<String, dynamic> getSettings() {
    return {
      'title': '',
      'secondaryAppBar': false,
      'secondaryAppBarStyle': true,
      'initialExpanded': true,
      'hideAppBar': false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('TODO Contact us'))
        .withBackgroundColor(Colors.white);
  }
}
