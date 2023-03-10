import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_fault_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_map_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notices_view.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/content.dart';
import 'package:oulun_energia_mobile/views/utils/selection_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InterruptionsSelectionsView extends StatelessWidget {
  static const String routePath = 'interruptions';
  static const String routeName = 'interruptions';

  static Map<String, dynamic> getSettings() {
    return {
      'title': '',
      'secondaryAppBar': false,
      'secondaryAppBarStyle': true,
      'initialExpanded': true,
      'hideAppBar': false,
    };
  }

  const InterruptionsSelectionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;

    List<SelectionButton> selections = [
      SelectionButton(
        onChangePage: () => context.goNamed(
          InterruptionsMapView.routeName,
          params: {"url": InterruptionsMapView.targetUrl},
        ),
        text: locals.interruptionsViewMap,
        widget: SvgPicture.asset('assets/icons/fmd_bad.svg',
            width: Sizes.selectionButtonIconSize,
            height: Sizes.selectionButtonIconSize),
      ),
      SelectionButton(
        onChangePage: () => context.goNamed(
          InterruptionsNoticesView.routeName,
        ),
        text: locals.interruptionsViewNotices,
        widget: const Icon(
          Icons.description_outlined,
          color: Colors.black,
          size: Sizes.selectionButtonIconSize,
        ),
      ),
      SelectionButton(
        onChangePage: () => context.goNamed(
          InterruptionsFaultView.routeName,
        ),
        text: locals.interruptionsViewFault,
        widget: SvgPicture.asset(
          'assets/icons/local_convenience_store.svg',
          width: Sizes.selectionButtonIconSize,
          height: Sizes.selectionButtonIconSize,
        ),
      )
    ];

    return Content(
        assetName: "assets/images/interruptions_header.webp",
        title: locals.interruptionsViewTitle,
        text: locals.interruptionsViewText,
        children: selections);
  }
}
