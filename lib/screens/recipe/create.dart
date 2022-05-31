import 'dart:io';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x2mint_recipes/screens/recipe/detailRecipe.dart';
import 'package:x2mint_recipes/utils/screen_utils.dart';
import 'package:x2mint_recipes/widgets/button.dart';
import 'package:x2mint_recipes/widgets/input.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/services/cloudinary.service.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/utils/database.dart';

class CreateRecipe extends StatefulWidget {
  static const routeName = '/CreateRecipe';
  const CreateRecipe({Key? key}) : super(key: key);

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  int _numSteps = 0;
  int _numIngredient = 0;
  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService = CloudinaryService();
  final _formKeyBasicInfo = GlobalKey<FormState>();
  final _formKeyIngredients = GlobalKey<FormState>();
  final _formKeySteps = GlobalKey<FormState>();
  final List<String> _levelItems = ['1', '2', '3', '4', '5'];
  // late bool showEditButton;
  File? _image;
  String? _imagePath;
  String? _imageUrl;
  String? _selectedLevel,
      recipeName,
      serving,
      cookTime,
      totalTime,
      description,
      category,
      subject,
      detail;
  String? recipeNameError,
      servingError,
      cookTimeError,
      totalTimeError,
      descriptionError,
      categoryError,
      subjectError,
      detailError;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _servingsController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final TextEditingController _totalTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  RecipesService recipesService = RecipesService();

  @override
  void initState() {
    super.initState();
    // showEditButton = false;

    recipeName = "";
    serving = "";
    cookTime = "";
    totalTime = "";
    description = "";
    category = "";

    recipeNameError = null;
    servingError = null;
    cookTimeError = null;
    totalTimeError = null;
    descriptionError = null;
    categoryError = null;
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

  @override
  void dispose() {
    _nameController.dispose();
    _servingsController.dispose();
    _cookTimeController.dispose();
    _totalTimeController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _subjectController.dispose();
    super.dispose();
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
        children: const [
          Text(
            "Create recipe",
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
                  child: InkWell(
                    // onTap: () => setState(() => showEditButton = true),
                    child: Image(
                      image: getBanner(), // AssetImage(songs[0]['img']),
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
    }
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
              onChanged: (value) {
                if (recipeNameError != null) {
                  setState(() {
                    recipeNameError = null;
                  });
                }
                setState(() {
                  recipeName = value;
                });
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
                setState(() {
                  recipeName = value;
                });
              },
              labelText: "Servings",
              errorText: recipeNameError,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _servingsController,
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
                setState(() {
                  cookTime = value;
                });
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
                setState(() {
                  totalTime = value;
                });
              },
              labelText: "Total time",
              errorText: totalTimeError,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _totalTimeController,
            ),
            const SizedBox(height: 15),

            /// Category
            InputField(
              prefixIcon: Icons.restaurant_menu,
              onChanged: (value) {
                if (categoryError != null) {
                  setState(() {
                    categoryError = null;
                  });
                }
                setState(() {
                  category = value;
                });
              },
              labelText: "Category",
              errorText: categoryError,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _categoryController,
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
                setState(() {
                  description = value;
                });
              },
              labelText: "Description",
              errorText: descriptionError,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _descriptionController,
            ),

            /// Level
            getLevelItem(),
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

            /// Steps
            GridView.count(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              controller: ScrollController(),
              children: List.generate(
                  _numIngredient, (index) => getIngredientItem(index + 1)),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          InputField(
            onChanged: (value) {
              if (subjectError != null) {
                setState(() {
                  subjectError = null;
                });
              }
              setState(() {
                subject = value;
              });
            },
            labelText: "Name",
            errorText: subjectError,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autoFocus: true,
            textEditingController: _subjectController,
          ),
          InputField(
            onChanged: (value) {
              if (detailError != null) {
                setState(() {
                  detailError = null;
                });
              }
              setState(() {
                detail = value;
              });
            },
            labelText: "g",
            errorText: detailError,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autoFocus: true,
            textEditingController: _detailController,
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
            GridView.count(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              controller: ScrollController(),
              children:
                  List.generate(_numSteps, (index) => getStepItem(index + 1)),
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
          onChanged: (value) {
            if (subjectError != null) {
              setState(() {
                subjectError = null;
              });
            }
            setState(() {
              subject = value;
            });
          },
          labelText: "Subject",
          errorText: subjectError,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autoFocus: true,
          textEditingController: _subjectController,
        ),
        InputField(
          maxLine: 5,
          prefixIcon: Icons.menu_book,
          onChanged: (value) {
            if (detailError != null) {
              setState(() {
                detailError = null;
              });
            }
            setState(() {
              detail = value;
            });
          },
          labelText: "Detail",
          errorText: detailError,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autoFocus: true,
          textEditingController: _detailController,
        ),
      ],
    );
  }

  Widget getAddNewRecipeButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      child: SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _numSteps += 1;
            });
          },

          ///
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

  Widget getAddNewIngredientButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      child: SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _numIngredient += 1;
            });
          },

          ///
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
            "Add new ingredients",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
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
                icon: const Icon(Icons.ramen_dining),
                label: const Text(
                  "Create",
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

  void _clearText() {
    _nameController.clear();
    _descriptionController.clear();
    _categoryController.clear();
    _cookTimeController.clear();
    _totalTimeController.clear();
    _servingsController.clear();
    _selectedLevel = null;
  }

  Future _addRecipe() async {
    if (_imagePath != null) {
      _imageUrl = await _cloudinaryService.uploadImage(_imagePath!);
      print(_imageUrl);
    }

    RecipeDto data = RecipeDto(
      name: _nameController.text,
      description: _descriptionController.text,
      servings: double.tryParse(_servingsController.text),
      cookTime: double.tryParse(_cookTimeController.text),
      totalTime: double.tryParse(_totalTimeController.text),
      category: _categoryController.text,
      level: int.tryParse(_selectedLevel ?? "0"),
      image: _imageUrl,
    );
    //print(data.toJson());

    await recipesService.add(data).then((value) {
      _clearText();

      ScreenUtils.pushScreen(context: context, screen: RecipeDetail(value.id));
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
