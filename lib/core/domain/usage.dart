import 'package:intl/intl.dart';
import 'package:oulun_energia_mobile/core/enums.dart';

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

  String _formatByHour() {
    final DateFormat formatter = DateFormat('HH', 'fi');
    return formatter.format(to);
  }

  String formatDate() {
    String date = '';
    switch (interval) {
      case UsageInterval.hour:
        date = _formatByHour();
        break;
      case UsageInterval.day:
        date = DateFormat('d', 'fi').format(from);
        break;
      case UsageInterval.month:
        date = DateFormat('MMM', 'fi').format(from);
        break;
      case UsageInterval.year:
        date = DateFormat('yyyy', 'fi').format(from);
        break;
    }

    return date;
  }

  @override
  String toString() {
    return 'from: $from to: $to statusCode: ${statusCode.name} value: $value date: ${formatDate()}';
  }
}
