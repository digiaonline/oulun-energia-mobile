import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/core/domain/interruption_notice.dart';
import 'package:oulun_energia_mobile/providers/interruptions_provider.dart';
import 'package:oulun_energia_mobile/views/base/base_fullscreen_widget.dart';

class InterruptionNoticePopupView extends ConsumerWidget {
  static const String routePath = 'notice/:index';
  static const String routeName = 'notice';

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title': '',
      'secondaryAppBar': false,
      'initialExpanded': false,
      'hideAppBar': true,
    };
  }

  const InterruptionNoticePopupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InterruptionNotice> notices = ref.read(interruptionsProvider).value!;
    int index = int.parse(GoRouterState.of(context).params['index'] ?? '0');

    InterruptionNotice notice = notices[index];

    var locals = AppLocalizations.of(context)!;
    return BaseFullScreenWidget(
        appBarTitle: locals.interruptionsViewNotice,
        title: notice.date,
        additionalTitle: notice.title,
        description: notice.description);
  }
}
