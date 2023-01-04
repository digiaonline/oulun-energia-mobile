import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:oulun_energia_mobile/core/domain/usage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/core/enums.dart';

Map<String, dynamic> getConfig(
    BuildContext context, UsageInterval usageInterval) {
  Map<UsageInterval, Map<String, dynamic>> barChartConfig = {
    UsageInterval.hour: {
      'min': 0,
      'max': 30,
      'tickCount': 7,
      'abbrv': AppLocalizations.of(context)!.usageViewAt
    },
    UsageInterval.day: {
      'min': 0,
      'max': 120,
      'tickCount': 7,
      'abbrv': AppLocalizations.of(context)!.usageViewDate
    },
    UsageInterval.month: {
      'min': 0,
      'max': 1500,
      'tickCount': 7,
      'abbrv': AppLocalizations.of(context)!.usageViewDate
    },
    UsageInterval.year: {
      'min': 0,
      'max': 25000,
      'tickCount': 7,
      'abbrv': AppLocalizations.of(context)!.usageViewDate
    },
  };

  return barChartConfig[usageInterval]!;
}

class UsageBarChart extends StatefulWidget {
  final List<Usage> usages;
  final UsageInterval usageInterval;

  const UsageBarChart(
      {super.key, required this.usages, required this.usageInterval});

  @override
  State<StatefulWidget> createState() => _UsageBarChartState();
}

class _UsageBarChartState extends State<UsageBarChart> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> config = getConfig(context, widget.usageInterval);

    int min = config['min']!;
    int max = config['max']!;
    int tickCount = config['tickCount']!;
    String abbrv = config['abbrv'];

    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 15.0),
          child: Text(
            AppLocalizations.of(context)!.usageViewUsage,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 10.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Chart(
            data: widget.usages
                .map((consumption) => {
                      'value': consumption.value,
                      'date': consumption.formatDate(context),
                    })
                .toList(),
            variables: {
              'date': Variable(
                accessor: (Map map) {
                  return map['date'] as String;
                },
              ),
              'value': Variable(
                accessor: (Map map) => map['value'] as double,
                scale: LinearScale(min: min, max: max, tickCount: tickCount),
              ),
            },
            elements: [
              IntervalElement(
                layer: 0,
                elevation: ElevationAttr(value: 0, updaters: {
                  'tap': {true: (_) => 5}
                }),
                color: ColorAttr(value: const Color(0xFF0F5EA6), updaters: {
                  'tap': {false: (color) => color.withAlpha(100)}
                }),
              )
            ],
            axes: [
              AxisGuide(
                layer: 2,
                dim: Dim.x,
                line: StrokeStyle(
                  color: Colors.grey,
                  width: 1.0,
                ),
                variable: 'date',
                labelMapper: (text, index, value) {
                  if ((index + 1) % 2 != 1) {
                    return null;
                  }
                  return LabelStyle(
                    span: (text) {
                      return TextSpan(
                          text: text,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal));
                    },
                    offset: const Offset(0, 5.0),
                  );
                },
              ),
              AxisGuide(
                layer: 1,
                dim: Dim.y,
                variable: 'value',
                labelMapper: (text, index, value) {
                  return LabelStyle(
                    offset: const Offset(-4.0, -4.0),
                    span: (text) {
                      int value = double.parse(text).toInt();
                      return TextSpan(
                        text: '$value',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
            selections: {
              'tap': PointSelection(
                dim: Dim.x,
              ),
            },
            tooltip: TooltipGuide(
                layer: 2,
                renderer: (size, offset, map) {
                  var tuple = map[map.keys.toList()[0]];

                  double cardSizeX = 100.0;
                  double cardSizeY = 35.0;

                  double dx = clampDouble(
                      offset.dx - (cardSizeX / 2), 0, size.width - cardSizeX);
                  double dy = offset.dy - (cardSizeY / 2);

                  var windowRect = Rect.fromLTWH(
                    dx,
                    dy,
                    cardSizeX,
                    cardSizeY,
                  );

                  final dateText = TextPainter(
                    text: TextSpan(
                      text: '$abbrv ${tuple!['date']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                    textDirection: TextDirection.ltr,
                  );
                  dateText.layout();

                  final usageText = TextPainter(
                    text: TextSpan(
                      text: '${AppLocalizations.of(context)!.usageViewUsage}:',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                      ),
                    ),
                    textDirection: TextDirection.ltr,
                  );
                  usageText.layout();

                  final usageValue = TextPainter(
                    text: TextSpan(
                      text: '${tuple['value']} kWh',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textDirection: TextDirection.ltr,
                  );
                  usageValue.layout();

                  var usageValueOffset = usageText.width + 10;

                  var windowPath = Path()..addRect(windowRect);
                  return [
                    ShadowFigure(windowPath, Colors.black, 4),
                    PathFigure(
                      windowPath,
                      Paint()..color = Colors.white,
                    ),
                    TextFigure(
                      dateText,
                      Offset(dx + 5.0, dy + 5.0),
                    ),
                    TextFigure(
                      usageText,
                      Offset(dx + 5.0, dy + 20.0),
                    ),
                    TextFigure(
                      usageValue,
                      Offset(dx + usageValueOffset, dy + 20.0),
                    ),
                  ];
                }),
          ),
        ),
      ],
    );
  }
}
