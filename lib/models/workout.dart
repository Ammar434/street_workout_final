import 'package:flutter/material.dart';

class Workout {
  Workout({
    required this.id,
    required this.name,
    required this.type,
    required this.color,
    required this.image,
    required this.category,
  });
  final String type;
  final String id;
  final String name;
  final String image;
  final String category;
  final Color color;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "color": color.value,
        "image": image,
        "category": category,
      };

  static Workout fromJson(Map json) {
    return Workout(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      category: json["category"],
      color: Color(json["color"]),
      type: json["type"],
    );
  }
  // void addSetOfRep(String id, double weight, int numberOfRep) {
  //   bool isSetAlreadyExist = false;
  //   Sets s = Sets(
  //     numberOfRep: numberOfRep,
  //     weight: weight,
  //     distance: 0,
  //     duration: Duration.zero,
  //     id: id,
  //   );
  //   for (Sets s in listSets) {
  //     if (s.id == id) {
  //       isSetAlreadyExist = true;
  //       s.weight = weight;
  //       s.numberOfRep = numberOfRep;
  //     }
  //   }
  //   if (!isSetAlreadyExist) {
  //     listSets.add(s);
  //   }
  // }

  // Workout clone() {
  //   return Workout(
  //     id: id,
  //     name: name,
  //     type: type,
  //     color: color,
  //     image: image,
  //     listSets: [],
  //   );
  // }
}
