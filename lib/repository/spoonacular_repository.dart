import 'dart:convert';

import 'package:recipe_app/constants/constants_var_name.dart';
import 'package:recipe_app/interfaces/recipes_getter_interface.dart';
import 'package:recipe_app/models/sponacular_recipe_model.dart';
import 'package:http/http.dart' as http;

class SpoonacularRepository implements RecipesGetterInterface {
  @override
  Future<List<SpoonacularRecipeModel>> getRandomRecipes(
      {int recipesCount = 10, String? cousines}) async {
    String cousinesTxt = cousines == null ? '' : '&tags=${cousines.toLowerCase()}';
    var apiUrl =
        '$SPONACULAT_BASE_URL/recipes/random?apiKey=$SPOONACULAR_API_KEY&number=$recipesCount$cousinesTxt';
    var response = await http.get(Uri.parse(apiUrl), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var recipesList = List<Map<String, dynamic>>.from(json['recipes']);
      var list = List<SpoonacularRecipeModel>.from(
          recipesList.map((e) => SpoonacularRecipeModel.fromMap(e)));
      list.removeWhere((element) => element.image?.isEmpty ?? true);
      return list;
    }
    return [];
  }
}
