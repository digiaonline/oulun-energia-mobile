import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/authentication/authentication.dart';
import 'package:oulun_energia_mobile/core/domain/usage.dart';
import 'package:oulun_energia_mobile/core/domain/user_auth.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/core/network_api/usage_api.dart';
import 'package:oulun_energia_mobile/flavors.dart';
import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/utils/string_utils.dart';

final usageInfoProvider =
    StateNotifierProvider<UsageInfoNotifier, UsageInfoState>(
        (ref) => UsageInfoNotifier(UsageInfoState()));

class UsageProvider extends StateNotifier {
  UsageProvider(super.state);
}

final usageProvider =
    FutureProvider.family<List<Usage>, BuildContext>((ref, context) async {
  UserAuth? userAuth = ref.read(loginProvider).userAuth;
  UsageApi usageApi = UsageApi(Authentication(), F.baseUrl);

  UsageInterval usageInterval = ref.watch(usageInfoProvider).usageInterval;
  Map<String, String> dates = ref.watch(usageInfoProvider).getDates();

  List<Usage> usages = await usageApi.getElectricUsage(
      userAuth,
      userAuth?.customerInfo.usagePlaces[0],
      dates['from']!,
      dates['to']!,
      usageInterval);

  ref.read(usageInfoProvider).totalUsage = usages.isEmpty
      ? ''
      : usages
          .map((usage) => usage.value.toDouble())
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2);
  return usages;
});

class UsageInfoNotifier extends StateNotifier<UsageInfoState> {
  UsageInfoNotifier(super.state);

  changeDate({required int direction}) {
    DateTime now = DateTime.now();
    DateTime newDate = DateTime.now();

    switch (state.usageInterval) {
      case UsageInterval.hour:
        newDate = DateTime(
            state.date.year, state.date.month, state.date.day + direction);
        break;
      case UsageInterval.day:
        newDate = DateTime(
            state.date.year, state.date.month + direction, state.date.day);
        break;
      case UsageInterval.month:
        newDate = DateTime(
            state.date.year + direction, state.date.month, state.date.day);
        break;
      case UsageInterval.year:
        break;
    }

    if (newDate.isAfter(now)) {
      return;
    }

    state = UsageInfoState()
        .copyWith(date: newDate, usageInterval: state.usageInterval);
  }

  changeUsageInterval({required UsageInterval usageInterval}) {
    state = UsageInfoState().copyWith(usageInterval: usageInterval);
  }
}

class UsageInfoState {
  DateTime date = DateTime.now();
  String dateString = '';
  bool loading = false;
  String totalUsage = '';
  UsageInterval usageInterval = UsageInterval.hour;

  UsageInfoState() {
    date = DateTime.now().subtract(const Duration(days: 2));
  }

  String getTotalUsage() => totalUsage.isEmpty ? '' : '$totalUsage kWh';

  String getDateString(BuildContext context) {
    String locale = AppLocalizations.of(context)!.localeName;
    String dateString = '';

    switch (usageInterval) {
      case UsageInterval.hour:
        dateString = StringUtils.getDay(date);
        break;
      case UsageInterval.day:
        dateString = StringUtils.getMonth(date, locale);
        break;
      case UsageInterval.month:
        dateString = date.year.toString();
        break;
      case UsageInterval.year:
        dateString = '2013-${date.year}';
    }

    return dateString;
  }

  Map<String, String> getDates() {
    String from = '';
    String to = '';

    switch (usageInterval) {
      case UsageInterval.hour:
        from = '${date.year}-${date.month}-${date.day}T00:00:00';
        to = '${date.year}-${date.month}-${date.day}T23:00:00';
        break;
      case UsageInterval.day:
        DateTime startDate = DateTime(date.year, date.month, 1);
        DateTime endDate = DateTime(date.year, date.month + 1, 1);
        from = '${StringUtils.getDate(startDate)}T00:00:00';
        to = '${StringUtils.getDate(endDate)}T23:00:00';
        break;
      case UsageInterval.month:
        from = '${date.year}-01-01T00:00:00';
        to = '${date.year}-12-31T23:00:00';
        break;
      case UsageInterval.year:
        from = '2013-01-01T00:00:00';
        to = '${DateTime.now().year + 1}-01-01T00:00:00';
    }

    return {'from': from, 'to': to};
  }

  UsageInfoState.copy(this.date, this.dateString, this.loading, this.totalUsage,
      this.usageInterval);

  UsageInfoState copyWith(
      {DateTime? date,
      String? dateString,
      bool? loading,
      String? totalUsage,
      UsageInterval? usageInterval}) {
    return UsageInfoState.copy(
        date ?? this.date,
        dateString ?? this.dateString,
        loading ?? this.loading,
        totalUsage ?? this.totalUsage,
        usageInterval ?? this.usageInterval);
  }
}
