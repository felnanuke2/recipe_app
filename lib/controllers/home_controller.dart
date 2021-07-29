import 'dart:async';

import 'package:recipe_app/interfaces/recipes_getter_interface.dart';
import 'package:recipe_app/models/sponacular_recipe_model.dart';

class HomeController {
  String? cousine;
  final RecipesGetterInterface repository;
  var _recipesListStreamCotnroller = StreamController<List<SpoonacularRecipeModel>>.broadcast();

  void dispose() {
    _recipesListStreamCotnroller.close();
  }

  Stream<List<SpoonacularRecipeModel>> get recipesListStream => _recipesListStreamCotnroller.stream;

  HomeController({
    required this.repository,
  });
  Future<void> getRandomRecipes() async {
    var list = await repository.getRandomRecipes(cousines: cousine);
    _recipesListStreamCotnroller.add(list);
    return;
  }
}
