//import 'dart:html';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first/Screen/account.dart';
import 'package:flutter_first/Screen/bookmark.dart';
import 'package:flutter_first/Screen/welcome.dart';
import '../components/custom_paint.dart';
import '../components/nav_model.dart';
import '../database.dart';
import '../Screen/musicPlayer.dart';
import '../app_ui.dart';
import '../Screen/homepage.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);
  static const routeName = '/root';

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int selectBtn = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem(icon: icon)],
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: selectBtn,
      children: [
        Homepage(),
        Bookmark(),
        Center(
          child: Text(
            "Create",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            "Notify",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Account(),
      ],
    );
  }

  // Widget getFooter() {
  //   List<dynamic> items = [UI.home, UI.search, UI.lib];
  //   return
  //   Container(
  //       height: 60,
  //       decoration: BoxDecoration(color: Colors.black),
  //       child: Padding(
  //         padding: EdgeInsets.only(left: 20, right: 20),
  //         child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: List.generate(items.length, (index) {
  //               return new IconButton(
  //                 splashColor: UI.appColor,
  //                 icon: Image.asset(items[index],
  //                     color: activeTab == index ? UI.appColor : Colors.white),
  //                 iconSize: activeTab == index ? 40 : 30,
  //                 onPressed: () {
  //                   setState(() {
  //                     activeTab = index;
  //                   });
  //                 },
  //               );
  //             })),
  //       ));
  // }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
        padding: EdgeInsets.only(bottom: 7),
        height: 60.0,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 20.0),
            topRight:
                Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 20.0),
          ),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Theme(
                data:
                    Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (int i = 0; i < navBtn.length; i++)
                            GestureDetector(
                              onTap: () => setState(() => selectBtn = i),
                              child: iconBtn(i),
                            ),
                        ],
                      ),
                    )))));
  }

 

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 100.0 : 0.0;
    var width = isActive ? 100.0 : 0.0;
    return SizedBox(
      width: 60.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                      painter: ButtonNotch(),
                    )
                  : const SizedBox(),
            ),
          ),
          Align(
            alignment: isActive ? Alignment.bottomCenter : Alignment.center,
            child: Image.asset(
              navBtn[i].imagePath,
              color: isActive ? Colors.black : Colors.white,
              scale: isActive ? 0.8 : 0.7,
            ),
          ),
        ],
      ),
    );
  }

  // Widget getAppBar() {
  //   return AppBar(
  //     backgroundColor: Colors.black,
  //     elevation: 0,
  //     title: Padding(
  //       padding: const EdgeInsets.only(left: 10, right: 10),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             "Explore",
  //             style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //           Icon(Icons.list)
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
