import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/domain/interruption_notice.dart';
import 'package:oulun_energia_mobile/providers/interruptions_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notice_popup_view.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';
import 'package:go_router/go_router.dart';

class InterruptionsNoticesView extends ConsumerWidget {
  static const String routePath = 'notices';
  static const String routeName = 'notices';
  const InterruptionsNoticesView({super.key});

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title': AppLocalizations.of(context)!.interruptionsViewNotices,
      'secondaryAppBar': true,
      'initialExpanded': true,
      'hideAppBar': false,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<InterruptionNotice>> notices =
        ref.watch(interruptionsProvider);

    var locals = AppLocalizations.of(context)!;

    return notices
        .when(
            data: (List<InterruptionNotice> data) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(locals.interruptionsViewNoticesTitle,
                        style: textTheme.displayLarge),
                    const SizedBox(
                      height: 16.0,
                    ),
                    if (data.isEmpty)
                      Text(locals.interruptionsViewNoticesFetchNoData),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: data.length,
                        controller: ScrollController(),
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          decoration: BoxDecoration(
                            color: index.isEven
                                ? Colors.white
                                : const Color(0xFFF1F0F4),
                            border: const Border(
                              bottom: BorderSide(
                                  color: Color(0xFFDFE2EB), width: 1.0),
                            ),
                          ),
                          child: ListTile(
                            onTap: () => context.goNamed(
                              InterruptionNoticePopupView.routeName,
                              params: {
                                "index": "$index",
                              },
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                                16.0, 12.0, 32.0, 12.0),
                            title: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Text(
                                data[index].date,
                                style: kFontSize12W400.copyWith(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            subtitle: Text(data[index].title,
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: Colors.black)),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 19.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: ((error, stackTrace) => Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!
                        .interruptionsViewNoticesFetchError),
                  ],
                ))),
            loading: () => Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!
                        .interruptionsViewNoticesFetchData),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const CircularProgressIndicator(),
                  ],
                )))
        .withBackgroundColor(Colors.white)
        .withWillPopScope(context);
  }
}
