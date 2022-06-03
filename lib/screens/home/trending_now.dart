import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x2mint_recipes/screens/recipe/seeAllRecipesPage.dart';
import 'package:x2mint_recipes/screens/recipe/detailRecipe.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/services/user.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/utils/screen_utils.dart';
import 'package:x2mint_recipes/widgets/creator.dart';

class TrendingNow extends StatefulWidget {
  final String tittle = "Trending Now";
  const TrendingNow({
    Key? key,
  }) : super(key: key);

  @override
  State<TrendingNow> createState() => _TrendingNowState();
}

class _TrendingNowState extends State<TrendingNow> {
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
            //print(_allRecipes);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Trending 💥",
                        style: TextStyle(
                          color: Colors.white.withOpacity(.8),
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          ScreenUtils.pushScreen(
                              context: context,
                              screen: SeeAllPage(
                                data: _allRecipes,
                                tittle: "Trending 💥",
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
                      children: List.generate(
                        _allRecipes.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: GestureDetector(
                              onTap: () {
                                ScreenUtils.pushScreen(
                                  context: context,
                                  screen:
                                      RecipeDetail(_allRecipes[index]['id']),
                                );
                              },
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
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Creator(_allRecipes[index]['creator'].id),
                                  //Text(_allRecipes[index]['creator']),
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
