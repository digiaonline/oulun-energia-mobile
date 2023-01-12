import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/selection_button.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';
import 'package:oulun_energia_mobile/views/utils/content.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

class UsageSelectionsView extends StatelessWidget {
  static const String routePath = '/usage';
  static const String routeName = 'usage_selections_view';

  const UsageSelectionsView({Key? key}) : super(key: key);

  void onChangePage(BuildContext context, String routeName) =>
      Navigator.of(context).pushNamed(routeName);

  final String bodyText =
      'Nam eu mi eget odio fermentum hendrerit. Sed malesuada consequat lacus, at elementum velit sagittis nec. Ut euismod rhoncus justo, sed luctus dui venenatis quis. Pellentesque convallis arcu ac tempus varius.';

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;

    List<SelectionButton> selections = [
      SelectionButton(
        onChangePage: () => context.go(UsageInfoView.routePath),
        text: locals.usageViewUsageInfo,
        widget: SvgPicture.asset('assets/icons/monitoring.svg',
            width: Sizes.selectionButtonIconSize,
            height: Sizes.selectionButtonIconSize),
      ),
      SelectionButton(
        onChangePage: () => context.go(UsageSettingsView.routePath),
        text: locals.usageViewSettings,
        widget: const Icon(
          Icons.settings_outlined,
          color: Colors.black,
          size: Sizes.selectionButtonIconSize,
        ),
      )
    ];

    return SingleChildScrollView(
      child: Content(
          title: locals.usageViewMyConsumption,
          text: bodyText,
          children: selections),
    ).withBackgroundColor(Colors.white);
  }
}
