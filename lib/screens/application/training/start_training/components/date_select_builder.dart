import 'package:flutter/material.dart';
import "../../../../../common_libs.dart";
import 'package:provider/provider.dart';

import '../../../../../provider/training_provider.dart';
import '../../../../../services/dates_services.dart';

class DateSelectBuilder extends StatefulWidget {
  const DateSelectBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<DateSelectBuilder> createState() => _DateSelectBuilderState();
}

class _DateSelectBuilderState extends State<DateSelectBuilder> {
  final scrollController = ScrollController();

  final List<DateTime> listDate = [];

  final double itemWidth = 70.sp;

  int numberOfDaysToDisplay = 30;
  int daySelected = 15;

  void loadData() {
    DateTime dateTime = DateTime.now().add(
      Duration(days: -numberOfDaysToDisplay ~/ 2),
    );
    for (int i = 0; i < numberOfDaysToDisplay; i++) {
      listDate.add(dateTime);
      dateTime = dateTime.add(const Duration(days: 1));
    }
  }

  void scrollToIndex(index) {
    scrollController.animateTo(
      (itemWidth + kSmallPaddingValue * 2) * index,
      duration: const Duration(seconds: 2),
      curve: Curves.easeOutExpo,
    );
  }

  @override
  void initState() {
    loadData();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToIndex(numberOfDaysToDisplay ~/ 2));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    listDate.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: numberOfDaysToDisplay,
        itemBuilder: (contex, index) {
          String currentDateValue = listDate[index].day.toString();
          String currentDateName = getDayString(listDate[index].weekday);
          return GestureDetector(
            onTap: (() {
              setState(() {
                daySelected = index;
                scrollToIndex(daySelected);
                Provider.of<TrainingProvider>(context, listen: false).changeDaySelected(listDate[index]);
              });
            }),
            child: Container(
              width: itemWidth,
              margin: EdgeInsets.all(kSmallPaddingValue),
              decoration: BoxDecoration(
                color: index == daySelected ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(kRadiusValue * 4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentDateValue,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: kSmallPaddingValue,
                  ),
                  Text(
                    currentDateName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
