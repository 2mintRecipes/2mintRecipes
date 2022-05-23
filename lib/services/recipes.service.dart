import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/services/db.service.dart';

class RecipesService {
  Future getAll() async {
    try {
      List<Map<String, dynamic>> result =
          await StorageService.getAll('recipes');

      return result;
    } catch (e) {
      print(e);
    }
  }

  Future add(RecipeDto data) async {
    try {
      return await StorageService.add('recipes', data.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<RecipeDto?> getOne() async {
    try {
      RecipeDto response = RecipeDto();
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
