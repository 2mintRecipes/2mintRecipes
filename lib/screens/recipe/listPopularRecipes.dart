// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:x2mint_recipes/screens/recipe/detailRecipe.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/utils/screen_utils.dart';

class ListPopularRecipes extends StatefulWidget {
  final String typeId;
  const ListPopularRecipes(this.typeId, {Key? key}) : super(key: key);
  @override
  State<ListPopularRecipes> createState() => _ListPopularRecipesState();
}

class _ListPopularRecipesState extends State<ListPopularRecipes> {
  SecureStorage secureStorage = SecureStorage();
  final RecipesService _recipesService = RecipesService();
  late Future _allRecipesFuture;
  late List<Map<String, dynamic>> _allRecipes = [];
  late String id = widget.typeId;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    _allRecipesFuture = _recipesService.getByType(widget.typeId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _allRecipesFuture,
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            init();
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            _allRecipes = snapshot.data;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    _allRecipes.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: GestureDetector(
                          onTap: () {
                            ScreenUtils.pushScreen(
                              context: context,
                              screen: RecipeDetail(_allRecipes[index]['id']),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 250,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white.withOpacity(.4),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        _allRecipes[index]['image']),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.white.withOpacity(.4),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                _allRecipes[index]['name'],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: UI.appColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 3),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  _allRecipes[index]['description'],
                                  maxLines: 3,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white.withOpacity(.8),
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
