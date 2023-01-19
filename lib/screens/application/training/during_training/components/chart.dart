import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/services/dates_services.dart';
import 'package:street_workout_final/utils/colors.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({Key? key, required this.listFlSpot, required this.days}) : super(key: key);
  final List<FlSpot> listFlSpot;
  final double days;
  @override
  LineChartSample2State createState() => LineChartSample2State();
}

class LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    primaryColor,
    secondaryColor,
  ];

  @override
  Widget build(BuildContext context) {
    return widget.listFlSpot.isEmpty
        ? const Center(child: Text("No record found for the selected time period"))
        : Container(
            // height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(18),
              ),
              color: tertiaryColor.withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;

    DateTime dateTime = DateTime.now();
    String currentDateValue = dateTime.day.toString();
    String currentDateName = getMonth(dateTime.month).substring(0, 3).toUpperCase();
    int midDay = widget.days ~/ 2;

    if (value.toInt() == 0) {
      dateTime = dateTime.subtract(
        Duration(days: widget.days.toInt()),
      );
      currentDateValue = dateTime.day.toString();
      currentDateName = getMonth(dateTime.month).substring(0, 3).toUpperCase();
      text = Text('$currentDateValue $currentDateName', style: style);
    } else if (value.toInt() == midDay) {
      dateTime = dateTime.subtract(
        Duration(days: midDay),
      );
      currentDateValue = dateTime.day.toString();
      currentDateName = getMonth(dateTime.month).substring(0, 3).toUpperCase();
      text = Text('$currentDateValue $currentDateName', style: style);
    } else if (value.toInt() == widget.days) {
      dateTime = DateTime.now();
      currentDateValue = dateTime.day.toString();
      currentDateName = getMonth(dateTime.month).substring(0, 3).toUpperCase();
      text = Text('$currentDateValue $currentDateName', style: style);
    } else {
      text = const Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;

    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: widget.days,
      minY: 0,
      maxY: 30,
      lineBarsData: [
        LineChartBarData(
          spots: widget.listFlSpot,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
