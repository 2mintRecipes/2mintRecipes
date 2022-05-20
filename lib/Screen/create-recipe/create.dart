import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/utils/database.dart';

import '../../components/input.dart';
import '../../utils/app_ui.dart';

class Create extends StatefulWidget {
  static const routeName = '/Create';
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  int _numSteps = 0;
  int _numIngredient = 0;
  final _formKeyBasicInfo = GlobalKey<FormState>();
  final _formKeyIngredients = GlobalKey<FormState>();
  final List<String> _levelItems = ['1', '2', '3', '4', '5'];
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
          top: UI.topPadding, left: 30, right: 30, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitleSection(),
          getBannerSection(),
          getBasicInfoSection(),
          //getIngredientSection(),
          getStepsSection(),
        ],
      ),
    );
  }

  Widget getTitleSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Create recipe",
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

  Widget getBannerSection() {
    return GestureDetector(
      onTap: () {
        print("pressed");
      },
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
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image(
                image: AssetImage(songs[0]['img']),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBasicInfoSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
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
              padding: EdgeInsets.all(20),
              child: Text(
                "INFORMATION",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
              labelText: "Recipe Name",
              errorText: recipeNameError,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _nameController,
            ),
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
              labelText: "Serves",
              errorText: recipeNameError,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _nameController,
            ),
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
              labelText: "Total Time",
              errorText: totalTimeError,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _totalTimeController,
            ),
            // const SizedBox(height: 20),
            getLevelItem(),
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
              child: SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {},

                  ///
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
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
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
        key: _formKeyIngredients,
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
    return Container(
      child: Column(
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
      ),
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
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
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
                Icons.people,
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
            },
            onSaved: (value) {
              _selectedLevel = value.toString();
            },
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

  _addRecipe() async {
    RecipeDto data = RecipeDto(
      name: _nameController.text,
      description: _descriptionController.text,
      servings: double.tryParse(_servingsController.text),
      cookTime: double.tryParse(_cookTimeController.text),
      totalTime: double.tryParse(_totalTimeController.text),
      category: _categoryController.text,
      level: int.tryParse(_selectedLevel ?? "0"),
      image:
          "https://i.pinimg.com/564x/f4/c0/24/f4c024614b8806c25da375453924b577.jpg",
    );
    print(data.toJson());

    await recipesService.add(data).then((value) {
      print(value);
      _clearText();
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
