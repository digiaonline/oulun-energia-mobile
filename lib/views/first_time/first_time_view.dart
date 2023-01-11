import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/providers/app_state.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:swipe/swipe.dart';

import '../main/main_view.dart';

class FirstTimeView extends ConsumerStatefulWidget {
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
    var appStateNotifier = ref.read(appStateProvider.notifier);
    var step = _stepIndex;
    var sliverChild = _getViewContent(ref, step);
    var content = SliverFillRemaining(child: sliverChild);
    return Scaffold(
      body: Swipe(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: null,
              automaticallyImplyLeading: false,
              actions: [
                InkWell(
                  onTap: () => appStateNotifier.toMainView(),
                  child: Container(
                    margin: Sizes.marginViewBorder,
                    child: Text(
                      "Ohita",
                      style: textTheme.bodyText2?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            content,
          ],
        ).withBackground(),
        onSwipeLeft: () {
          if (_stepIndex < 2) {
            setState(() {
              _stepIndex += 1;
            });
          }
        },
        onSwipeRight: () {
          if (_stepIndex > 0) {
            setState(() {
              _stepIndex -= 1;
            });
          }
        },
      ),
    );
  }

  Widget _getViewContent(WidgetRef ref, int stepIndex) {
    var step = _stepIndex;
    var stepItem = stepData[step];
    return _buildStep(
      ref,
      context: context,
      title: stepItem['title']!,
      description: stepItem['description']!,
      iconArea: stepItem['iconArea']!,
      step: step,
    );
  }

  List<Map<String, dynamic>> stepData = [
    {
      "title": "Keskeytykset kartalla ja tiedotteina",
      "description":
          "Löydät nopeasti tiedon mahdollisista sähkön- ja lämmönjakelun keskeytyksistä",
      "iconArea": buildHomeViewButton(
        "Keskeytys-kartta",
        'assets/icons/news.svg',
        onTap: () => {},
      ),
    },
    {
      "title": "Kaikki yhteystiedot sovelluksessa",
      "description":
          "Oulun Energian asiakaspalvelu auttaa sinua kaikissa sähköä ja lämpöä sekä niiden laskutusta koskevissa kysymyksissä",
      "iconArea": buildHomeViewButton(
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
        "Omat kulutustiedot",
        'assets/icons/monitoring.svg',
        onTap: () => {},
        marker: const Icon(
          Icons.lock_outline,
          size: 14,
        ),
      ),
    },
  ];

  Widget _buildStep(WidgetRef ref,
      {required BuildContext context,
      required String title,
      required String description,
      required Widget iconArea,
      required int step}) {
    Widget? content = _getStepAdditionalContent(ref, step);
    var textTheme = Theme.of(context).textTheme;
    return Container(
      margin: Sizes.marginViewBorder,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$title\n\n",
                  maxLines: 3,
                  style: textTheme.headline1?.copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: Sizes.marginViewBorderSize,
                ),
                Text(
                  "$description\n\n\n",
                  maxLines: 4,
                  style: textTheme.bodyText1?.copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: Sizes.marginViewBorderSize,
                ),
                iconArea,
                content ?? const SizedBox.shrink(),
                const SizedBox(
                  height: Sizes.marginViewBorderSize,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: StepProgressIndicator(
              totalSteps: 3,
              currentStep: step,
              size: Sizes.mainViewIconSize,
              selectedSize: Sizes.mainViewIconSize,
              roundedEdges: const Radius.circular(Sizes.mainViewIconSize / 2),
              customStep: (index, color, __) => Icon(
                Icons.circle,
                size: Sizes.mainViewIconSize,
                color: step == index
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFF1A4590),
              ),
            ),
          ),
        ],
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
            onPressed: () => ref.read(appStateProvider.notifier).toMainView(),
            child: Text(
              "Jatka ilman kirjautumista",
              style: defaultTheme.textTheme.bodyText1
                  ?.copyWith(color: Colors.white),
            ),
          ).toButton(),
          const SizedBox(
            height: Sizes.marginViewBorderSize,
          ),
          TextButton(
            onPressed: () => ref.read(appStateProvider.notifier).toLoginView(),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Text(
                "Kirjaudu",
                style: defaultTheme.textTheme.bodyText1
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
                defaultTheme.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
        ],
      );
    }
    return null;
  }
}
