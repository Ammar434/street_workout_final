import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/text_style.dart';

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

  String getMonthString(int days) {
    switch (days) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';

      default:
        return 'Err';
    }
  }

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
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToIndex(15));
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
          String currentDateName = getMonthString(listDate[index].weekday);
          bool isCurrentDay = index == (numberOfDaysToDisplay ~/ 2);
          return Container(
            width: itemWidth,
            margin: EdgeInsets.all(kSmallPaddingValue),
            decoration: BoxDecoration(
              color: isCurrentDay ? primaryColor : tertiaryColor,
              borderRadius: BorderRadius.circular(kRadiusValue * 4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentDateValue,
                  style: kTextStyleImportance3,
                ),
                SizedBox(
                  height: kSmallPaddingValue,
                ),
                Text(
                  currentDateName,
                  style: kTextStyleHintTextImportance5.copyWith(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}