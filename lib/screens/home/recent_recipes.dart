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

class RecentRecipes extends StatefulWidget {
  final String tittle = "Trending Now";

  const RecentRecipes({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentRecipes> createState() => _RecentRecipesState();
}

class _RecentRecipesState extends State<RecentRecipes> {
  int activeMenu = 0;
  SecureStorage secureStorage = SecureStorage();
  RecipesService recipesService = RecipesService();
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 20, bottom: 10, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Recipes",
                        style: TextStyle(
                          color: Colors.white.withOpacity(.8),
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          _pushScreen(
                              context: context,
                              screen: SeeAllPage(
                                data: _allRecipes,
                                tittle: "Recent Recipes",
                              ));
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 25,
                          color: Colors.white.withOpacity(.5),
                        ),
                        label: Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(.5),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        _allRecipes.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
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
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.white.withOpacity(.5),
                                        child: const Text(
                                          'MT',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '  By ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white.withOpacity(.7),
                                        ),
                                      )
                                    ],
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
              ],
            );
          }
          return Container();
        });
  }
}
