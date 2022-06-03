import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x2mint_recipes/dto/category.dto.dart';
import 'package:x2mint_recipes/dto/user.dto.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/services/categories.service.dart';
import 'package:x2mint_recipes/widgets/text_field.dart';

class Category extends StatefulWidget {
  final String id;
  const Category(this.id, {Key? key}) : super(key: key);
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  SecureStorage secureStorage = SecureStorage();
  CategoryService categoryService = CategoryService();
  late Future _categoryFuture;
  late CategoryDto _category;
  late String id = widget.id;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    _categoryFuture = categoryService.getOne(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categoryFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          _category = CategoryDto.fromJson(snapshot.data);

          return TextView(
            icon: Icons.restaurant_menu,
            text: _category.name ?? '',
          );
        }
        return Container();
      },
    );
  }
}
