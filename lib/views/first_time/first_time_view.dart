import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/providers/app_state.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/main/main_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:swipe/swipe.dart';

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
                  onTap: () => context.go(MainView.routePath),
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
        ).withBackground(true),
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
      context,
      stepItem['title']!,
      stepItem['description']!,
      stepItem['iconText']!,
      step,
    );
  }

  var stepData = [
    {
      "title": "Keskeytykset kartalla ja tiedotteina",
      "description":
          "Löydät nopeasti tiedon mahdollisista sähkön- ja lämmönjakelun keskeytyksistä",
      "iconText": "Keskeytys-kartta",
    },
    {
      "title": "Kaikki yhteystiedot sovelluksessa",
      "description":
          "Oulun Energian asiakaspalvelu auttaa sinua kaikissa sähköä ja lämpöä sekä niiden laskutusta koskevissa kysymyksissä",
      "iconText": "Ota yhteyttä",
    },
    {
      "title": "Omat energian kulutustiedot",
      "description":
          "Kun tunnistaudut Oulun Energian mobiilisovelluksen käyttäjäksi, pääset seuraamaan helposti energiankulutustasi",
      "iconText": "Omat kulutustiedot",
    },
  ];

  Widget _buildStep(WidgetRef ref, BuildContext context, String title,
      String description, String iconText, int step) {
    Widget? content = _getStepAdditionalContent(ref, step);
    var textTheme = Theme.of(context).textTheme;
    return Container(
      margin: Sizes.marginViewBorder,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                title,
                style: textTheme.headline1?.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: Sizes.marginViewBorderSize,
              ),
              Text(
                description,
                style: textTheme.bodyText1?.copyWith(color: Colors.white),
              )
            ],
          ),
          Column(
            children: [
              const Icon(Icons.stacked_bar_chart_outlined, size: 60),
              const SizedBox(
                height: Sizes.marginViewBorderSize,
              ),
              Text(
                iconText,
                style: textTheme.headline2?.copyWith(color: Colors.white),
              ),
              content ?? const SizedBox.shrink()
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 100,
                child: StepProgressIndicator(
                  totalSteps: 3,
                  currentStep: step,
                  size: 20,
                  selectedSize: 20,
                  roundedEdges: const Radius.circular(10),
                  customStep: (index, color, __) => Icon(
                    Icons.circle,
                    size: 20,
                    color: step == index
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF1A4590),
                  ),
                ),
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
            onPressed: () => context.go(MainView.routePath),
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
            onPressed: () => context.go(LoginView.routePath),
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
