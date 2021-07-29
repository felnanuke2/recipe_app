import 'dart:convert';

import 'package:recipe_app/models/spoonacular_igredients_and_equipments.dart';

class AnalyzedInstructions {
  String name;
  List<Steps> steps;
  AnalyzedInstructions({
    required this.name,
    required this.steps,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'steps': steps.map((x) => x.toMap()).toList(),
    };
  }

  factory AnalyzedInstructions.fromMap(Map<String, dynamic> map) {
    return AnalyzedInstructions(
      name: map['name'],
      steps: List<Steps>.from(map['steps']?.map((x) => Steps.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnalyzedInstructions.fromJson(String source) =>
      AnalyzedInstructions.fromMap(json.decode(source));
}

class Steps {
  int number;
  String step;
  List<Ingredients> ingredients;
  List<Equipment> equipment;
  Steps({
    required this.number,
    required this.step,
    required this.ingredients,
    required this.equipment,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'step': step,
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
      'equipment': equipment.map((x) => x.toMap()).toList(),
    };
  }

  factory Steps.fromMap(Map<String, dynamic> map) {
    return Steps(
      number: map['number'],
      step: map['step'],
      ingredients: List<Ingredients>.from(map['ingredients']?.map((x) => Ingredients.fromMap(x))),
      equipment: List<Equipment>.from(map['equipment']?.map((x) => Equipment.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Steps.fromJson(String source) => Steps.fromMap(json.decode(source));
}
