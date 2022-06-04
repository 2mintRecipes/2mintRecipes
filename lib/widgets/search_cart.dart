// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x2mint_recipes/screens/home/homepage.dart';
import 'package:x2mint_recipes/screens/root.dart';
import 'package:x2mint_recipes/screens/search_recipe.dart';

import '../utils/app_ui.dart';

class SearchCard extends StatelessWidget {
  final TextEditingController _searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.width * .13,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            if (value.isEmpty) {
              return;
            }
            var screen = SearchRecipe(_searchControl.text);
            ThemeData themeData = Theme.of(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Theme(data: themeData, child: screen),
              ),
            ).then((value) {
              Navigator.of(context).popAndPushNamed(Root.routeName);
            });
          },
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(.1),
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            hintText: "Search...",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintStyle: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          maxLines: 1,
          controller: _searchControl,
        ),
      ),
    );
  }
}
