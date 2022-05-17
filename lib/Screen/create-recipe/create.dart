import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:x2mint_recipes/dto/recipe.dto.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/utils/database.dart';

class Create extends StatefulWidget {
  static const routeName = '/Create';
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  int _numSteps = 0;
  final _formKeyBasicInfo = GlobalKey<FormState>();
  final _formKeyIngredients = GlobalKey<FormState>();
  final List<String> _levelItems = ['1', '2', '3', '4', '5'];
  String? _selectedLevel;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _servingsController = TextEditingController();
  TextEditingController _cookTimeController = TextEditingController();
  TextEditingController _totalTimeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();

  RecipesService recipesService = RecipesService();

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
                    Colors.white.withOpacity(1),
                    BlendMode.darken,
                  ),
                  image: const AssetImage("assets/images/bg.jpg"),
                ),
              ),
            ),
          ),
          getBody(),
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
    super.dispose();
  }

  Widget getBody() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
        child: SingleChildScrollView(
          controller: ScrollController(),
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTitleSection(),
              getBannerSection(),
              getBasicInfoSection(),
              getStepsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTitleSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
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
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 5, right: 5, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(.4),
      ),
      child: Form(
        key: _formKeyBasicInfo,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Basic Info",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.title_sharp),
                  hintText: 'Name',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _servingsController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.people_sharp),
                  hintText: 'Servings',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _cookTimeController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.timer_sharp),
                  hintText: 'Cook time',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _totalTimeController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.timer_sharp),
                  hintText: 'Total time',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              getLevelItem(),
              TextFormField(
                controller: _categoryController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.timer_sharp),
                  hintText: 'Category',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.timer_sharp),
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () async {
                  if (_formKeyBasicInfo.currentState!.validate()) {
                    _formKeyBasicInfo.currentState!.save();
                    _addRecipe();
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: const Text(
                  'Lưu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getStepsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 5, right: 5, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(.4),
      ),
      child: Form(
        key: _formKeyIngredients,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Steps",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget getStepItem(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            "Step #" + index.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              prefixIcon: const Icon(Icons.title_sharp),
              hintText: 'Subject',
              hintStyle: const TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            maxLines: 5,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 20, left: 30, right: 30),
              prefixIcon: const Icon(Icons.description_sharp),
              hintText: 'Detail',
              hintStyle: const TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAddNewRecipeButton() {
    return Column(
      children: [
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () {
            setState(() {
              _numSteps += 1;
            });
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.4),
                  width: 2,
                ),
              ),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: const Text(
            'Add new step',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget getLevelItem() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
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
              prefixIcon: const Icon(Icons.people),
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              // contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,

            hint: const Text(
              'Level',
              // style: TextStyle(fontSize: 14),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
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
                return 'Chọn mức độ';
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
