import 'dart:convert';

class Ingredients {
  int id;
  String name;
  String localizedName;
  String image;
  Ingredients({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'localizedName': localizedName,
      'image': image,
    };
  }

  factory Ingredients.fromMap(Map<String, dynamic> map) {
    return Ingredients(
      id: map['id'],
      name: map['name'],
      localizedName: map['localizedName'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredients.fromJson(String source) => Ingredients.fromMap(json.decode(source));
}

class Equipment {
  int id;
  String name;
  String localizedName;
  String image;
  Equipment({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'localizedName': localizedName,
      'image': image,
    };
  }

  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
      id: map['id'],
      name: map['name'],
      localizedName: map['localizedName'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Equipment.fromJson(String source) => Equipment.fromMap(json.decode(source));
}
