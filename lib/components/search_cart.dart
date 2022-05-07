// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/app_ui.dart';

class SearchCard extends StatelessWidget {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.white,
                )),
            contentPadding: EdgeInsets.all(10.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(.1),
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            hintText: "Search...",
            prefixIcon: Icon(Icons.search, color: Colors.white, size: 30),
            suffixIcon: Icon(
              Icons.filter_alt_outlined,
              color: Colors.white,
            ),
            hintStyle: TextStyle(
              fontSize: 20.0,
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
