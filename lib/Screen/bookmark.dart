import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/components/search_cart.dart';
import 'package:x2mint_recipes/utils/database.dart';

class Bookmark extends StatefulWidget {
  static const routeName = '/bookmark';
  const Bookmark({Key? key}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  int activeMenu = 0;
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

  Widget getBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        getTitle(),

        /// Search card
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
          child: SearchCard(),
        ),

        /// Get Bookmark Type
        getBookmarkType(),

        /// Bookmark Items
        getListBookmarkItems(),
      ],
    );
  }

  Widget getTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20, top: UI.topPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Bookmark",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget getBookmarkType() {
    return SingleChildScrollView(
      //lists with kind tags
      controller: ScrollController(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      child: Row(
        children: List.generate(
          song_type_1.length,
          (index) {
            ////////// list tags
            return GestureDetector(
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
                    padding: const EdgeInsets.only(
                        top: 7, bottom: 7, left: 15, right: 15),
                    child: Text(
                      song_type_1[index],
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getListBookmarkItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: ScrollController(),
      child: FutureBuilder(
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
            return Column(
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
                            width: MediaQuery.of(context).size.width - 60,
                            height: MediaQuery.of(context).size.width * .5,
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
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            _allRecipes[index]['name'],
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: UI.appColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
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
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
