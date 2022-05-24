import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x2mint_recipes/widgets/button.dart';
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

  @override
  void initState() {
    super.initState();
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
    return Padding(
      padding: const EdgeInsets.only(
          top: UI.topPadding, bottom: 20, left: 30, right: 30),
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Text(
                  _recipe['name'],
                  maxLines: 5,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              )
            ],
          ),
        ));
  }

  Widget getBannerSection() {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
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
                    image: (_recipe['image'] == null)
                        ? const NetworkImage(
                            "https://unsplash.com/photos/Yn0l7uwBrpw")
                        : NetworkImage(_recipe['image']),
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
            const SizedBox(height: 20),
            TextView(
              text: _recipe['description'].toString(),
              icon: Icons.description,
              fontSize: 15,
              maxLine: 5,
            ),

            const SizedBox(height: 10),
            TextView(
              text: 'Serving: ' + _recipe['serving'].toString(),
              icon: Icons.supervisor_account,
              fontSize: 15,
            ),
            const SizedBox(height: 10),
            TextView(
              text: 'Cook Time: ' + _recipe['cookTime'].toString(),
              icon: Icons.timer,
              fontSize: 15,
            ),
            const SizedBox(height: 10),
            TextView(
              text: 'Total Time: ' + _recipe['totalTime'].toString(),
              icon: Icons.timer,
              fontSize: 15,
            ),
            const SizedBox(height: 10),

            /// Category
            InputField(
              prefixIcon: Icons.restaurant_menu,
              labelText: "Category",
              textEditingController: _categoryController,
            ),
            const SizedBox(height: 10),

            TextView(
              text: _recipe['level'].toString(),
              icon: Icons.star,
              fontSize: 15,
            ),
            const SizedBox(height: 10),
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
}
