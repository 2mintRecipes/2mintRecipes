import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/services/db.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';

class RecipesService {
  Future getAll() async {
    try {
      List<Map<String, dynamic>> result =
          await StorageService.getAll('recipes');

      for (var i = 0; i < result.length; i++) {
        result[i]['creator'] =
            await StorageService.getOne("users", result[i]['creator'].id);
        // result[i]['category'] =
        //     await StorageService.getOne("categories", result[i]['category']);
      }

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

  Future getOne(String? id) async {
    try {
      var result = await StorageService.getOne('recipes', id!);
      result['creator'] =
          await StorageService.getOne("users", result['creator'].id);
      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getByName(String value) async {
    try {
      var result = await StorageService.searchLike(
        collectionName: 'recipes',
        fieldName: 'name',
        value: value,
      );
      for (var i = 0; i < result.length; i++) {
        result[i]['creator'] =
            await StorageService.getOne("users", result[i]['creator'].id);
        // result[i]['category'] =
        //     await StorageService.getOne("categories", result[i]['category']);
      }

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getByLevel(int value) async {
    try {
      return await StorageService.search(
        collectionName: 'recipes',
        fieldName: 'level',
        value: value,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getByServing(int value) async {
    try {
      return await StorageService.search(
        collectionName: 'recipes',
        fieldName: 'serving',
        value: value,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getByCreatorId(dynamic value) async {
    try {
      var allRecipes = await StorageService.getAll('recipes');
      List result = allRecipes.where((element) {
        return element['creator'].id == value;
      }).toList();
      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getByType(String value) async {
    try {
      List<Map<String, dynamic>> result = await StorageService.search(
        collectionName: 'recipes',
        fieldName: 'category',
        value: value,
      );
      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future isAuthor(String creatorId) async {
    try {
      SecureStorage secureStorage = SecureStorage();
      var uid = await secureStorage.readSecureData('uid');
      var result = await StorageService.search(
        collectionName: 'users',
        fieldName: 'uid',
        value: uid,
      );
      return result[0]['id'] == creatorId;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future update(String path, RecipeDto data) async {
    try {
      await StorageService.update('recipes', path, data.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future getTrending() async {
    try {
      var result = await StorageService.searchGreather(
        collectionName: 'recipes',
        fieldName: "like",
        value: 0,
      );

      for (var i = 0; i < result.length; i++) {
        result[i]['creator'] =
            await StorageService.getOne("users", result[i]['creator'].id);
        // result[i]['category'] =
        //     await StorageService.getOne("categories", result[i]['category']);
      }

      return result;
    } catch (e) {
      print(e);
    }
  }

  Future remove(String path) async {
    try {
      return await StorageService.delete('recipes', path);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
