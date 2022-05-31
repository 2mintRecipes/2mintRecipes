import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x2mint_recipes/widgets/button.dart';
import 'package:x2mint_recipes/widgets/creator.dart';
import 'package:x2mint_recipes/widgets/input.dart';
import 'package:x2mint_recipes/widgets/text_field.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/services/cloudinary.service.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/utils/database.dart';

class RecipeDetail extends StatefulWidget {
  static const routeName = '/RecipeDetail';
  final String id;
  const RecipeDetail(this.id, {Key? key}) : super(key: key);

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _servingsController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final TextEditingController _totalTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService = CloudinaryService();

  final _formKeyBasicInfo = GlobalKey<FormState>();
  final _formKeyIngredients = GlobalKey<FormState>();
  final _formKeySteps = GlobalKey<FormState>();
  int _numSteps = 0;
  int _numIngredient = 0;

  // late bool showEditButton;
  File? _image;
  String? _imagePath;
  String? _imageUrl;

  SecureStorage secureStorage = SecureStorage();
  final RecipesService _recipesService = RecipesService();
  late Future _recipeFuture;
  late Map<String, dynamic> _recipe;
  late String id = widget.id;
  late bool like = false;

  @override
  void initState() {
    super.initState();
    like = false;
    init();
  }

  Future init() async {
    _recipeFuture = _recipesService.getOne(id);
  }

  Future _editRecipe() async {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _recipeFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          _recipe = snapshot.data;
          print(_recipe);
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

  Widget getBody() {
    return Column(
      children: [
        getBannerSection(),
        Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getBasicInfoSection(),
              getIngredientSection(),
              getStepsSection(),
              getEditWidget(),
            ],
          ),
        )
      ],
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

  Widget getBannerSection() {
    return GestureDetector(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: BorderRadius.circular(15)),
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
                    image: ((_recipe['image'] == '')
                        ? const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/welcome_bg.jpg'))
                        : DecorationImage(
                            image: NetworkImage(_recipe['image']),
                            fit: BoxFit.cover,
                          )),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
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
                  ))
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
          const SizedBox(
            height: 5,
          )
        ],
      ),
    ));
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
                                    color: (like == true)
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(_recipe['like'].toString(),
                                style: TextStyle(
                                    color: (like == true)
                                        ? Colors.red
                                        : Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
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
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              _recipe['totalTime'].toString() + " mins",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ])))),
    );
  }

  Widget getBasicInfoSection() {
    return Form(
      key: _formKeyBasicInfo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextView(
                text: _recipe['serving'].toString(),
                icon: Icons.supervisor_account,
                fontSize: 20,
                width: MediaQuery.of(context).size.width * .1,
              ),
              TextView(
                text: _recipe['level'].toString(),
                icon: Icons.star,
                fontSize: 20,
                width: MediaQuery.of(context).size.width * .1,
              ),
              TextView(
                text: _recipe['cookTime'].toString() + ' mins',
                icon: Icons.schedule,
                fontSize: 20,
                width: MediaQuery.of(context).size.width * .2,
              ),
            ],
          ),
          const SizedBox(height: 15),

          /// Category
          InputField(
            prefixIcon: Icons.restaurant_menu,
            labelText: "Category",
            textEditingController: _categoryController,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget getIngredientSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(.4),
      ),
      child: Form(
        key: _formKeyIngredients,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "INGREDIENT",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// Steps
            GridView.count(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              controller: ScrollController(),
              children: List.generate(
                  _numIngredient, (index) => getIngredientItem(index + 1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget getIngredientItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        InputField(
          labelText: "Name",
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autoFocus: true,
          textEditingController: _subjectController,
        ),
        InputField(
          labelText: "g",
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autoFocus: true,
          textEditingController: _detailController,
        ),
      ],
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
                "STEP",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// Steps
            GridView.count(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              controller: ScrollController(),
              children:
                  List.generate(_numSteps, (index) => getStepItem(index + 1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget getStepItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Step ' + index.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InputField(
          prefixIcon: Icons.edit,
          labelText: "Subject",
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autoFocus: true,
          textEditingController: _subjectController,
        ),
        InputField(
          maxLine: 5,
          prefixIcon: Icons.menu_book,
          labelText: "Detail",
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autoFocus: true,
          textEditingController: _detailController,
        ),
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
                onPressed: () async {
                  await _editRecipe();
                },
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
}
