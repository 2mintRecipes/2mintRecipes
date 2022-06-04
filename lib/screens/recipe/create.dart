import 'dart:io';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x2mint_recipes/screens/recipe/detailRecipe.dart';
import 'package:x2mint_recipes/screens/search_recipe.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/services/user.service.dart';
import 'package:x2mint_recipes/utils/screen_utils.dart';
import 'package:x2mint_recipes/widgets/input.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/services/cloudinary.service.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/utils/database.dart';

class CreateRecipe extends StatefulWidget {
  static const routeName = '/CreateRecipe';
  final String id;
  const CreateRecipe(this.id, {Key? key}) : super(key: key);

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService = CloudinaryService();
  final UserService _userService = UserService();
  final _formKeyBasicInfo = GlobalKey<FormState>();
  final _formKeyIngredients = GlobalKey<FormState>();
  final _formKeySteps = GlobalKey<FormState>();
  final List<String> _levelItems = ['1', '2', '3', '4', '5'];
  final SecureStorage _secureStorage = SecureStorage();
  // late bool showEditButton;
  File? _image;
  String? _imagePath, _imageUrl, _selectedLevel, _selectedCategory, _recipeId;
  String? recipeNameError,
      servingError,
      cookTimeError,
      totalTimeError,
      descriptionError,
      categoryError,
      subjectError,
      detailError;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _servingController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final TextEditingController _totalTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<TextEditingController> _ingredientNameControllers = [];
  final List<TextEditingController> _ingredientAmountControllers = [];
  final List<TextEditingController> _stepTitleControllers = [];
  final List<TextEditingController> _stepDetailControllers = [];
  dynamic recipeImage = const NetworkImage(defaultRecipeImage);
  RecipesService recipesService = RecipesService();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    if (widget.id.isNotEmpty) {
      _recipeId = widget.id;
      await recipesService.getOne(widget.id).then((recipe) {
        _nameController.text = recipe['name'];
        _servingController.text = recipe['serving'].toString().split('.')[0];
        _cookTimeController.text = recipe['cookTime'].toString().split('.')[0];
        _totalTimeController.text =
            recipe['totalTime'].toString().split('.')[0];
        _descriptionController.text = recipe['description'].toString();
        _imageUrl = recipe['image'];
        setState(() {
          _selectedLevel = recipe['level'].toString().split('.')[0];
          _selectedCategory = recipe['category'].toString();
        });

        if (recipe['ingredients'] != null) {
          for (var ingredient in recipe['ingredients']) {
            _ingredientNameControllers.add(TextEditingController(
              text: ingredient['name'],
            ));
            _ingredientAmountControllers.add(TextEditingController(
              text: ingredient['amount'],
            ));
          }
        }
        if (recipe['steps'] != null) {
          for (var step in recipe['steps']) {
            _stepTitleControllers.add(TextEditingController(
              text: step['title'],
            ));
            _stepDetailControllers.add(TextEditingController(
              text: step['detail'],
            ));
          }
        }

        getBanner();
      });
    }
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
          getCreateRecipeWidget(),
        ],
      ),
    );
  }

  Widget getTitleSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.id != null ? "Edit recipe" : "Create recipe",
            style: const TextStyle(
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
                  child: InkWell(
                    // onTap: () => setState(() => showEditButton = true),
                    child: Image(
                      image:
                          recipeImage ?? const NetworkImage(defaultRecipeImage),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      isAntiAlias: true,
                    ),
                  ),
                ),
                // if (showEditButton)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await _getFromGallery();
                      },
                      icon: const Icon(Icons.edit),
                      color: Colors.grey,
                      iconSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _getFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _imagePath = image.path;
      });
      getBanner();
    }
  }

  getBanner() {
    try {
      if (_image != null) {
        setState(() {
          recipeImage = FileImage(_image!);
        });
        return;
      }
      if (_imageUrl != null) {
        setState(() {
          recipeImage = NetworkImage(_imageUrl!);
        });
        return;
      }
    } catch (e) {
      assert(false, e.toString());
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
              onChanged: (value) {
                if (recipeNameError != null) {
                  setState(() {
                    recipeNameError = null;
                  });
                }
              },
              labelText: "Recipe name",
              errorText: recipeNameError,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _nameController,
            ),
            const SizedBox(height: 15),

            /// Servings
            InputField(
              prefixIcon: Icons.supervisor_account,
              onChanged: (value) {
                if (recipeNameError != null) {
                  setState(() {
                    recipeNameError = null;
                  });
                }
              },
              labelText: "Servings",
              errorText: recipeNameError,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _servingController,
            ),
            const SizedBox(height: 15),

            /// Cook time
            InputField(
              prefixIcon: Icons.timer,
              onChanged: (value) {
                if (cookTimeError != null) {
                  setState(() {
                    cookTimeError = null;
                  });
                }
              },
              labelText: "Cook time",
              errorText: cookTimeError,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _cookTimeController,
            ),
            const SizedBox(height: 15),

            /// Total time
            InputField(
              prefixIcon: Icons.timer,
              onChanged: (value) {
                if (totalTimeError != null) {
                  setState(() {
                    totalTimeError = null;
                  });
                }
              },
              labelText: "Total time",
              errorText: totalTimeError,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _totalTimeController,
            ),
            const SizedBox(height: 15),

            /// Description
            InputField(
              prefixIcon: Icons.description,
              onChanged: (value) {
                if (descriptionError != null) {
                  setState(() {
                    descriptionError = null;
                  });
                }
              },
              labelText: "Description",
              errorText: descriptionError,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _descriptionController,
            ),
            const SizedBox(height: 15),

            /// Level
            getLevelItem(),
            const SizedBox(height: 10),

            /// Category
            getCategoryItem(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget getIngredientSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
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

            /// Ingredient
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              child: Column(
                children: List.generate(_ingredientNameControllers.length,
                    (index) => getIngredientItem(index + 1)),
              ),
            ),

            /// Add button
            getAddNewIngredientButton(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget getIngredientItem(int index) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "Ingredient $index",
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
            onChanged: (value) {
              if (subjectError != null) {
                setState(() {
                  subjectError = null;
                });
              }
            },
            labelText: "Name",
            errorText: subjectError,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autoFocus: true,
            textEditingController: _ingredientNameControllers[index - 1],
          ),
          InputField(
            prefixIcon: Icons.line_weight,
            onChanged: (value) {
              if (detailError != null) {
                setState(() {
                  detailError = null;
                });
              }
            },
            labelText: "Amount",
            errorText: detailError,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autoFocus: true,
            textEditingController: _ingredientAmountControllers[index - 1],
          ),
        ],
      ),
    );
  }

  Widget getStepsSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
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
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              child: Column(
                children: List.generate(_stepTitleControllers.length,
                    (index) => getStepItem(index + 1)),
              ),
            ),

            /// Add button
            getAddNewRecipeButton(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget getStepItem(int index) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'Step $index',
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
            onChanged: (value) {
              if (subjectError != null) {
                setState(() {
                  subjectError = null;
                });
              }
            },
            labelText: "Subject",
            errorText: subjectError,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autoFocus: true,
            textEditingController: _stepTitleControllers[index - 1],
          ),
          InputField(
            prefixIcon: Icons.menu_book,
            onChanged: (value) {
              if (detailError != null) {
                setState(() {
                  detailError = null;
                });
              }
            },
            labelText: "Detail",
            errorText: detailError,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autoFocus: true,
            textEditingController: _stepDetailControllers[index - 1],
          ),
        ],
      ),
    );
  }

  Widget getAddNewRecipeButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      child: SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          onPressed: onPressedAddNewStep,
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: UI.appColor,
            shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(Icons.add),
          label: const Text(
            "Add new step",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void onPressedAddNewStep() {
    setState(() {
      _stepDetailControllers.add(TextEditingController());
      _stepTitleControllers.add(TextEditingController());
    });
  }

  Widget getAddNewIngredientButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      child: SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          onPressed: onPressedAddNewIngredient,
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: UI.appColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(Icons.add),
          label: const Text(
            "Add new ingredients",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void onPressedAddNewIngredient() {
    setState(() {
      _ingredientNameControllers.add(TextEditingController());
      _ingredientAmountControllers.add(TextEditingController());
    });
  }

  Widget getCategoryItem() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 5, top: 5),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          DropdownButtonFormField2(
            value: _selectedCategory,
            onChanged: (value) {
              setState(() {
                _selectedCategory = value as String;
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.restaurant_menu,
                color: Colors.white.withOpacity(.5),
                size: 30,
              ),
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              // contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            hint: Text('Category',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white.withOpacity(.5),
                )
                // style: TextStyle(fontSize: 14),
                ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.white.withOpacity(.5),
              size: 30,
            ),
            // iconSize: 30,
            // buttonHeight: 60,
            // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withOpacity(.95),
            ),
            items: recipeCategories
                .map(
                  (item) => DropdownMenuItem<String>(
                      value: item,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          item,
                          // style: const TextStyle(
                          //   fontSize: 14,
                          // ),
                          // textAlign: TextAlign.center,
                        ),
                      )),
                )
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Choose category';
              }
              return null;
            },
            onSaved: (value) {
              _selectedCategory = value.toString();
            },
          ),
        ],
      ),
    );
  }

  Widget getLevelItem() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 5, top: 5),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          DropdownButtonFormField2(
            value: _selectedLevel,
            onChanged: (value) {
              setState(() {
                _selectedLevel = value as String;
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.star,
                color: Colors.white.withOpacity(.5),
                size: 30,
              ),
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              // contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            hint: Text('Level',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white.withOpacity(.5),
                )
                // style: TextStyle(fontSize: 14),
                ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.white.withOpacity(.5),
              size: 30,
            ),
            // iconSize: 30,
            // buttonHeight: 60,
            // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withOpacity(.95),
            ),
            items: _levelItems
                .map(
                  (item) => DropdownMenuItem<String>(
                      value: item,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          item,
                          // style: const TextStyle(
                          //   fontSize: 14,
                          // ),
                          // textAlign: TextAlign.center,
                        ),
                      )),
                )
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Choose level';
              }
              return null;
            },
            onSaved: (value) {
              _selectedLevel = value.toString();
            },
          ),
        ],
      ),
    );
  }

  Widget getCreateRecipeWidget() {
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
                  await _addRecipe();
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: UI.appColor,
                  shape: RoundedRectangleBorder(
                    //to set border radius to button
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.restaurant_menu),
                label: Text(
                  widget.id.isEmpty ? "Create" : "Update",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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

  List<Map<String, dynamic>> getIngredientsList() {
    List<Map<String, dynamic>> ingredientsList = [];
    for (var i = 0; i < _ingredientNameControllers.length; i++) {
      ingredientsList.add({
        'name': _ingredientNameControllers[i].text,
        'amount': _ingredientAmountControllers[i].text,
      });
    }
    return ingredientsList;
  }

  List<Map<String, dynamic>> getStepsList() {
    List<Map<String, dynamic>> getStepsList = [];
    for (var i = 0; i < _stepTitleControllers.length; i++) {
      getStepsList.add({
        'order': i,
        'title': _stepTitleControllers[i].text,
        'detail': _stepDetailControllers[i].text,
      });
    }
    return getStepsList;
  }

  Future _addRecipe() async {
    if (_imagePath != null) {
      _imageUrl = await _cloudinaryService.uploadImage(_imagePath!);
      print(_imageUrl);
    } else {
      _imageUrl = defaultRecipeImage;
    }

    var uid = await _secureStorage.readSecureData('uid');

    await _userService.getUserDocRefByUid(uid).then((value) async {
      print(value);
      RecipeDto data = RecipeDto(
        name: _nameController.text,
        description: _descriptionController.text,
        serving: double.tryParse(_servingController.text) ?? 0,
        cookTime: double.tryParse(_cookTimeController.text) ?? 0,
        totalTime: double.tryParse(_totalTimeController.text) ?? 0,
        category: _selectedCategory,
        level: int.tryParse(_selectedLevel ?? "1"),
        image: _imageUrl,
        creator: value,
        like: 0,
        ingredients: getIngredientsList(),
        steps: getStepsList(),
      );

      if (_recipeId == null || _recipeId!.isEmpty) {
        await recipesService.add(data).then((value) {
          print(value);

          // ScreenUtils.pushScreen(
          //     context: context, screen: RecipeDetail(value.id));
          var screen = RecipeDetail(value.id);
          ThemeData themeData = Theme.of(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Theme(data: themeData, child: screen),
            ),
          ).then((value) async {
            Navigator.pushNamed(context, SearchRecipe.routeName);
          });
        });
      } else {
        print(_recipeId);
        await recipesService.update(_recipeId!, data);
        // ScreenUtils.pushScreen(
        //     context: context, screen: RecipeDetail(_recipeId!));
        var screen = RecipeDetail(_recipeId!);
        ThemeData themeData = Theme.of(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Theme(data: themeData, child: screen),
          ),
        ).then((value) async {
          Navigator.pushNamed(context, SearchRecipe.routeName);
        });
      }
    });
  }
}
