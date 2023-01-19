import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/domain/interruption_notice.dart';
import 'package:oulun_energia_mobile/providers/interruptions_provider.dart';
import 'package:oulun_energia_mobile/views/base/base_fullscreen_widget.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notices_view.dart';

class InterruptionNoticePopupView extends ConsumerWidget {
  static const String routePath = 'notice/:index';
  static const String routeName = 'interruptions_notice';

  final int index;

  const InterruptionNoticePopupView({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InterruptionNotice> notices = ref.read(interruptionsProvider).value!;
    InterruptionNotice notice = notices[index];
    return BaseFullScreenWidget(InterruptionsNoticesView.routePath,
        appBarTitle: "Tiedote",
        title: notice.date,
        additionalTitle: notice.title,
        description: notice.description);
  }
}
