import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x2mint_recipes/components/button.dart';
import 'package:x2mint_recipes/components/input.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/services/cloudinary.service.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/utils/database.dart';

class RecipeDetail extends StatefulWidget {
  static const routeName = '/RecipeDetail';
  const RecipeDetail({Key? key}) : super(key: key);

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _numSteps = 0;
  int _numIngredient = 0;
  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService = CloudinaryService();
  final _formKeyBasicInfo = GlobalKey<FormState>();
  final _formKeyIngredients = GlobalKey<FormState>();
  final _formKeySteps = GlobalKey<FormState>();

  // late bool showEditButton;
  File? _image;
  String? _imagePath;
  String? _imageUrl;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _servingsController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final TextEditingController _totalTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();

  RecipesService recipesService = RecipesService();
  RecipeDto? recipe;

  @override
  void initState() async {
    super.initState();
    await _getRecipeDetail();
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
    return Padding(
      padding: const EdgeInsets.only(
        top: UI.topPadding,
        // left: 30,
        // right: 30,
        bottom: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitleSection(),
          getBannerSection(),
          getBasicInfoSection(),
          getIngredientSection(),
          getStepsSection(),
          getEditWidget(),
        ],
      ),
    );
  }

  Widget getTitleSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Recipe Detail",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget getBannerSection() {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
            // elevation: 3.0,
            borderOnForeground: true,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white.withOpacity(0.4),
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image(
                    image: getBanner(),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    isAntiAlias: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getBanner() {
    try {
      return FileImage(_image!);
    } catch (e) {
      return const NetworkImage(
          'https://res.cloudinary.com/x2mint/image/upload/v1652892076/2mintRecipes/fxpssnnxl0urdlynqhkz.png');
      // const AssetImage("assets/images/avatar.jpg");
    }
  }

  Widget getBasicInfoSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(.4),
      ),
      child: Form(
        key: _formKeyBasicInfo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                "INFORMATION",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// Name
            InputField(
              prefixIcon: Icons.restaurant,
              labelText: "Recipe name",
              textEditingController: _nameController,
            ),
            const SizedBox(height: 15),

            /// Servings
            InputField(
              prefixIcon: Icons.supervisor_account,
              labelText: "Servings",
              textEditingController: _servingsController,
            ),
            const SizedBox(height: 15),

            /// Cook time
            InputField(
              prefixIcon: Icons.timer,
              labelText: "Cook time",
              textEditingController: _cookTimeController,
            ),
            const SizedBox(height: 15),

            /// Total time
            InputField(
              prefixIcon: Icons.timer,
              labelText: "Total time",
              textEditingController: _totalTimeController,
            ),
            const SizedBox(height: 15),

            /// Category
            InputField(
              prefixIcon: Icons.restaurant_menu,
              labelText: "Category",
              textEditingController: _categoryController,
            ),
            const SizedBox(height: 15),

            /// Description
            InputField(
              prefixIcon: Icons.description,
              labelText: "Description",
              textEditingController: _descriptionController,
            ),

            /// Level
            InputField(
              prefixIcon: Icons.star,
              labelText: "Level",
              textEditingController: _levelController,
            ),
            const SizedBox(height: 15),
          ],
        ),
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

  Future _getRecipeDetail() async {
    try {
      recipe = await recipesService.getOne();
      print(recipe?.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future _editRecipe() async {}
}
