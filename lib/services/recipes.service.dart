import 'package:x2mint_recipes/services/db.service.dart';

class RecipesService {
  Future getAllRecipes() async {
    try {
      List<Map<String, dynamic>> result =
          await StorageService.getAll('recipes');

      return result;
    } catch (e) {
      print(e);
    }
  }
}
