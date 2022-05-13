import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:x2mint_recipes/Screen/root.dart';
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
