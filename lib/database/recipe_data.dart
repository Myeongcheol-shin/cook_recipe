class RecipeDB {
  int? id;
  final String serialNumber;
  final String recipeName;
  final String img;

  RecipeDB(
      {this.id,
      required this.serialNumber,
      required this.recipeName,
      required this.img});

  factory RecipeDB.fromMap(Map<String, dynamic> json) => RecipeDB(
      serialNumber: json['serialNumber'],
      recipeName: json['recipeName'],
      img: json['img']);

  Map<String, dynamic> toMap() {
    return {'serialNumber': serialNumber, 'recipeName': recipeName, 'img': img};
  }
}
