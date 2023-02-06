import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../models/workout.dart';
import '../../../../widgets/app_bar.dart';
import '../countdown/count_down.dart';
import 'components/graph_body.dart';
import 'components/history_body.dart';
import 'components/track_body.dart';

List<String> listItem = [];
List<bool> listIsExpanded = [];

//To expand or shrink tile list of unique key
List<UniqueKey> listOfUniqueKey = [];
List<TextEditingController> listTextEdittingController = [];
// List<Sets> listSet = [];

class DuringTrainingScreen extends StatefulWidget {
  const DuringTrainingScreen({Key? key, required this.workout}) : super(key: key);
  final Workout workout;
  @override
  State<DuringTrainingScreen> createState() => _DuringTrainingScreenState();
}

class _DuringTrainingScreenState extends State<DuringTrainingScreen> {
  @override
  void dispose() {
    listItem.clear();
    listOfUniqueKey.clear();
    listIsExpanded.clear();
    for (TextEditingController te in listTextEdittingController) {
      te.dispose();
    }
    listTextEdittingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(
          context,
          widget.workout.name,
          trailling: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CountDownScreen(),
                  ),
                );
              },
              icon: const FaIcon(FontAwesomeIcons.solidClock),
            ),
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                tabs: const [
                  Tab(text: 'Track'),
                  Tab(text: 'History'),
                  Tab(text: 'Graph'),
                ],
                indicatorColor: Theme.of(context).colorScheme.secondary,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    TrackBody(
                      workout: widget.workout,
                    ),
                    HistoryBody(
                      workout: widget.workout,
                    ),
                    GraphBody(
                      workout: widget.workout,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
