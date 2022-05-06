import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first/app_ui.dart';
import 'package:flutter_first/components/search_cart.dart';

import '../database.dart';

class Bookmark extends StatefulWidget {
  static const routeName = '/bookmark';
  const Bookmark({Key? key}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  int activeMenu = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(1), BlendMode.darken),
                  image: const AssetImage("images/bg.jpg"))),
        )),
        getBody(),
      ]),
    );
  }

  Widget getBody() {
    return ClipRRect(
        // borderRadius: BorderRadius.circular(5),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  /// Title
                  getTitle(),

                  /// Search card
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 20, right: 30),
                      child: SearchCard()),

                  /// Get Bookmark Type
                  getBookmarkType(),

                  /// Bookmark Items
                  getListBookmarkItems(),
                ]))));
  }

  Widget getTitle() {
    return Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 20, bottom: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Bookmark",
                style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                    fontSize: 27,
                    fontWeight: FontWeight.w600)),
          ],
        ));
  }

  Widget getBookmarkType() {
    return SingleChildScrollView(
      //lists with kind tags
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
      child: Row(
          children: List.generate(song_type_1.length, (index) {
        ////////// list tags
        return Padding(
          padding: const EdgeInsets.only(right: 25),
          child: GestureDetector(
            onTap: () {
              setState(() {
                activeMenu = index;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(.1),
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: activeMenu == index
                        ? UI.appColor
                        : Colors.black.withOpacity(.1),
                  ),
                  padding: const EdgeInsets.only(
                      top: 7, bottom: 7, left: 15, right: 15),
                  child: Text(
                    song_type_1[index],
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        );
      })),
    );
  }

  Widget getListBookmarkItems() {
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        crossAxisSpacing: 20,
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        controller: ScrollController(),
        children: List.generate(10, (index) {
          return GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Colors.white.withOpacity(.4)),
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(songs[index]['img']),
                          fit: BoxFit.cover),
                      color: Colors.white.withOpacity(.4)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  songs[index]['title'],
                  style: TextStyle(
                      color: UI.appColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    songs[index]['description'],
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(.8),
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
