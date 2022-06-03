import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/dto/user.dto.dart';
import 'package:x2mint_recipes/services/db.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';

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
      return await StorageService.getOne('users', id);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserDto?> getUserByUid(String uid) async {
    try {
      var users = await StorageService.search(
        collectionName: 'users',
        fieldName: 'uid',
        value: uid,
      );

      if (users.length > 0) {
        return UserDto.fromJson(users[0]);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserDto?> getCurrentUser() async {
    try {
      SecureStorage secureStorage = SecureStorage();
      var uid = await secureStorage.readSecureData('uid');
      var users = await StorageService.search(
        collectionName: 'users',
        fieldName: 'uid',
        value: uid,
      );

      if (users.length > 0) {
        return UserDto.fromJson(users[0]);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getUserDocRefByUid(String uid) async {
    try {
      var users = await StorageService.search(
        collectionName: 'users',
        fieldName: 'uid',
        value: uid,
      );

      if (users.length > 0) {
        return StorageService.getDocRef("users", users[0]['id']);
      } else {
        return null;
      }
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

  Future addRaw(Map<String, dynamic> data) async {
    try {
      return await StorageService.add('users', data);
    } catch (e) {
      print(e);
    }
  }

  Future update(String path, UserDto data) async {
    try {
      await StorageService.update('users', path, data.toJson());
    } catch (e) {
      print(e);
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
}
