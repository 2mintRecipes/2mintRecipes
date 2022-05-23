import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:x2mint_recipes/services/db.service.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/components/search_cart.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/utils/database.dart';

import 'Widgets/trendingNow.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _allRecipesFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          _allRecipes = snapshot.data;
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

        return Container();
      },
    );
  }

  Widget getBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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

        /// Popular Category Bar
        getPopularCategory(),

        /// Recent Recipes
        getRecentRecipes(),

        /// Hot Creators
        getHotCreators(),
      ],
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

  Widget _sizedContainer(Widget child) {
    return SizedBox(
      width: 300.0,
      height: 150.0,
      child: Center(child: child),
    );
  }

  Widget getPopularCategory() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 20, bottom: 10, top: 30),
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
                                  left: 10, right: 10, bottom: 5),
                              child: Text(
                                song_type_1[index],
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
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
                                  image:
                                      NetworkImage(_allRecipes[index]['image']),
                                  fit: BoxFit.cover),
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
                                  fontWeight: FontWeight.w200),
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

  Widget getRecentRecipes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 20, bottom: 10, top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Recipes",
                style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                    fontSize: 27,
                    fontWeight: FontWeight.w600),
              ),
              TextButton.icon(
                onPressed: () {},
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
                                  image:
                                      NetworkImage(_allRecipes[index]['image']),
                                  fit: BoxFit.cover),
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
                                fontWeight: FontWeight.w500),
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
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(.5),
                                child: const Text(
                                  'MT',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
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

  Widget getHotCreators() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 20, bottom: 10, top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hot Creators",
                style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                    fontSize: 27,
                    fontWeight: FontWeight.w600),
              ),
              TextButton.icon(
                onPressed: () {},
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
                      onTap: () {},
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/MIT2021.png'),
                                radius: 50,
                                backgroundColor: UI.appColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Taylor Swift",
                            style: TextStyle(
                                color: Colors.white.withOpacity(.7),
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 20,
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
}
