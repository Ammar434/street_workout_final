class Sets {
  Sets({
    required this.numberOfRep,
    required this.weight,
    required this.distance,
    required this.duration,
    required this.id,
  });
  int numberOfRep;
  double weight;
  double distance;
  Duration duration;
  final String id;
  void updateAfterSetForWeightRep(double weight, int numberOfRep) {
    this.weight = weight;
    this.numberOfRep = numberOfRep;
  }

  void updateAfterSetForTime(double time, Duration duration) {}
}
