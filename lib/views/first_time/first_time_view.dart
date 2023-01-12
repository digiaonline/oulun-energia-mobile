import 'package:carousel_slider/carousel_slider.dart';
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
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;
    const double bottomBarHeight = 80;
    final double paddingTop = MediaQuery.of(context).padding.top;
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    final double toolbarHeight =
        theme.appBarTheme.toolbarHeight ?? kToolbarHeight;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double height = screenHeight -
        paddingTop -
        toolbarHeight -
        paddingBottom -
        bottomBarHeight;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: Sizes.marginViewBorderSizeLarge * 2),
                height: height,
                child: CarouselSlider.builder(
                  itemCount: stepData.length,
                  itemBuilder: (context, index, realIndex) {
                    return _getViewContent(ref, index);
                  },
                  options: CarouselOptions(
                      onPageChanged: (index, reason) => setState(() {
                            _stepIndex = index;
                          }),
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      enlargeFactor: 1,
                      height: screenHeight),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => context.go(HomeView.routePath),
                  child: Container(
                    margin: Sizes.marginViewBorder
                        .copyWith(top: Sizes.marginViewBorderSizeLarge),
                    child: Text(
                      "Ohita",
                      style: textTheme.bodyText2?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: bottomBarHeight,
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
    return Container(
      margin: Sizes.marginViewBorder,
      child: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$title\n\n",
                maxLines: 2,
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
              iconArea.toExpanded(),
              content ?? const SizedBox.shrink(),
            ],
          ),
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
            onPressed: () => context.go(HomeView.routePath),
            child: Text(
              "Jatka ilman kirjautumista",
              style: defaultTheme.textTheme.bodyText1
                  ?.copyWith(color: buttonPrimaryBackground),
            ),
          ).toButton(secondary: true),
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
