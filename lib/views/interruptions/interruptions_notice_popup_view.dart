import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/domain/interruption_notice.dart';
import 'package:oulun_energia_mobile/providers/interruptions_provider.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notices_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:go_router/go_router.dart';

class InterruptionNoticePopupView extends ConsumerWidget {
  static const String routePath = 'notice/:index';
  static const String routeName = 'interruptions_notice';

  final int index;

  const InterruptionNoticePopupView({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InterruptionNotice> notices = ref.read(interruptionsProvider).value!;
    InterruptionNotice notice = notices[index];

    return Scaffold(
      appBar: AppBar(
        shape: const Border.fromBorderSide(BorderSide(
            width: 0.0,
            strokeAlign: StrokeAlign.outside,
            color: Colors.transparent)),
        centerTitle: false,
        title: Text('Tiedote',
            style: textTheme.headline2?.copyWith(color: Colors.black)),
        iconTheme: appBarIconThemeSecondary,
        leading: InkWell(
          onTap: () => context.go(InterruptionsNoticesView.routePath),
          child: const Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notice.date, style: textTheme.headline1),
              const SizedBox(height: 16.0),
              Text(notice.title, style: textTheme.headline3),
              const SizedBox(height: 16.0),
              Text(notice.description, style: textTheme.bodyText1),
            ],
          ),
        ),
      ),
    );
  }
}
