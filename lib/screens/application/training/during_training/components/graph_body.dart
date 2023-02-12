import 'package:flutter/material.dart';
import "../../../../../common_libs.dart";

import '../../../../../models/training.dart';
import '../../../../../models/workout.dart';
import '../../../../../services/training/training_services.dart';
import 'chart.dart';
import 'drop_down_for_graph_type.dart';

class GraphBody extends StatefulWidget {
  const GraphBody({
    Key? key,
    required this.workout,
  }) : super(key: key);

  final Workout workout;
  @override
  State<GraphBody> createState() => _GraphBodyState();
}

final List<String> items = ["Estimated 1RM", "Max weight", "Max reps"];
List<String> list = ["Month", "3 Months", "6 Months", "All"];

class _GraphBodyState extends State<GraphBody> {
  String val = items[0];
  int index = 0;
  int defaultSelectedDayIndex = 0;

  buildListPlot() {}

  buildWidgetChart(int i, List<Training> trainingList, Workout w) {
    if (i == 0) {
      return Expanded(
        child: LineChartSample2(
          listFlSpot: TrainingServices().buildListFlSpot(trainingList, w),
          days: 30,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TrainingServices trainingServices = TrainingServices();
    // List<Training> trainingList = Provider.of<TrainingProvider>(context).getListTrainingContainingACertainWorkout(widget.workout.id);
    List<Training> trainingList = [];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
      child: Column(
        children: [
          DropDownForGraphType(
            val: val,
            list: items,
            onChanged: (String? v) => setState(
              () {
                val = v!;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              list.length,
              (index) => TextButton(
                onPressed: () {
                  setState(() {
                    defaultSelectedDayIndex = index;
                  });
                },
                child: Text(
                  list[index],
                  style: TextStyle(
                    color: defaultSelectedDayIndex == index ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ),
          buildWidgetChart(defaultSelectedDayIndex, trainingList, widget.workout)
        ],
      ),
    );
  }
}
