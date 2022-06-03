import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x2mint_recipes/dto/user.dto.dart';
import 'package:x2mint_recipes/screens/recipe/create.dart';
import 'package:x2mint_recipes/services/cloudinary.service.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/services/user.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/utils/screen_utils.dart';
import 'package:x2mint_recipes/widgets/category.dart';
import 'package:x2mint_recipes/widgets/creator.dart';
import 'package:x2mint_recipes/widgets/text_field.dart';

class RecipeDetail extends StatefulWidget {
  static const routeName = '/RecipeDetail';
  final String id;
  const RecipeDetail(this.id, {Key? key}) : super(key: key);

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  final _formKeyIngredients = GlobalKey<FormState>();
  final _formKeySteps = GlobalKey<FormState>();
  SecureStorage secureStorage = SecureStorage();
  final RecipesService _recipesService = RecipesService();
  final UserService _userService = UserService();
  late Future _recipeFuture;
  late Map<String, dynamic> _recipe;
  late String id = widget.id;
  late bool like = false;
  late bool isAuthor = false;
  UserDto? currentUser;

  @override
  void initState() {
    super.initState();
    like = false;
    init();
  }

  Future init() async {
    _recipeFuture = _recipesService.getOne(id);
    currentUser = await _userService.getCurrentUser();
    var recipe = await _recipesService.getOne(id);
    setState(() {
      isAuthor = recipe['creator'].id == currentUser?.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _recipeFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          _recipe = snapshot.data;

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
        return Container();
      },
    );
  }

  Widget getBannerSection() {
    return GestureDetector(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  width: 250,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.transparent,
                    ),
                    image: (_recipe['image'] == '')
                        ? const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/welcome_bg.jpg'),
                          )
                        : DecorationImage(
                            image: NetworkImage(_recipe['image']),
                            fit: BoxFit.cover,
                          ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * .75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTitleSection(),
                    getFavoriteAndTimeSection(),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Creator(_recipe['creator'].id),
          ),
          TextView(
            text: _recipe['description'],
            fontSize: 15,
            width: MediaQuery.of(context).size.width - 20,
            color: Colors.transparent,
            maxLine: 15,
            border: const BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          const SizedBox(height: 5)
        ],
      ),
    ));
  }

  Widget getBasicInfoSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextView(
              text: _recipe['serving'].toString().split('.')[0],
              icon: Icons.supervisor_account,
              fontSize: 20,
              width: MediaQuery.of(context).size.width * .1,
            ),
            const SizedBox(height: 10),
            TextView(
              text: _recipe['level'].toString().split('.')[0],
              icon: Icons.star,
              fontSize: 20,
              width: MediaQuery.of(context).size.width * .1,
            ),
            TextView(
              text: _recipe['cookTime'].toString().split('.')[0],
              icon: Icons.schedule,
              fontSize: 20,
              width: MediaQuery.of(context).size.width * .2,
            ),
          ],
        ),
        const SizedBox(height: 15),

        /// Category
        Category(_recipe['category'].toString()),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget getBody() {
    return Column(
      children: [
        getBannerSection(),
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getBasicInfoSection(),
              getIngredientSection(),
              getStepsSection(),
              isAuthor ? getEditWidget() : Container(),
            ],
          ),
        )
      ],
    );
  }

  Widget getEditWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton.icon(
                onPressed: _editRecipe,
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: UI.appColor,
                  shape: RoundedRectangleBorder(
                    //to set border radius to button
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.ramen_dining),
                label: const Text(
                  "Edit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFavoriteAndTimeSection() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(5),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 3),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Like',
                      onPressed: () {
                        setState(() {
                          if (like == true) {
                            _recipe['like'] -= 1;
                            like = false;
                          } else {
                            like = true;
                            _recipe['like'] += 1;
                          }
                        });
                      },
                      icon: SizedBox(
                        child: Icon(
                          ((like == true)
                              ? Icons.favorite
                              : Icons.favorite_border_outlined),
                          size: 30,
                          color: (like == true) ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _recipe['like'].toString(),
                      style: TextStyle(
                        color: (like == true) ? Colors.red : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      tooltip: "Total Time",
                      onPressed: () {},
                      icon: const SizedBox(
                        child: Icon(
                          Icons.timer,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _recipe['totalTime'].toString().split('.')[0] + " mins",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getIngredientItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextView(
            width: MediaQuery.of(context).size.width * .4,
            text: _recipe["ingredients"][index - 1]['name'] ?? '',
            fontSize: 20,
          ),
          TextView(
            width: MediaQuery.of(context).size.width * .3,
            text: _recipe["ingredients"][index - 1]["amount"] ?? '',
            fontSize: 20,
            maxLine: 5,
          ),
        ],
      ),
    );
  }

  Widget getIngredientSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(.4),
      ),
      child: Form(
        key: _formKeyIngredients,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "INGREDIENTS",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// INGREDIENT
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      _recipe["ingredients"] != null
                          ? _recipe["ingredients"].length
                          : 0,
                      (index) => getIngredientItem(index + 1))),
            ),
          ],
        ),
      ),
    );
  }

  Widget getStepItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(.1),
              ),
              borderRadius: BorderRadius.circular(15),
              color: UI.appColor,
            ),
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            child: Text(
              _recipe["steps"][index - 1]["title"] ?? '',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(height: 10),
          TextView(
            width: MediaQuery.of(context).size.width * .75,
            maxLine: 10,
            text: _recipe["steps"][index - 1]["detail"] ?? '',
            fontSize: 20,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget getStepsSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(.4),
      ),
      child: Form(
        key: _formKeySteps,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "STEPS",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// Steps
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              child: Column(
                children: List.generate(
                    _recipe["steps"] != null ? _recipe["steps"].length : 0,
                    (index) => getStepItem(index + 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTitleSection() {
    return Padding(
      padding: const EdgeInsets.only(top: UI.topPadding),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  //Navigator.pushNamed(context, '/');
                },
                icon: const SizedBox(
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                )),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              child: Text(
                _recipe['name'],
                maxLines: 5,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _editRecipe() {
    ScreenUtils.pushScreen(context: context, screen: CreateRecipe(widget.id));
  }
}
