import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class ContactUsView extends StatelessWidget {
  static String routePath = '/contact_us';
  static String routeName = 'contact_selections_view';

  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('TODO Contact us'))
        .withBackgroundColor(Colors.white);
  }
}
