import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/content.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InterruptionsFaultView extends StatelessWidget {
  static const String routePath = '/interruptions/fault';
  static const String routeName = 'interruptions_fault_view';
  const InterruptionsFaultView({super.key});

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var messageController = TextEditingController();
    var firstnameController = TextEditingController();
    var lastnameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();

    var locals = AppLocalizations.of(context)!;

    return Content(
        title: locals.interruptionsViewFaultTitle,
        text: locals.interruptionsViewFaultText,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            height: 104,
            color: const Color(0xFF1360A8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(locals.interruptionsViewFaultElectric,
                        style: textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    Text(
                      '08 5584 3222',
                      style: textTheme.bodyText2?.copyWith(
                        color: Colors.white,
                        height: 1.48,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
                SvgPicture.asset(
                  'assets/icons/support_agent.svg',
                  width: Sizes.bannerIconSize,
                  height: Sizes.bannerIconSize,
                  color: appBarIconColor,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(locals.interruptionsViewFaultHeat,
                        style: textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    Text(
                      '08 5584 3425',
                      style: textTheme.bodyText2?.copyWith(
                        color: Colors.white,
                        height: 1.48,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'Lähetä viesti',
            style: textTheme.headline4,
          ),
          const SizedBox(height: 20.0),
          InputBox(
              controller: titleController, hintText: 'Title*', title: 'Title'),
        ]).withBackgroundColor(Colors.white);
  }
}

class InputBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;

  const InputBox(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: textTheme.headline3),
      const SizedBox(height: 5.0),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textTheme.bodyText2?.copyWith(color: hintTextColor),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: borderColor, width: 1)),
          enabled: true,
          contentPadding: const EdgeInsets.only(left: 10.0, top: 0.0),
          labelStyle: textTheme.bodyText2,
        ),
      ),
    ]);
  }
}
