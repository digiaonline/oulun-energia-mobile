import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/domain/usage.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/usage_info_provider.dart';
import 'package:oulun_energia_mobile/views/usage/usage_bar_chart.dart';
import 'package:oulun_energia_mobile/views/usage/usage_scaffold.dart';

class UsageDataView extends ConsumerStatefulWidget {
  static String routeName = 'usage_info_view';
  final Function(MyUsageViews) onChangePage;

  const UsageDataView({Key? key, required this.onChangePage}) : super(key: key);

  @override
  UsageDataViewState createState() => UsageDataViewState();
}

class UsageDataViewState extends ConsumerState<UsageDataView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  void tabControllerListener() {
    if (!_tabController.indexIsChanging) {
      UsageInterval usageInterval = UsageInterval.values[_tabController.index];
      ref
          .read(usageInfoProvider.notifier)
          .changeUsageInterval(usageInterval: usageInterval);
    }
  }

  void onChangeDate({required int direction}) {
    ref.read(usageInfoProvider.notifier).changeDate(direction: direction);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(tabControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Usage>> fetchUsage =
        ref.watch(usageProvider(context));
    return fetchUsage.when(
      data: (usages) => UsageScaffold(
          icon: const Icon(Icons.help, color: Colors.black),
          onTap: () => widget.onChangePage(MyUsageViews.main),
          body: DefaultTabController(
            initialIndex: 0,
            length: 4,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Center(
                  child: Text(ref.watch(usageInfoProvider).getTotalUsage()),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                  iconColor: Colors.black,
                  leading: GestureDetector(
                    child: const Icon(Icons.arrow_back_ios),
                    onTap: () => onChangeDate(direction: -1),
                  ),
                  trailing: GestureDetector(
                    child: const Icon(Icons.arrow_forward_ios),
                    onTap: () => onChangeDate(direction: 1),
                  ),
                  title: Center(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        ref.watch(usageInfoProvider).getDateString(context),
                        style: const TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 275,
                    width: double.infinity,
                    child: usages.isNotEmpty
                        ? UsageBarChart(
                            usages: usages,
                            usageInterval:
                                ref.watch(usageInfoProvider).usageInterval,
                          )
                        : Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .usageViewUsageNoInfo,
                              style: const TextStyle(fontSize: 24.0),
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 15.0),
                  child: Stack(
                    fit: StackFit.passthrough,
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFE0E0E0), width: 5.0),
                        )),
                      ),
                      TabBar(
                        controller: _tabController,
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 5.0,
                            color: Color(0xFF009EB5),
                          ),
                        ),
                        unselectedLabelColor: Colors.black,
                        labelColor: const Color(0xFF009EB5),
                        tabs: <Widget>[
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Tab(
                              text: AppLocalizations.of(context)!.usageViewHour,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Tab(
                              text: AppLocalizations.of(context)!.usageViewDay,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Tab(
                              text:
                                  AppLocalizations.of(context)!.usageViewMonth,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Tab(
                              text: AppLocalizations.of(context)!.usageViewYear,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          title: AppLocalizations.of(context)!.usageViewUsageInfo),
      error: (error, stack) => UsageScaffold(
          onTap: () => widget.onChangePage(MyUsageViews.main),
          icon: const Icon(Icons.help, color: Colors.black),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                    AppLocalizations.of(context)!.usageViewUsageErrorInfo,
                    style: const TextStyle(fontSize: 24)),
              ),
            ],
          ),
          title: AppLocalizations.of(context)!.usageViewUsageInfo),
      loading: () => UsageScaffold(
          onTap: () => widget.onChangePage(MyUsageViews.main),
          icon: const Icon(Icons.help, color: Colors.black),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.usageViewFetchingData),
                const SizedBox(
                  height: 20.0,
                ),
                const CircularProgressIndicator(),
              ],
            ),
          ),
          title: AppLocalizations.of(context)!.usageViewUsageInfo),
    );
  }
}
