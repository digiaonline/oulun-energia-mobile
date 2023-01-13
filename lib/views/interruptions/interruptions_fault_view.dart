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

class InterruptionsFaultView extends StatefulWidget {
  static const String routePath = '/interruptions/fault';
  static const String routeName = 'interruptions_fault_view';
  const InterruptionsFaultView({super.key});

  @override
  State<InterruptionsFaultView> createState() => _InterruptionsFaultViewState();
}

class _InterruptionsFaultViewState extends State<InterruptionsFaultView> {
  final _titleController = TextEditingController();
  bool _titleError = false;

  final _messageController = TextEditingController();
  bool _messageError = false;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _phoneNumberController = TextEditingController();
  bool _phoneNumberError = false;

  final _emailController = TextEditingController();
  final _emailError = false;

  String _contactMethod = 'phone';

  bool _canContact = true;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      if (_titleController.text.isEmpty) {
        setState(() {
          _titleError = true;
        });
      } else if (_titleError) {
        setState(() {
          _titleError = false;
        });
      }
    });
    _messageController.addListener(() {
      if (_messageController.text.isEmpty) {
        setState(() {
          _messageError = true;
        });
      } else if (_messageError) {
        setState(() {
          _messageError = false;
        });
      }
    });

    _phoneNumberController.addListener(() {
      if (_phoneNumberController.text.isEmpty) {
        setState(() {
          _phoneNumberError = false;
        });
      } else {
        bool isValid =
            RegExp(r'^\+358\d+$').hasMatch(_phoneNumberController.text);
        setState(() {
          _phoneNumberError = isValid;
        });
      }
    });

    // TODO Email validation?
  }

  _sendFaultReport(BuildContext context) {
    context.go(InterruptionsSelectionsView.routePath);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _messageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;

    var canContactOptions = {
      true: 'Yes',
      false: 'No',
    };

    var contactOptions = {
      'phone': 'By phone',
      'email': 'By email',
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
          const SizedBox(height: 32.0),
          Text(
            'Lähetä viesti',
            style: textTheme.headline4?.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: Sizes.inputMargin),
          InputBox(
            inputType: TextInputType.text,
            controller: _titleController,
            hintText: 'Title',
            title: 'Message title',
            showError: _titleError,
            errorText: 'Title is required!',
            multiline: false,
          ),
          InputBox(
            inputType: TextInputType.text,
            controller: _messageController,
            hintText: 'Message',
            title: 'Write a message',
            showError: _messageError,
            errorText: 'Message is required!',
            multiline: true,
          ),
          RadioSelector(
              title: 'Haluatko, että otamme sinuun yhteyttä?',
              selections: canContactOptions,
              target: _canContact,
              onChanged: (dynamic value) {
                setState(() {
                  _canContact = value;
                });
              }),
          RadioSelector(
              title: 'Yhteydenottotapa',
              selections: contactOptions,
              target: _contactMethod,
              onChanged: (dynamic value) {
                setState(() {
                  _contactMethod = value;
                });
              }),
          InputBox(
              inputType: TextInputType.name,
              controller: _firstNameController,
              hintText: 'First name',
              title: 'First name',
              multiline: false),
          InputBox(
              inputType: TextInputType.name,
              controller: _lastNameController,
              hintText: 'Last name',
              title: 'Last name',
              multiline: false),
          InputBox(
              inputType: TextInputType.phone,
              controller: _phoneNumberController,
              hintText: '+3584099999999',
              title: 'Phone number',
              errorText: 'Invalid phone number format',
              showError: _phoneNumberError,
              multiline: false),
          InputBox(
              inputType: TextInputType.emailAddress,
              controller: _emailController,
              hintText: 'Email',
              title: 'Email',
              errorText: 'Invalid email address',
              showError: _emailError,
              multiline: false),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SubmitButton(
                text: 'Lähetä',
                onPressed: () => _sendFaultReport(context),
                invertColors: true,
              )
            ],
          ),
          const SizedBox(height: Sizes.inputMargin)
        ]).withBackgroundColor(Colors.white);
  }
}
