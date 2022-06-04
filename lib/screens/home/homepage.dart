import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:x2mint_recipes/screens/home/hot_creators.dart';
import 'package:x2mint_recipes/screens/home/popular_categories.dart';
import 'package:x2mint_recipes/screens/home/recent_recipes.dart';
import 'package:x2mint_recipes/screens/home/trending_now.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/widgets/search_cart.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeMenu = 0;
  SecureStorage secureStorage = SecureStorage();
  RecipesService recipesService = RecipesService();
  // late Future _allRecipesFuture;
  // List<Map<String, dynamic>> _allRecipes = [];

  @override
  void initState() {
    super.initState();
    //init();
  }

  // Future init() async {
  //   _allRecipesFuture = recipesService.getAll();
  // }

  // void _pushScreen({required BuildContext context, required Widget screen}) {
  //   ThemeData themeData = Theme.of(context);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => Theme(data: themeData, child: screen),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(.6),
                    BlendMode.darken,
                  ),
                  image: const AssetImage("assets/images/bg.jpg"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ClipRRect(
                // borderRadius: BorderRadius.circular(5),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: SingleChildScrollView(
                      child: getBody(),
                    ))),
          )
        ],
      ),
    );
  }

  Widget getTitle() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 30,
        top: UI.topPadding,
      ),
      child: Text(
        '2mint Recipes',
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget getBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// Title
        getTitle(),

        /// Search card
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
          child: SearchCard(),
        ),

        /// Trending now
        const TrendingNow(),

        // /// Popular Category Bar
        const PopularCategories(),

        // /// Recent Recipes
        // const RecentRecipes(),

        // /// Hot Creators
        // const HotCreators(),
      ],
    );
  }
}
