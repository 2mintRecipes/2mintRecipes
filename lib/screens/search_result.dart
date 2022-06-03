import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/widgets/creator.dart';
import 'package:x2mint_recipes/widgets/search_cart.dart';
import 'package:x2mint_recipes/utils/database.dart';

class SearchResult extends StatefulWidget {
  static const routeName = '/search';
  final String searchText;
  const SearchResult(this.searchText, {Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
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
    _allRecipesFuture = recipesService.getByName(widget.searchText);
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
                ),
              ),
            ),
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

        getSearchSummary(),

        /// Bookmark Items
        getListItems(),
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
            "Search",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget getSearchSummary() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Found ${_allRecipes.length} recipes for ``${widget.searchText}``.",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  getImage(String? _imageUrl) {
    try {
      _imageUrl ??= defaultRecipeImage;
      return NetworkImage(_imageUrl);
    } catch (e) {
      assert(false, e.toString());
      return const NetworkImage(defaultRecipeImage);
    }
  }

  Widget getListItems() {
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
            return const Center(child: CircularProgressIndicator());
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Creator(_allRecipes[index]['creator']['id']),
                          const SizedBox(height: 30),
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
