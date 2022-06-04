import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x2mint_recipes/screens/recipe/listPopularRecipes.dart';
import 'package:x2mint_recipes/screens/recipe/seeAllRecipesPage.dart';
import 'package:x2mint_recipes/screens/recipe/detailRecipe.dart';
import 'package:x2mint_recipes/services/categories.service.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/services/user.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/utils/database.dart';
import 'package:x2mint_recipes/widgets/creator.dart';

class PopularCategories extends StatefulWidget {
  //final String tittle = "Trending Now";
  const PopularCategories({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularCategories> createState() => _PopularCategoriesState();
}

class _PopularCategoriesState extends State<PopularCategories> {
  int activeMenu = 0;
  SecureStorage secureStorage = SecureStorage();
  CategoryService categoryService = CategoryService();
  late Future _allCategoriesFuture;
  late String typeId;
  List<Map<String, dynamic>> _allCategories = [];

  @override
  void initState() {
    super.initState();
    init();
    typeId = 'monanvat';
  }

  Future init() async {
    _allCategoriesFuture = categoryService.getAll();
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
        future: _allCategoriesFuture,
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            _allCategories = snapshot.data;
            //print(_allCategories);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 20,
                    bottom: 10,
                    top: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular Category",
                        style: TextStyle(
                          color: Colors.white.withOpacity(.8),
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                        ),
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
                        _allCategories.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  activeMenu = index;
                                  typeId = _allCategories[index]["id"];
                                  //print(_allCategories[index]["id"]);
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
                                        _allCategories[index]["name"],
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
                //Text(typeId),
                ListPopularRecipes(typeId),

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
