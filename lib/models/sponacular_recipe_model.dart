import 'dart:convert';

import 'package:recipe_app/models/spoonacular_analyzed_instructions.dart';
import 'package:recipe_app/models/spoonacular_extended_igredients_model.dart';

class SpoonacularRecipeModel {
  bool vegetarian;
  bool vegan;
  bool glutenFree;
  bool dairyFree;
  bool veryHealthy;
  bool cheap;
  bool veryPopular;
  bool sustainable;
  num? weightWatcherSmartPonums;
  String? gaps;
  bool lowFodmap;
  num aggregateLikes;
  num spoonacularScore;
  num healthScore;
  String? creditsText;
  String? license;
  String? sourceName;
  double pricePerServing;
  List<ExtendedIngredients> extendedIngredients;
  num id;
  String title;
  num readyInMinutes;
  num servings;
  String sourceUrl;
  String? image;
  String? imageType;
  String? summary;

  List<String> dishTypes;
  List<String> diets;
  List<String> occasions;
  String instructions;
  List<AnalyzedInstructions> analyzedInstructions;
  String spoonacularSourceUrl;
  SpoonacularRecipeModel({
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.veryHealthy,
    required this.cheap,
    required this.veryPopular,
    required this.sustainable,
    required this.weightWatcherSmartPonums,
    required this.gaps,
    required this.lowFodmap,
    required this.aggregateLikes,
    required this.spoonacularScore,
    required this.healthScore,
    required this.creditsText,
    required this.license,
    required this.sourceName,
    required this.pricePerServing,
    required this.extendedIngredients,
    required this.id,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.image,
    required this.imageType,
    required this.summary,
    required this.dishTypes,
    required this.diets,
    required this.occasions,
    required this.instructions,
    required this.analyzedInstructions,
    required this.spoonacularSourceUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'vegetarian': vegetarian,
      'vegan': vegan,
      'glutenFree': glutenFree,
      'dairyFree': dairyFree,
      'veryHealthy': veryHealthy,
      'cheap': cheap,
      'veryPopular': veryPopular,
      'sustainable': sustainable,
      'weightWatcherSmartPonums': weightWatcherSmartPonums,
      'gaps': gaps,
      'lowFodmap': lowFodmap,
      'aggregateLikes': aggregateLikes,
      'spoonacularScore': spoonacularScore,
      'healthScore': healthScore,
      'creditsText': creditsText,
      'license': license,
      'sourceName': sourceName,
      'pricePerServing': pricePerServing,
      'extendedIngredients': extendedIngredients.map((x) => x.toMap()).toList(),
      'id': id,
      'title': title,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
      'sourceUrl': sourceUrl,
      'image': image,
      'imageType': imageType,
      'summary': summary,
      'dishTypes': dishTypes,
      'diets': diets,
      'occasions': occasions,
      'instructions': instructions,
      'analyzedInstructions': analyzedInstructions.map((x) => x.toMap()).toList(),
      'spoonacularSourceUrl': spoonacularSourceUrl,
    };
  }

  factory SpoonacularRecipeModel.fromMap(Map<String, dynamic> map) {
    return SpoonacularRecipeModel(
      vegetarian: map['vegetarian'],
      vegan: map['vegan'],
      glutenFree: map['glutenFree'],
      dairyFree: map['dairyFree'],
      veryHealthy: map['veryHealthy'],
      cheap: map['cheap'],
      veryPopular: map['veryPopular'],
      sustainable: map['sustainable'],
      weightWatcherSmartPonums: map['weightWatcherSmartPonums'],
      gaps: map['gaps'],
      lowFodmap: map['lowFodmap'],
      aggregateLikes: map['aggregateLikes'],
      spoonacularScore: map['spoonacularScore'],
      healthScore: map['healthScore'],
      creditsText: map['creditsText'],
      license: map['license'],
      sourceName: map['sourceName'],
      pricePerServing: map['pricePerServing'],
      extendedIngredients: List<ExtendedIngredients>.from(
          map['extendedIngredients']?.map((x) => ExtendedIngredients.fromMap(x))),
      id: map['id'],
      title: map['title'],
      readyInMinutes: map['readyInMinutes'],
      servings: map['servings'],
      sourceUrl: map['sourceUrl'],
      image: map['image'],
      imageType: map['imageType'],
      summary: map['summary'],
      dishTypes: List<String>.from(map['dishTypes']),
      diets: List<String>.from(map['diets']),
      occasions: List<String>.from(map['occasions']),
      instructions: map['instructions'],
      analyzedInstructions: List<AnalyzedInstructions>.from(
          map['analyzedInstructions']?.map((x) => AnalyzedInstructions.fromMap(x))),
      spoonacularSourceUrl: map['spoonacularSourceUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SpoonacularRecipeModel.fromJson(String source) =>
      SpoonacularRecipeModel.fromMap(json.decode(source));
}
