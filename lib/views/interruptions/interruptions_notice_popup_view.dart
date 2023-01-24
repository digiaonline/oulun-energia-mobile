import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/domain/interruption_notice.dart';
import 'package:oulun_energia_mobile/providers/interruptions_provider.dart';
import 'package:oulun_energia_mobile/views/base/base_fullscreen_widget.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notices_view.dart';

class InterruptionNoticePopupView extends ConsumerWidget {
  static const String routePath = 'notice/:index';
  static const String routeName = 'notice';

  final int index;

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title': '',
      'secondaryAppBar': false,
      'initialExpanded': false,
      'hideAppBar': true,
    };
  }

  const InterruptionNoticePopupView({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InterruptionNotice> notices = ref.read(interruptionsProvider).value!;
    InterruptionNotice notice = notices[index];
    var locals = AppLocalizations.of(context)!;
    return BaseFullScreenWidget(InterruptionsNoticesView.routePath,
        appBarTitle: locals.interruptionsViewNotice,
        title: notice.date,
        additionalTitle: notice.title,
        description: notice.description);
  }
}
