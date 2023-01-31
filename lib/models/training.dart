import 'dart:convert';

import 'sets.dart';

class Training {
  Training({
    required this.dateTime,
    // required this.listWorkoutId,
    required this.mapOfSet,
  });

  final DateTime dateTime;
  // final List<String> listWorkoutId;
  final Map<String, List<Sets>> mapOfSet;

  Map<String, dynamic> toJson() {
    List listWorkoutJson = [];
    Map mapSetsJson = {};

    // for (String id in listWorkoutId) {
    //   listWorkoutJson.add(id);
    // }

    mapOfSet.forEach(
      (key, value) {
        List listSetsJson = [];

        for (Sets s in value) {
          listSetsJson.add(s.toJson());
        }
        mapSetsJson.addEntries(
          [
            MapEntry(key, listSetsJson),
          ],
        );
      },
    );

    return {
      "dateTime": dateTime,
      "listWorkout": listWorkoutJson,
      "mapOfSet": mapSetsJson,
    };
  }

//Recupere user depuis firebase et le converti en CustomUser
  static Training fromJson(Map json) {
    Map<String, dynamic> mapSetJson = jsonDecode(json['mapOfSet']);
    Map<String, List<Sets>> mapSets = {};

    mapSetJson.forEach(
      (key, value) {
        List<Sets> listSets = [];

        for (Map s in value) {
          listSets.add(Sets.fromJson(s));
        }
        mapSets.addEntries(
          [
            MapEntry(key, listSets),
          ],
        );
      },
    );

    return Training(
      dateTime: json['dateTime'],
      // listWorkoutId: json['listWorkoutJson'],
      mapOfSet: mapSets,
    );
  }
}
