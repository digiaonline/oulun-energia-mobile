import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/views/base/base_fullscreen_widget.dart';
import 'package:oulun_energia_mobile/views/terms/service_terms.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/checkbox_row.dart';
import 'package:oulun_energia_mobile/views/utils/input_box.dart';
import 'package:oulun_energia_mobile/views/utils/submit_button.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/utils/validators.dart';

class NewsletterView extends StatefulWidget {
  static const String routeName = 'newsletter';
  static const String routePath = 'newsletter';

  static Map<String, dynamic> getSettings() {
    return {
      'title': '',
      'secondaryAppBar': false,
      'secondaryAppBarStyle': false,
      'initialExpanded': false,
      'hideAppBar': true,
    };
  }

  const NewsletterView({super.key});

  @override
  State<NewsletterView> createState() => _NewsletterViewState();
}

class _NewsletterViewState extends State<NewsletterView> {
  Map<String, dynamic> formState = {
    'districtHeatingNews': false,
    'electricityNews': false,
    'recycleNews': false,
    'acceptTerms': false,
    'email': ''
  };

  bool emailError = true;

  bool _isDisabled() {
    bool hasOneSelected = formState['districtHeatingNews'] ||
        formState['electricityNews'] ||
        formState['recycleNews'];
    bool acceptTerms = formState['acceptTerms'];
    return !(hasOneSelected && acceptTerms && !emailError);
  }

  void onChange(String name, bool? value) {
    setState(() {
      formState[name] = !formState[name]!;
    });
  }

  void onChangeEmail(String value) {
    setState(() {
      formState['email'] = value;
      emailError = Validators.validateEmail(value);
    });
  }

  void submit(BuildContext context) {
    if (_isDisabled()) {
      return;
    }

    // TODO submit information to backend
    // TODO show snackbar/toast

    if (context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;
    return BaseFullScreenWidget(
        appBarTitle: locals.newsletterViewTitle,
        description: locals.newsletterViewText,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(locals.homeViewOrderNewsletter, style: textTheme.displaySmall),
            const SizedBox(height: 6.0),
            Column(
              children: [
                CheckboxRow(
                  value: formState['districtHeatingNews']!,
                  onChanged: (value) => onChange('districtHeatingNews', value),
                  child: Text(
                    locals.newsletterViewDistrictHeatingNews,
                    style: textTheme.bodyLarge,
                  ),
                ),
                CheckboxRow(
                  value: formState['electricityNews']!,
                  onChanged: (value) => onChange('electricityNews', value),
                  child: Text(
                    locals.newsletterViewElectricityNews,
                    style: textTheme.bodyLarge,
                  ),
                ),
                CheckboxRow(
                  value: formState['recycleNews']!,
                  onChanged: (value) => onChange('recycleNews', value),
                  child: Text(
                    locals.newsletterViewRecyclingNews,
                    style: textTheme.bodyLarge,
                  ),
                ),
                CheckboxRow(
                  value: formState['acceptTerms']!,
                  onChanged: (value) => onChange('acceptTerms', value),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: locals.newsletterViewAcceptTermsPrefix,
                          style: textTheme.bodyLarge,
                        ),
                        TextSpan(
                          text: locals.newsletterViewAcceptTerms,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.goNamed(
                                ServiceTermsView.routeName,
                                extra: GoRouter.of(context).location),
                          style: textTheme.bodyLarge?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: locals.newsletterViewAcceptTermsPostfix,
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                InputBox(
                  hintText: locals.email,
                  title: '${locals.email} *',
                  keyboardType: TextInputType.emailAddress,
                  multiline: false,
                  showError: emailError,
                  errorText: locals.emailError,
                  onChanged: (value) => onChangeEmail(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SubmitButton(
                      invertColors: true,
                      text: locals.homeViewOrderNewsletter,
                      onPressed: () => submit(context),
                      disabled: _isDisabled(),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.inputMargin),
                Text(
                  locals.newsletterViewCancellation,
                  style: kFontSize12W400,
                )
              ],
            )
          ],
        ));
  }
}
