import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_view.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/send_message_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ContactUsSendMessageView extends StatelessWidget {
  static const String routePath = 'send_message';
  static const String routeName = 'send_message';

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title': AppLocalizations.of(context)?.sendMessage,
      'secondaryAppBar': true,
      'initialExpanded': true,
      'hideAppBar': false,
    };
  }

  void onSubmit(Map<String, dynamic> formState, BuildContext context) {
    // TODO Submit
    // TODO Show success message
    context.goNamed(ContactUsView.routeName);
  }

  const ContactUsSendMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.itemDefaultSpacing),
      color: Colors.white,
      child: SingleChildScrollView(
        child: SendMessageForm(onSubmit: onSubmit),
      ),
    );
  }
}
