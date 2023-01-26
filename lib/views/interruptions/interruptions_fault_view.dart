import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_selections_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/content.dart';
import 'package:oulun_energia_mobile/views/utils/input_box.dart';
import 'package:oulun_energia_mobile/views/utils/radio_selector.dart';
import 'package:oulun_energia_mobile/views/utils/submit_button.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class InterruptionsFaultView extends StatefulWidget {
  static const String routePath = 'fault';
  static const String routeName = 'fault';
  const InterruptionsFaultView({super.key});

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title':
          AppLocalizations.of(context)?.interruptionsViewFault ?? 'No title',
      'secondaryAppBar': true,
      'initialExpanded': true,
      'hideAppBar': false,
    };
  }

  @override
  State<InterruptionsFaultView> createState() => _InterruptionsFaultViewState();
}

class _InterruptionsFaultViewState extends State<InterruptionsFaultView> {
  final _formState = {
    'title': '',
    'message': '',
    'canContact': true,
    'contactMethod': 'phone',
    'firstName': '',
    'lastName': '',
    'phoneNumber': '',
    'email': ''
  };

  final _formErrorState = {
    'title': true,
    'message': true,
    'phoneNumber': false,
    'email': false
  };

  var emailRegExp = RegExp(
      r'(?:[a-z0-9!#$%&\x27*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\x27*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

  var phoneRegExp = RegExp(r'^\+358\d+$');

  final _expandableController = ExpandableController(initialExpanded: true);

  void validate(String key, String value) {
    bool hasError = false;

    switch (key) {
      case 'title':
      case 'message':
        hasError = value.isEmpty;
        break;
      case 'phoneNumber':
        hasError = value.isEmpty == false && !phoneRegExp.hasMatch(value);
        break;
      case 'email':
        hasError = value.isEmpty == false && !emailRegExp.hasMatch(value);
        break;
      default:
        hasError = false;
        break;
    }

    setState(() {
      _formErrorState[key] = hasError;
    });
  }

  void updateState(String key, dynamic value) {
    setState(() {
      _formState[key] = value;
    });
  }

  bool _canSubmit() => _formErrorState.values
      .firstWhere((element) => element == true, orElse: () => false);

  _submitFaultReport(BuildContext context) {
    bool hasErrors = _canSubmit();

    if (hasErrors) {
      return;
    }

    // TODO Submit report
    // TODO Show success message
    context.go(InterruptionsSelectionsView.routePath);
  }

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;

    _expandableController.expanded = _formState['canContact'] == true;

    var canContactOptions = {
      true: locals.yes,
      false: locals.no,
    };

    var contactOptions = {
      'phone': locals.byPhone,
      'email': locals.byEmail,
    };

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
                    GestureDetector(
                      onTap: () async => launchUrl(Uri.parse('tel:0855843222')),
                      child: Text(
                        '08 5584 3222',
                        style: textTheme.bodyText2?.copyWith(
                          color: Colors.white,
                          height: 1.48,
                          decoration: TextDecoration.underline,
                        ),
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
                    GestureDetector(
                      onTap: () async => launchUrl(Uri.parse('tel:0855843425')),
                      child: Text(
                        '08 5584 3425',
                        style: textTheme.bodyText2?.copyWith(
                          color: Colors.white,
                          height: 1.48,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32.0),
          Text(
            locals.sendMessage,
            style: textTheme.headline4?.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: Sizes.inputMargin),
          InputBox(
              keyboardType: TextInputType.text,
              hintText: locals.messageTitle,
              title: '${locals.title}*',
              showError: _formErrorState['title'],
              errorText: locals.titleError,
              multiline: false,
              onChanged: (value) {
                validate('title', value);
                updateState('title', value);
              }),
          InputBox(
              keyboardType: TextInputType.multiline,
              hintText: locals.writeMessage,
              title: '${locals.message}*',
              showError: _formErrorState['message'],
              errorText: locals.messageError,
              multiline: true,
              onChanged: (value) {
                validate('message', value);
                updateState('message', value);
              }),
          RadioSelector(
              title: locals.contactYou,
              selections: canContactOptions,
              target: _formState['canContact'],
              onChanged: (dynamic value) => updateState('canContact', value)),
          Expandable(
              controller: _expandableController,
              collapsed: const SizedBox(width: double.infinity),
              expanded: Column(
                children: [
                  RadioSelector(
                      title: locals.contactMethod,
                      selections: contactOptions,
                      target: _formState['contactMethod'],
                      onChanged: (dynamic value) {
                        updateState('contactMethod', value);
                      }),
                  InputBox(
                      keyboardType: TextInputType.name,
                      hintText: locals.firstName,
                      title: locals.firstName,
                      multiline: false,
                      onChanged: (value) {
                        updateState('firstName', value);
                      }),
                  InputBox(
                      keyboardType: TextInputType.name,
                      hintText: locals.lastName,
                      title: locals.lastName,
                      multiline: false,
                      onChanged: (value) {
                        updateState('lastName', value);
                      }),
                  InputBox(
                      keyboardType: TextInputType.phone,
                      hintText: '+3584099999999',
                      title: locals.phoneNumber,
                      errorText: locals.phoneNumberError,
                      showError: _formErrorState['phoneNumber'],
                      multiline: false,
                      onChanged: (value) {
                        validate('phoneNumber', value);
                        updateState('phoneNumber', value);
                      }),
                  InputBox(
                      keyboardType: TextInputType.emailAddress,
                      hintText: locals.email,
                      title: locals.email,
                      errorText: locals.emailError,
                      showError: _formErrorState['email'],
                      multiline: false,
                      onChanged: (value) {
                        validate('email', value);
                        updateState('email', value);
                      }),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SubmitButton(
                text: locals.send,
                onPressed: () => _submitFaultReport(context),
                disabled: _canSubmit(),
                invertColors: true,
              )
            ],
          ),
          const SizedBox(height: Sizes.inputMargin)
        ]).withBackgroundColor(Colors.white);
  }
}
