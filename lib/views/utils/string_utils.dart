import 'package:flutter_flavorizr/extensions/extensions_string.dart';
import 'package:intl/intl.dart';

class StringUtils {
  static String getMonth(DateTime date, String locale) =>
      DateFormat('LLLL yyyy', locale).format(date).capitalize;

  static String getDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  static String getDay(DateTime date) => DateFormat('d.M.yyyy').format(date);
}
