import 'package:intl/intl.dart';
import 'package:oulun_energia_mobile/core/enums.dart';

class Usage {
  DateTime from;
  DateTime to;
  bool isMeasured;
  double value;
  UsageInterval interval;

  Usage(
      {required this.from,
      required this.to,
      required this.isMeasured,
      required this.value,
      required this.interval});

  factory Usage.fromJson(Map<String, dynamic> json, UsageInterval interval) {
    String usageValue = json['a:UsageValue'].toString();

    return Usage(
      from: DateTime.parse(json['a:DateFrom'].toString()),
      to: DateTime.parse(json['a:DateTo'].toString()),
      isMeasured: json['a:StatusCode'].toString().toUpperCase() == 'MITATTU',
      value: usageValue == 'null'
          ? 0.0
          : double.parse(double.parse(usageValue).toStringAsFixed(2)),
      interval: interval,
    );
  }

  String _formatByHour() {
    final DateFormat formatter = DateFormat('HH', 'fi');
    return '${formatter.format(from)}-${formatter.format(to)}';
  }

  String formatDate() {
    String date = '';
    switch (interval) {
      case UsageInterval.interval:
        date = _formatByHour();
        break;
      case UsageInterval.day:
        date = DateFormat('E d.MM', 'fi').format(from);
        break;
      case UsageInterval.week:
        date = DateFormat('MM\\yyyy', 'fi').format(from);
        break;
      case UsageInterval.year:
        date = DateFormat('yyyy', 'fi').format(from);
        break;
    }

    return date;
  }

  @override
  String toString() {
    return 'from: $from to: $to isMeasured: $isMeasured value: $value date: ${formatDate()}';
  }
}
