import 'dart:ui';

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
  late List<bool> like;
  List<Map<String, dynamic>> _allRecipes = [];

  @override
  void initState() {
    super.initState();
    like = [false];
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
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            _allRecipes = snapshot.data;
            //like.length = _allRecipes.length.toInt();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Container(
                                        width: 250,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.white.withOpacity(.4),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                _allRecipes[index]['image']),
                                            fit: BoxFit.cover,
                                          ),
                                          color: Colors.white.withOpacity(.4),
                                        ),
                                      ),
                                      // Align(
                                      //   alignment: Alignment.bottomCenter,
                                      //   child: ClipRRect(
                                      //     child: BackdropFilter(
                                      //       filter: ImageFilter.blur(
                                      //           sigmaX: 0, sigmaY: 3),
                                      //       child: Padding(
                                      //         padding: const EdgeInsets.all(10),
                                      //         child: Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment
                                      //                   .spaceBetween,
                                      //           crossAxisAlignment:
                                      //               CrossAxisAlignment.center,
                                      //           children: [
                                      //             Row(
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment
                                      //                       .spaceBetween,
                                      //               crossAxisAlignment:
                                      //                   CrossAxisAlignment
                                      //                       .center,
                                      //               children: [
                                      //                 IconButton(
                                      //                   tooltip: 'Like',
                                      //                   onPressed: () {
                                      //                     setState(() {
                                      //                       if (like[index] ==
                                      //                           true) {
                                      //                         _allRecipes[index]
                                      //                             ['like'] -= 1;
                                      //                         like[index] =
                                      //                             false;
                                      //                       } else {
                                      //                         like[index] =
                                      //                             true;
                                      //                         _allRecipes[index]
                                      //                             ['like'] += 1;
                                      //                       }
                                      //                     });
                                      //                   },
                                      //                   icon: SizedBox(
                                      //                     child: Icon(
                                      //                       ((like[index] ==
                                      //                               true)
                                      //                           ? Icons.favorite
                                      //                           : Icons
                                      //                               .favorite_border_outlined),
                                      //                       size: 30,
                                      //                       color:
                                      //                           (like[index] ==
                                      //                                   true)
                                      //                               ? Colors.red
                                      //                               : Colors
                                      //                                   .white,
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //                 const SizedBox(width: 5),
                                      //                 Text(
                                      //                   _allRecipes[index]
                                      //                           ['like']
                                      //                       .toString(),
                                      //                   style: TextStyle(
                                      //                     color: (like[index] ==
                                      //                             true)
                                      //                         ? Colors.red
                                      //                         : Colors.white,
                                      //                     fontSize: 20,
                                      //                     fontWeight:
                                      //                         FontWeight.bold,
                                      //                   ),
                                      //                 )
                                      //               ],
                                      //             ),
                                      //             Row(
                                      //               children: [
                                      //                 IconButton(
                                      //                   tooltip: "Total Time",
                                      //                   onPressed: () {},
                                      //                   icon: const SizedBox(
                                      //                     child: Icon(
                                      //                       Icons.timer,
                                      //                       size: 30,
                                      //                       color: Colors.white,
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //                 const SizedBox(width: 5),
                                      //                 Text(
                                      //                   _allRecipes[index][
                                      //                               'totalTime']
                                      //                           .toString()
                                      //                           .split('.')[0] +
                                      //                       " mins",
                                      //                   style: const TextStyle(
                                      //                     color: Colors.white,
                                      //                     fontSize: 20,
                                      //                     fontWeight:
                                      //                         FontWeight.bold,
                                      //                   ),
                                      //                 )
                                      //               ],
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      _allRecipes[index]['name'],
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: UI.appColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Creator(_allRecipes[index]['creator']?['id']),

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
