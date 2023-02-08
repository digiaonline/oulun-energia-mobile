import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/input_box.dart';
import 'package:oulun_energia_mobile/views/utils/radio_selector.dart';
import 'package:oulun_energia_mobile/views/utils/submit_button.dart';
import 'package:oulun_energia_mobile/views/utils/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendMessageForm extends StatefulWidget {
  final void Function(Map<String, dynamic>, BuildContext) onSubmit;

  const SendMessageForm({super.key, required this.onSubmit});

  @override
  State<SendMessageForm> createState() => _SendMessageFormState();
}

class _SendMessageFormState extends State<SendMessageForm> {
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

  final _expandableController = ExpandableController(initialExpanded: true);

  void validate(String key, String value) {
    bool hasError = false;

    switch (key) {
      case 'title':
      case 'message':
        hasError = value.isEmpty;
        break;
      case 'phoneNumber':
        hasError = Validators.validatePhoneNumber(value);
        break;
      case 'email':
        hasError = Validators.validateEmail(value);
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

    widget.onSubmit(_formState, context);
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locals.sendMessage,
          style:
              textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w400),
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
        )
      ],
    );
  }
}
