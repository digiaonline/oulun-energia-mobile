import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Usage {
  DateTime from;
  DateTime to;
  StatusCode statusCode;
  double value;
  UsageInterval interval;

  Usage(
      {required this.from,
      required this.to,
      required this.statusCode,
      required this.value,
      required this.interval});

  factory Usage.fromJson(Map<String, dynamic> json, UsageInterval interval) {
    String usageValue = json['a:UsageValue'].toString();
    StatusCode statusCode = getStatusCode(json['a:StatusCode']);

    return Usage(
      from: DateTime.parse(json['a:DateFrom'].toString()),
      to: DateTime.parse(json['a:DateTo'].toString()),
      statusCode: statusCode,
      value: usageValue == 'null'
          ? 0.0
          : double.parse(double.parse(usageValue).toStringAsFixed(2)),
      interval: interval,
    );
  }

  static StatusCode getStatusCode(String? status) {
    if (status == null) {
      return StatusCode.missing;
    }
    switch (status.toLowerCase()) {
      case 'mitattu':
        return StatusCode.measured;
      case 'puuttuva':
        return StatusCode.missing;
      case 'arvioitu':
        return StatusCode.approximated;
      default:
        return StatusCode.missing;
    }
  }

  String _formatByHour(String locale) {
    final DateFormat formatter = DateFormat('HH', locale);
    return formatter.format(to);
  }

  String formatDate(BuildContext context) {
    String date = '';
    String locale = AppLocalizations.of(context)!.localeName;
    switch (interval) {
      case UsageInterval.hour:
        date = _formatByHour(locale);
        break;
      case UsageInterval.day:
        date = DateFormat('E d', locale).format(from);
        break;
      case UsageInterval.month:
        date = DateFormat('MMM', locale).format(from);
        break;
      case UsageInterval.year:
        date = DateFormat('yyyy', locale).format(from);
        break;
    }

    return date;
  }

  @override
  String toString() {
    return 'from: $from to: $to statusCode: ${statusCode.name} value: $value';
  }
}
