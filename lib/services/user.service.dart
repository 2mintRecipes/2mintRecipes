import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/dto/user.dto.dart';
import 'package:x2mint_recipes/services/db.service.dart';

class UserService {
  Future getAll() async {
    try {
      List<Map<String, dynamic>> result = await StorageService.getAll('users');

      return result;
    } catch (e) {
      print(e);
    }
  }

  Future getOne(String id) async {
    try {
      return await StorageService.get('users', id);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future add(UserDto data) async {
    try {
      return await StorageService.add('users', data.toJson());
    } catch (e) {
      print(e);
    }
  }

  //TODO fix
  Future update(UserDto data) async {
    try {
      return await StorageService.add('users', data.toJson());
    } catch (e) {
      print(e);
    }
  }
}
