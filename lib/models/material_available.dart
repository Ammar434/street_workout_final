class MaterialAvailable {
  final String name, image;

  MaterialAvailable({required this.name, required this.image});
}

// Map<String, MaterialAvailable> materialAvailableMap = {
//   'traction': materialAvailable1,
//   'dips': materialAvailable2,
//   'mediumBar': materialAvailable3,
//   'bench': materialAvailable4,
//   'monkeyBar': materialAvailable5,
//   'highVerticalBar': materialAvailable6,
// };

List<MaterialAvailable> materialAvailableList = [
  materialAvailable0,
  materialAvailable1,
  materialAvailable2,
  materialAvailable3,
  materialAvailable4,
  materialAvailable5,
];

MaterialAvailable materialAvailable0 = MaterialAvailable(
  name: "Traction",
  image: "assets/images/exercices/image_exercice0.png",
);
MaterialAvailable materialAvailable1 = MaterialAvailable(
  name: "Dips",
  image: "assets/images/exercices/image_exercice1.png",
);
MaterialAvailable materialAvailable2 = MaterialAvailable(
  name: "MediumBar",
  image: "assets/images/exercices/image_exercice2.png",
);
MaterialAvailable materialAvailable3 = MaterialAvailable(
  name: "Bench",
  image: "assets/images/exercices/image_exercice3.png",
);
MaterialAvailable materialAvailable4 = MaterialAvailable(
  name: "MonkeyBar",
  image: "assets/images/exercices/image_exercice4.png",
);
MaterialAvailable materialAvailable5 = MaterialAvailable(
  name: "HighVerticalBar",
  image: "assets/images/exercices/image_exercice5.png",
);
