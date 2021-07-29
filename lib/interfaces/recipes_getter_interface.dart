import 'package:recipe_app/models/sponacular_recipe_model.dart';

abstract class RecipesGetterInterface {
  Future<List<SpoonacularRecipeModel>> getRandomRecipes({int recipesCount = 10, String? cousines});
}
