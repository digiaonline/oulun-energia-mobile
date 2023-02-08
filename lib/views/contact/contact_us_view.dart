import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_send_message_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_fault_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/content.dart';
import 'package:oulun_energia_mobile/views/utils/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

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
    var locals = AppLocalizations.of(context)!;

    return Content(
      assetName: 'assets/images/contact_us_header.webp',
      title: locals.contactUs,
      text: locals.contactUsCustomerServiceInfo,
      children: [
        Text(
          locals.contactUsCustomerService,
          style:
              textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w400),
        ),
        const InfoBox(
          title: 'Oulun Energia Sähköverkko Oy',
          email: 'sahkoverkkopalvelut@aspa.oulunenergia.fi',
          phonenumber: '08 477 000',
        ),
        InfoBox(
          title: 'Oulun Energia Oy, ${locals.districtHeating}',
          email: 'lampopalvelut@aspa.oulunenergia.fi',
          phonenumber: '08 577 5110',
          info: locals.contactUsPhoneServiceInfo,
        ),
        InfoBox(
          title: locals.contactUsElectricAdvice,
          email: 'tekninenneuvonta@oulunenergia.fi',
          phonenumber: '040 712 8606',
        ),
        const SizedBox(height: Sizes.itemDefaultSpacingLarge),
        Text(
          locals.interruptionsViewFaultTitle,
          style:
              textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w400),
        ),
        const FaultServiceInfo(),
        const SizedBox(height: Sizes.itemDefaultSpacingLarge),
        Text(
          locals.contactUsPaymentAdvice,
          style:
              textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w400),
        ),
        Text(
          locals.contactUsPaymentAdviceInfo,
          style: textTheme.bodyMedium,
        ),
        const InfoBox(
          title: 'Oulun Energia Sähköverkko Oy',
          phonenumber: '09 4246 1342',
        ),
        InfoBox(
          title: 'Oulun Energia Oy, ${locals.districtHeating}',
          phonenumber: '09 4246 1341',
        ),
        InfoBox(
          title: locals.contactUsRopoCapital,
          link: 'ropo-online.fi',
          info: locals.contactUsRopoCapitalServiceInfo,
        ),
        const SizedBox(height: Sizes.itemDefaultSpacing),
        Text(
          locals.contactUsContactInformation,
          style:
              textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w400),
        ),
        const InfoBox(
          title: 'Oulun Energia Oy',
          address: 'Nahkatehtaankatu 2\nPL 116, 90101 Oulu',
          email: 'info@oulunenergia.fi',
          phonenumber: '08 5574 3300',
          info: 'y-tunnus: 0989376-5',
        ),
        InfoBox(
          title: locals.contactUsMapService,
          address: locals.contactUsCableAndHeatmaps,
          phonenumber: '044 703 3239',
          email: 'karttapalvelu@oulunenergia.fi',
        ),
        const SizedBox(height: Sizes.itemDefaultSpacing),
        Container(
          margin: const EdgeInsets.only(top: Sizes.itemDefaultSpacing),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.singelineInputboxHeight,
              horizontal: Sizes.itemDefaultSpacing),
          decoration: const BoxDecoration(color: containerColor),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/robot.svg',
                width: 101.0,
                height: 89.8,
              ),
              const SizedBox(height: Sizes.itemDefaultSpacing),
              Text(
                locals.contactUsNonUrgent,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: Sizes.itemDefaultSpacing),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  locals.contactUsNonUrgentInfo,
                  style: textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: Sizes.itemDefaultSpacing),
              SubmitButton(
                text: locals.sendMessage,
                onPressed: () =>
                    context.goNamed(ContactUsSendMessageView.routeName),
                invertColors: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final String? address;
  final String? email;
  final String? phonenumber;
  final String? link;
  final String? info;

  const InfoBox(
      {super.key,
      required this.title,
      this.address,
      this.email,
      this.link,
      this.phonenumber,
      this.info});

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(top: Sizes.itemDefaultSpacing),
      width: double.infinity,
      padding: const EdgeInsets.all(Sizes.itemDefaultSpacing),
      decoration: const BoxDecoration(color: containerColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (address != null)
            Text(
              address!,
              style: textTheme.bodyMedium,
            ),
          if (link != null)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async => await launchUrl(
                            Uri.parse('https://$link'),
                            mode: LaunchMode.externalApplication,
                          ),
                    text: link,
                    style: textTheme.bodyMedium?.copyWith(
                      color: secondaryActiveButtonColor,
                      decorationColor: secondaryActiveButtonColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          if (email != null)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async => await launchUrl(
                            Uri.parse('mailto:$email'),
                          ),
                    text: email,
                    style: textTheme.bodyMedium?.copyWith(
                      color: secondaryActiveButtonColor,
                      decorationColor: secondaryActiveButtonColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          if (phonenumber != null)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: '${locals.phoneNumber}: ',
                      style: textTheme.bodyMedium),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async => await launchUrl(
                            Uri.parse('tel:$phonenumber'),
                          ),
                    text: phonenumber,
                    style: textTheme.bodyMedium?.copyWith(
                      color: secondaryActiveButtonColor,
                      decorationColor: secondaryActiveButtonColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: ' (mpm/pvm)',
                    style: textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          if (info != null)
            Text(
              info!,
              style: textTheme.bodyMedium,
            )
        ],
      ),
    );
  }
}
