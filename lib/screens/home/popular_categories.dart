import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x2mint_recipes/screens/recipe/seeAllRecipesPage.dart';
import 'package:x2mint_recipes/screens/recipe/detailRecipe.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/services/user.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/utils/database.dart';
import 'package:x2mint_recipes/widgets/creator.dart';

class PopularCategories extends StatefulWidget {
  final String tittle = "Trending Now";
  const PopularCategories({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularCategories> createState() => _PopularCategoriesState();
}

class _PopularCategoriesState extends State<PopularCategories> {
  int activeMenu = 0;
  SecureStorage secureStorage = SecureStorage();
  RecipesService recipesService = RecipesService();
  //UserService userService = UserService();
  late Future _allRecipesFuture;

  List<Map<String, dynamic>> _allRecipes = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    _allRecipesFuture = recipesService.getAll();
  }

  void _pushScreen({required BuildContext context, required Widget screen}) {
    ThemeData themeData = Theme.of(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Theme(data: themeData, child: screen),
      ),
    );
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
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            _allRecipes = snapshot.data;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 20, bottom: 10, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular Category",
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 27,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  //lists with kind tags
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                      children: List.generate(
                        song_type_1.length,
                        (index) {
                          ////////// list tags
                          return Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  activeMenu = index;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black.withOpacity(.1),
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      color: activeMenu == index
                                          ? UI.appColor
                                          : Colors.black.withOpacity(.1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        song_type_1[index],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
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
                ),

                const SizedBox(
                  height: 20,
                ),

                /// View Popular Category
                SingleChildScrollView(
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
                              onTap: () {},
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
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }
          return Container();
        });
  }
}
