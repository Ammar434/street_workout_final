import 'package:street_workout_final/models/workout.dart';

class Training {
  Training({
    required this.dateTime,
    required this.listWorkout,
  });

  final DateTime dateTime;
  final List<Workout> listWorkout;

  // void addWorkout(Workout workout) {
  //   bool b = false;
  //   for (Workout w in listWorkout) {
  //     if (w.id == workout.id) {
  //       b = true;
  //     }
  //   }
  //   if (!b) {
  //     listWorkout.add(workout);
  //   }
  // }
}
