import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/selection_button.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';
import 'package:oulun_energia_mobile/views/utils/content.dart';

class UsageSelectionsView extends StatelessWidget {
  static const String routePath = 'usage';
  static const String routeName = 'usage';

  const UsageSelectionsView({Key? key}) : super(key: key);

  static Map<String, dynamic> getSettings() {
    return {
      'title': '',
      'secondaryAppBar': false,
      'secondaryAppBarStyle': true,
      'initialExpanded': true,
      'hideAppBar': false,
    };
  }

  void onChangePage(BuildContext context, String routeName) =>
      Navigator.of(context).pushNamed(routeName);

  final String bodyText =
      'Nam eu mi eget odio fermentum hendrerit. Sed malesuada consequat lacus, at elementum velit sagittis nec. Ut euismod rhoncus justo, sed luctus dui venenatis quis. Pellentesque convallis arcu ac tempus varius.';

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;

    List<SelectionButton> selections = [
      SelectionButton(
        onChangePage: () => context.goNamed(UsageInfoView.routeName),
        text: locals.usageViewUsageInfo,
        widget: SvgPicture.asset('assets/icons/monitoring.svg',
            width: Sizes.selectionButtonIconSize,
            height: Sizes.selectionButtonIconSize),
      ),
      SelectionButton(
        onChangePage: () => context.goNamed(UsageSettingsView.routeName),
        text: locals.usageViewSettings,
        widget: const Icon(
          Icons.settings_outlined,
          color: Colors.black,
          size: Sizes.selectionButtonIconSize,
        ),
      )
    ];

    return Content(
        assetName: "assets/images/my_usage_header.webp",
        title: locals.usageViewMyConsumption,
        text: bodyText,
        children: selections);
  }
}
