import 'dart:convert';

import 'package:recipe_app/models/spoonacular_mensures_model.dart';

class ExtendedIngredients {
  int? id;
  String? aisle;
  String? image;
  String? consistency;
  String? name;
  String? nameClean;
  String? original;
  String? originalString;
  String? originalName;
  double amount;
  String? unit;
  List<String> meta;
  List<String> metaInformation;
  Measures measures;
  ExtendedIngredients({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalString,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.meta,
    required this.metaInformation,
    required this.measures,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aisle': aisle,
      'image': image,
      'consistency': consistency,
      'name': name,
      'nameClean': nameClean,
      'original': original,
      'originalString': originalString,
      'originalName': originalName,
      'amount': amount,
      'unit': unit,
      'meta': meta,
      'metaInformation': metaInformation,
      'measures': measures.toMap(),
    };
  }

  factory ExtendedIngredients.fromMap(Map<String, dynamic> map) {
    return ExtendedIngredients(
      id: map['id'],
      aisle: map['aisle'],
      image: map['image'],
      consistency: map['consistency'],
      name: map['name'],
      nameClean: map['nameClean'],
      original: map['original'],
      originalString: map['originalString'],
      originalName: map['originalName'],
      amount: map['amount'],
      unit: map['unit'],
      meta: List<String>.from(map['meta']),
      metaInformation: List<String>.from(map['metaInformation']),
      measures: Measures.fromMap(map['measures']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExtendedIngredients.fromJson(String source) =>
      ExtendedIngredients.fromMap(json.decode(source));
}
