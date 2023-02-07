import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/main/home_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class FirstTimeView extends ConsumerStatefulWidget {
  static const String routePath = '/first_time';
  static const String routeName = "first_time";

  const FirstTimeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return FtuState();
  }
}

class FtuState extends ConsumerState<FirstTimeView> {
  var _stepIndex = 0;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.only(
                          top: Sizes.marginViewBorderSizeLarge * 2,
                          left: Sizes.marginViewBorderSize,
                          right: Sizes.marginViewBorderSize),
                      child: PageView(
                        onPageChanged: (value) => setState(() {
                          _stepIndex = value;
                        }),
                        children: [
                          _getViewContent(ref, 0),
                          _getViewContent(ref, 1),
                          _getViewContent(ref, 2),
                        ],
                      )),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => context.go(HomeView.routePath),
                      child: Container(
                        margin: Sizes.marginViewBorder,
                        child: Text(
                          "Ohita",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              padding: Sizes.marginViewBorder,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: StepProgressIndicator(
                    totalSteps: 3,
                    currentStep: _stepIndex,
                    size: Sizes.mainViewIconSize,
                    selectedSize: Sizes.mainViewIconSize,
                    roundedEdges:
                        const Radius.circular(Sizes.mainViewIconSize / 2),
                    customStep: (index, color, __) => Icon(
                      Icons.circle,
                      size: Sizes.mainViewIconSize,
                      color: _stepIndex == index
                          ? ftuNavigationSelected
                          : ftuNavigationUnSelected,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ).withBackground();
  }

  Widget _getViewContent(WidgetRef ref, int stepIndex) {
    var stepItem = stepData[stepIndex];
    return _buildStep(
      ref,
      context: context,
      title: stepItem['title']!,
      description: stepItem['description']!,
      iconArea: stepItem['iconArea']!,
      step: stepIndex,
    );
  }

  Widget _buildStep(WidgetRef ref,
      {required BuildContext context,
      required String title,
      required String description,
      required Widget iconArea,
      required int step}) {
    Widget? content = _getStepAdditionalContent(ref, step);
    var textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$title\n\n",
              maxLines: 2,
              style: textTheme.displayLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: Sizes.marginViewBorderSize,
            ),
            Text(
              "$description\n\n\n",
              maxLines: 4,
              style: textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: Sizes.marginViewBorderSize,
            ),
            iconArea.toExpanded(),
            content ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  _getStepAdditionalContent(WidgetRef ref, int step) {
    if (step == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: Sizes.marginViewBorderSizeLarge,
          ),
          TextButton(
            onPressed: () => context.goNamed(HomeView.routeName),
            child: Text(
              "Jatka ilman kirjautumista",
              style: defaultTheme.textTheme.bodyLarge
                  ?.copyWith(color: buttonPrimaryBackground),
            ),
          ).toButton(secondary: true),
          const SizedBox(
            height: Sizes.marginViewBorderSize,
          ),
          TextButton(
            onPressed: () => context.goNamed(LoginView.routeName),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Text(
                "Kirjaudu",
                style: defaultTheme.textTheme.bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ).toButton(),
          const SizedBox(
            height: Sizes.marginViewBorderSize,
          ),
          Text(
            "Kirjautumalla palveluun pääset seuraamaan energiankulutustasi ",
            textAlign: TextAlign.center,
            style:
                defaultTheme.textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
        ],
      );
    }
    return null;
  }

  List<Map<String, dynamic>> stepData = [
    {
      "title": "Keskeytykset kartalla ja tiedotteina",
      "description":
          "Löydät nopeasti tiedon mahdollisista sähkön- ja lämmönjakelun keskeytyksistä",
      "iconArea": buildHomeViewButton(
        avatarSize: Sizes.mainViewIconAvatarSize * 2,
        fontSize: 20,
        iconSize: 56,
        "Keskeytys-kartta",
        'assets/icons/fmd_bad.svg',
        onTap: () => {},
      ),
    },
    {
      "title": "Kaikki yhteystiedot sovelluksessa",
      "description":
          "Oulun Energian asiakaspalvelu auttaa sinua kaikissa sähköä ja lämpöä sekä niiden laskutusta koskevissa kysymyksissä",
      "iconArea": buildHomeViewButton(
        avatarSize: Sizes.mainViewIconAvatarSize * 2,
        fontSize: 20,
        iconSize: 56,
        "Ota yhteyttä",
        'assets/icons/support_agent.svg',
        onTap: () => {},
      ),
    },
    {
      "title": "Omat energian kulutustiedot",
      "description":
          "Kun tunnistaudut Oulun Energian mobiilisovelluksen käyttäjäksi, pääset seuraamaan helposti energiankulutustasi",
      "iconArea": buildHomeViewButton(
        avatarSize: Sizes.mainViewIconAvatarSize * 2,
        fontSize: 20,
        iconSize: 56,
        "Omat kulutustiedot",
        'assets/icons/monitoring.svg',
        onTap: () => {},
        marker: const Icon(
          Icons.lock_outline,
          size: 28,
        ),
      ),
    },
  ];
}
