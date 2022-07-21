class MaterialAvailable {
  final String name, image;

  MaterialAvailable({
    required this.name,
    required this.image,
  });

  static List<MaterialAvailable> buildRow(List list) {
    List<MaterialAvailable> listMaterialAvailable = [];
    // List<String> tmp = list;
    for (String s in list) {
      if (s == materialAvailable0.name) {
        listMaterialAvailable.add(materialAvailable0);
      } else if (s == materialAvailable1.name) {
        listMaterialAvailable.add(materialAvailable1);
      } else if (s == materialAvailable2.name) {
        listMaterialAvailable.add(materialAvailable2);
      } else if (s == materialAvailable3.name) {
        listMaterialAvailable.add(materialAvailable3);
      } else if (s == materialAvailable4.name) {
        listMaterialAvailable.add(materialAvailable4);
      } else if (s == materialAvailable5.name) {
        listMaterialAvailable.add(materialAvailable5);
      }
    }
    return listMaterialAvailable;
  }
}

MaterialAvailable materialAvailable0 = MaterialAvailable(
  name: "Traction",
  image: "assets/images/exercices/image_exercice0.png",
);
MaterialAvailable materialAvailable1 = MaterialAvailable(
  name: "Dips",
  image: "assets/images/exercices/image_exercice1.png",
);
MaterialAvailable materialAvailable2 = MaterialAvailable(
  name: "Medium bar",
  image: "assets/images/exercices/image_exercice2.png",
);
MaterialAvailable materialAvailable3 = MaterialAvailable(
  name: "Bench",
  image: "assets/images/exercices/image_exercice3.png",
);
MaterialAvailable materialAvailable4 = MaterialAvailable(
  name: "Monkey bar",
  image: "assets/images/exercices/image_exercice4.png",
);
MaterialAvailable materialAvailable5 = MaterialAvailable(
  name: "High vertical bar",
  image: "assets/images/exercices/image_exercice5.png",
);

List<MaterialAvailable> materialAvailableList = [
  materialAvailable0,
  materialAvailable1,
  materialAvailable2,
  materialAvailable3,
  materialAvailable4,
  materialAvailable5,
];
