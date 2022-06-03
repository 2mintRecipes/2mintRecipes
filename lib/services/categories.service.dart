import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:x2mint_recipes/dto/category.dto.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/services/db.service.dart';

class CategoryService {
  Future getAll() async {
    try {
      List<Map<String, dynamic>> result =
          await StorageService.getAll('categories');
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future add(CategoryDto data) async {
    try {
      return await StorageService.add('categories', data.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future getOne(String? id) async {
    try {
      return await StorageService.getOne('categories', id!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getByName(String value) async {
    try {
      return await StorageService.search(
        collectionName: 'categories',
        fieldName: 'name',
        value: value,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getByLevel(int value) async {
    try {
      return await StorageService.search(
        collectionName: 'categories',
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
        collectionName: 'categories',
        fieldName: 'serving',
        value: value,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future update(String path, CategoryDto data) async {
    try {
      return await StorageService.update('categories', path, data.toJson());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future remove(String path) async {
    try {
      return await StorageService.delete('categories', path);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
