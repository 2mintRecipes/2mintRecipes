//import 'dart:html';

import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_first/Screen/notification/notification.dart';
import 'package:flutter_first/Screen/profile/profile.dart';
import 'package:flutter_first/Screen/bookmark.dart';
import 'package:flutter_first/Screen/welcome.dart';
import '../components/nav_model.dart';
import '../database.dart';
import '../Screen/musicPlayer.dart';
import '../utils/app_ui.dart';
import '../Screen/homepage.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);
  static const routeName = '/root';

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // double navHeight = size.width * 0.15;

    return Scaffold(
        body: getBody(),
        bottomNavigationBar: AnimatedContainer(
          // height: navHeight < 55 ? navHeight : 55,
          height: 55,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: UI.appColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(currentIndex == 0 ? 0.0 : 20.0),
                topRight: Radius.circular(
                    currentIndex == navBtn.length - 1 ? 0.0 : 20.0),
                bottomLeft: Radius.circular(currentIndex == 0 ? 0.0 : 20.0),
                bottomRight: Radius.circular(
                    currentIndex == navBtn.length - 1 ? 0.0 : 20.0),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < navBtn.length; i++)
                GestureDetector(
                  onTap: () => setState(() => currentIndex = i),
                  child: iconBtn(i),
                ),
            ],
          ),
        ));
  }

  Widget getBody() {
    return IndexedStack(
      index: currentIndex,
      children: const [
        Homepage(),
        Bookmark(),
        Center(
          child: Text(
            "Create",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        MyNotification(),
        Profile(),
      ],
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = currentIndex == i ? true : false;
    var height = isActive ? 100.0 : 0.0;
    var width = isActive ? 100.0 : 0.0;
    return SizedBox(
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: isActive
                  ? Text(
                      navBtn[i].name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : Image.asset(
                      navBtn[i].imagePath,
                      color: Colors.white,
                      scale: 0.7,
                    )),
        ],
      ),
    );
  }
}
