import 'package:intl/intl.dart';

class InterruptionNotice {
  final String description;
  final String link;
  final String pubDate;
  final String title;

  InterruptionNotice({
    required this.description,
    required this.link,
    required this.pubDate,
    required this.title,
  });

  factory InterruptionNotice.fromJson(dynamic json) {
    return InterruptionNotice(
        description: json['description']!.replaceAll('\n', '\n\n'),
        link: json['link']!,
        pubDate: json['pubDate']!,
        title: json['title']!);
  }

  String get date {
    DateTime date = DateTime.parse(pubDate);
    return DateFormat('dd.MM.yyyy').format(date);
  }
}
