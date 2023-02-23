import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final int _totalSteps = 3;
  var _stepIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;
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
                          left: Sizes.marginViewBorderSizeLarge,
                          right: Sizes.marginViewBorderSizeLarge),
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (value) => setState(() {
                          _stepIndex = value;
                        }),
                        children: [
                          _getViewContent(locals, ref, 0),
                          _getViewContent(locals, ref, 1),
                          _getViewContent(locals, ref, 2),
                        ],
                      )),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => context.go(HomeView.routePath),
                      child: Container(
                        margin: Sizes.marginViewBorder,
                        child: Text(
                          locals.firstTimeViewBypass,
                          style: textTheme.bodyMedium,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: StepProgressIndicator(
                      totalSteps: _totalSteps,
                      currentStep: _stepIndex,
                      size: Sizes.mainViewIconSize,
                      selectedSize: Sizes.mainViewIconSize,
                      roundedEdges:
                          const Radius.circular(Sizes.stepIndicatorIconSize),
                      customStep: (index, color, __) => Icon(
                        Icons.circle,
                        size: Sizes.mainViewIconSize,
                        color: _stepIndex == index
                            ? ftuNavigationSelected
                            : ftuNavigationUnSelected,
                      ),
                    ),
                  ),
                  if (_stepIndex != _totalSteps - 1)
                    TextButton(
                        onPressed: () {
                          _pageController.animateToPage(_stepIndex + 1,
                              curve: Curves.linear,
                              duration: const Duration(milliseconds: 300));
                        },
                        child: Text(locals.firstTimeViewNext))
                ],
              ),
            )
          ],
        ),
      ),
    ).withBackground();
  }

  Widget _getViewContent(
      AppLocalizations locals, WidgetRef ref, int stepIndex) {
    var stepItem = _getStepData(locals, stepIndex);
    return _buildStep(
      ref,
      context: context,
      titlePartOne: stepItem['titlePartOne']!,
      titlePartTwo: stepItem['titlePartTwo']!,
      description: stepItem['description'],
      iconArea: stepItem['iconArea']!,
      step: stepIndex,
    );
  }

  Widget _buildStep(WidgetRef ref,
      {required BuildContext context,
      required String titlePartOne,
      required String titlePartTwo,
      required String? description,
      required Widget iconArea,
      required int step}) {
    Widget? content =
        _getStepAdditionalContent(AppLocalizations.of(context)!, ref, step);
    var textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.center, child: iconArea).toExpanded(),
            const SizedBox(
              height: Sizes.marginViewBorderSize,
            ),
            Text(
              titlePartOne,
              maxLines: 1,
              style: textTheme.displayLarge,
            ),
            Text(
              titlePartTwo,
              maxLines: 2,
              style: textTheme.headlineLarge,
            ),
            if (description != null)
              const SizedBox(
                height: Sizes.marginViewBorderSize,
              ),
            if (description != null)
              Text(
                "$description\n\n\n",
                maxLines: 4,
                style: textTheme.bodyLarge,
              ),
            if (content != null) content,
          ],
        ),
      ),
    );
  }

  _getStepAdditionalContent(AppLocalizations locals, WidgetRef ref, int step) {
    if (step == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: Sizes.marginViewBorderSize,
          ),
          TextButton(
            style: secondaryButtonStyle,
            onPressed: () => context.goNamed(HomeView.routeName),
            child: Text(
              locals.firstTimeViewContinueWOLogin,
              style: secondaryButtonStyle.textStyle?.resolve({}),
            ),
          ),
          const SizedBox(
            height: Sizes.marginViewBorderSizeSmall,
          ),
          TextButton(
            style: primaryButtonStyle,
            onPressed: () => context.goNamed(LoginView.routeName),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Text(locals.firstTimeViewLogin,
                  style: primaryButtonStyle.textStyle?.resolve({})),
            ),
          ),
        ],
      );
    }
    return null;
  }

  Map<String, dynamic> _getStepData(AppLocalizations locals, int stepIndex) {
    List<Map<String, dynamic>> stepData = [
      {
        "titlePartOne": locals.firstTimeViewEnergyTitlePartOne,
        "titlePartTwo": locals.firstTimeViewEnergyTitlePartTwo,
        "description": locals.firstTimeViewEnergyDescription,
        "iconArea": SvgPicture.asset(
          'assets/images/ft_energy.svg',
          width: 318,
          height: 318,
        ),
      },
      {
        "titlePartOne": locals.firstTimeViewInterruptionsTitlePartOne,
        "titlePartTwo": locals.firstTimeViewInterruptionTitlePartTwo,
        "description": locals.firstTimeViewInterruptionsDescription,
        "iconArea": SvgPicture.asset(
          'assets/images/ft_energy.svg',
          width: 318,
          height: 318,
        ),
      },
      {
        "titlePartOne": locals.firstTimeViewContactsTitlePartOne,
        "titlePartTwo": locals.firstTimeViewContactsTitlePartTwo,
        "iconArea": SvgPicture.asset(
          'assets/images/ft_energy.svg',
          width: 318,
          height: 318,
        ),
      },
    ];

    return stepData[stepIndex];
  }
}
