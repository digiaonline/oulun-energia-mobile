import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/core/domain/usage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

Map<String, dynamic> getConfig(
    BuildContext context, UsageInterval usageInterval) {
  Map<UsageInterval, Map<String, dynamic>> barChartConfig = {
    UsageInterval.hour: {
      'maxValue': 30.0,
      'barWidth': 9.0,
      'groupsSpace': 5.0,
      'interval': 5.0,
      'reservedSize': 50.0,
      'abbrv': AppLocalizations.of(context)!.usageViewAt
    },
    UsageInterval.day: {
      'maxValue': 120.0,
      'barWidth': 7.0,
      'groupsSpace': 5.0,
      'interval': 20.0,
      'reservedSize': 65.0,
      'abbrv': AppLocalizations.of(context)!.usageViewDay
    },
    UsageInterval.month: {
      'maxValue': 1500.0,
      'barWidth': 16.0,
      'groupsSpace': 5.0,
      'interval': 250.0,
      'reservedSize': 70.0,
      'abbrv': AppLocalizations.of(context)!.usageViewMonth
    },
    UsageInterval.year: {
      'maxValue': 24000.0,
      'barWidth': 18.0,
      'groupsSpace': 5.0,
      'interval': 4000.0,
      'reservedSize': 80.0,
      'abbrv': AppLocalizations.of(context)!.usageViewYear
    },
  };

  return barChartConfig[usageInterval]!;
}

Size _textSize(String text, TextStyle style) {
  final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout();
  return textPainter.size;
}

class UsageBarChart extends StatefulWidget {
  final List<Usage> usages;
  final UsageInterval usageInterval;

  const UsageBarChart(
      {super.key, required this.usages, required this.usageInterval});

  @override
  State<UsageBarChart> createState() => _UsageBarChartState();
}

List<BarData> getBarData(
    {required List<Usage> usages, bool isTransparent = false}) {
  List<BarData> barData = [];
  for (int i = 0; i < usages.length; i++) {
    Usage usage = usages[i];
    final color =
        i.isEven ? Colors.blue.withOpacity(0.8) : Colors.blue.withOpacity(0.5);

    barData.add(BarData(isTransparent ? Colors.transparent : color, usage.value,
        usage.toString()));
  }

  return barData;
}

class _UsageBarChartState extends State<UsageBarChart> {
  BarChartGroupData generateBarGroup(
      int x, Color color, double value, double width, bool showTooltip) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: width,
          borderRadius: BorderRadius.zero,
        ),
      ],
      showingTooltipIndicators: !showTooltip
          ? null
          : touchedGroupIndex == x
              ? [0]
              : [],
    );
  }

  BarChartGroupData generateBarGroup2(
    int x,
    Color color,
    double value,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 9,
          borderRadius: BorderRadius.zero,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  List<FlSpot> getLineBarSpots(List<dynamic> temps) {
    return temps.map((element) {
      var x = element['x']!;
      var y = element['y']!;
      return FlSpot(x, y);
    }).toList();
  }

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;
    var config = getConfig(context, widget.usageInterval);
    bool isLandscapeMode =
        MediaQuery.of(context).orientation == Orientation.landscape;

    double currMax =
        widget.usages.map((usage) => usage.value).toList().reduce(max);
    double interval = config['interval'];
    double maxValue = 0.0;

    if (currMax > maxValue) {
      while (currMax > maxValue) {
        maxValue += interval;
      }
    }

    int tickCount = (maxValue / interval).floor().toInt();

    if (tickCount > 7) {
      for (int i = 7; i > 0; i--) {
        // Checks if the double is a whole number
        if ((maxValue / i) % 1 == 0) {
          interval = maxValue / i;
          break;
        }
      }
    }

    double groupsSpace = config['groupsSpace'];

    double barWidth = config['barWidth'];
    double reservedSize = config['reservedSize'];
    String abbrv = config['abbrv'];

    if (isLandscapeMode) {
      groupsSpace *= 1.5;
      barWidth *= 2;
    }

    return SizedBox(
      width: double.infinity,
      height: 410,
      child: Stack(
        children: [
          BarChart(
            BarChartData(
                groupsSpace: groupsSpace,
                alignment: BarChartAlignment.center,
                borderData: FlBorderData(
                  show: true,
                  border: const Border.symmetric(
                    horizontal: BorderSide(
                      color: Color(0xFFececec),
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    drawBehindEverything: true,
                    sideTitles: SideTitles(
                      reservedSize: reservedSize,
                      interval: interval,
                      showTitles: false,
                      getTitlesWidget: (value, meta) => const SizedBox.shrink(),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();

                        if (isLandscapeMode || idx.isEven) {
                          if (widget.usageInterval == UsageInterval.day) {
                            List<String> text = widget.usages[idx]
                                .formatDate(context)
                                .split(' ');
                            return Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 20.0,
                                    child: Text(
                                      text[0].substring(0, 2),
                                      style: kFontSize12W400,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Transform.translate(
                                      offset: const Offset(0.0, 10.0),
                                      child: SizedBox(
                                        width: 20.0,
                                        child: Text(text[1],
                                            style: kFontSize12W400,
                                            textAlign: TextAlign.center),
                                      )),
                                ],
                              ),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              widget.usages[idx].formatDate(context),
                              style: kFontSize12W400,
                              textAlign: TextAlign.left,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: interval,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: const Color(0xFFececec),
                    strokeWidth: 1,
                  ),
                ),
                barGroups:
                    getBarData(usages: widget.usages).asMap().entries.map((e) {
                  final index = e.key;
                  final data = e.value;
                  return generateBarGroup(
                      index, data.color, data.value, barWidth, false);
                }).toList(),
                maxY: maxValue,
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchCallback: (event, response) {
                    if (event.isInterestedForInteractions &&
                        response != null &&
                        response.spot != null) {
                      setState(() {
                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                      });
                    } else {
                      setState(() {
                        touchedGroupIndex = -1;
                      });
                    }
                  },
                )),
          ),
          IgnorePointer(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      )),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: FlGridData(
                    show: false,
                  ),
                  lineTouchData: LineTouchData(enabled: false),
                  lineBarsData: [
                    LineChartBarData(
                      color: Colors.red,
                      barWidth: 1,
                      isCurved: true,
                      spots: getLineBarSpots([]),
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(show: false),
                      aboveBarData: BarAreaData(show: false),
                    )
                  ],
                ),
              ),
            ),
          ),
          IgnorePointer(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                groupsSpace: groupsSpace,
                borderData: FlBorderData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    drawBehindEverything: true,
                    sideTitles: SideTitles(
                      reservedSize: reservedSize,
                      interval: interval,
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final isLast = meta.max.toInt() == value.toInt();
                        const style = TextStyle(
                          color: Color(0xFF606060),
                          fontSize: 12,
                        );
                        final text =
                            '${value.toInt().toString()} ${isLast ? 'kWh  ' : ''}';
                        final size = _textSize(text, style);

                        return Transform.translate(
                          offset: const Offset(0, -9.5),
                          child: IgnorePointer(
                            child: Stack(
                              children: [
                                Container(
                                  height: 20,
                                  width: size.width + 10,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE0E0E0),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    left: 5,
                                  ),
                                  child: Text(text, style: style),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                        reservedSize: reservedSize,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return const SizedBox.shrink();
                        }),
                  ),
                  topTitles: AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  drawHorizontalLine: false,
                ),
                barGroups:
                    getBarData(usages: widget.usages, isTransparent: true)
                        .asMap()
                        .entries
                        .map((e) {
                  final index = e.key;
                  final data = e.value;
                  return generateBarGroup(
                      index, data.color, data.value, barWidth, true);
                }).toList(),
                maxY: maxValue,
                barTouchData: BarTouchData(
                  enabled: false,
                  handleBuiltInTouches: false,
                  touchTooltipData: BarTouchTooltipData(
                    direction: TooltipDirection.bottom,
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    maxContentWidth: 300.0,
                    tooltipBgColor: Colors.blue,
                    tooltipMargin: -200.0,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      final time =
                          widget.usages[groupIndex].formatDate(context);
                      final value = widget.usages[groupIndex].value;
                      // TODO add temperature
                      final text =
                          '$abbrv: $time\n${locals.usageViewUsage}: $value kWh\nTemp: 0 °C';
                      return BarTooltipItem(
                        text,
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 13,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 12,
                            )
                          ],
                        ),
                        textAlign: TextAlign.left,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarData {
  const BarData(this.color, this.value, this.date);
  final Color color;
  final double value;
  final String date;
}
