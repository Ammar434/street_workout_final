class Sets {
  Sets({
    required this.numberOfRep,
    required this.weight,
    required this.distance,
    required this.duration,
    required this.id,
    required this.workoutId,
  });
  int numberOfRep;
  double weight;
  double distance;
  Duration duration;
  final String id;
  final String workoutId;

  Map<String, dynamic> toJson() => {
        "id": id,
        "workoutId": workoutId,
        "numberOfRep": numberOfRep,
        "weight": weight,
        "distance": distance,
        "duration": duration,
      };

  static Sets fromJson(Map json) {
    return Sets(
      id: json["id"],
      workoutId: json["workoutId"],
      distance: json["distance"],
      duration: json["duration"],
      numberOfRep: json["numberOfRep"],
      weight: json["weight"],
    );
  }

  void updateAfterSetForWeightRep(double weight, int numberOfRep) {
    this.weight = weight;
    this.numberOfRep = numberOfRep;
  }

  void updateAfterSetForTime(double time, Duration duration) {}
}
