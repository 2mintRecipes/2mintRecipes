import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first/app_ui.dart';
import 'package:flutter_first/components/search_cart.dart';

import '../components/button.dart';
import '../database.dart';

class Homepage extends StatefulWidget {
  static const routeName = '/homepage';
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int activeMenu1 = 0;
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
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(1), BlendMode.darken),
                  image: AssetImage("images/bg.jpg"))),
        )),
        getBody()
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
                  const Padding(
                      padding: EdgeInsets.only(left: 30, top: 20),
                      child: Text(
                        "Find best recipes for cooking",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 20, right: 30),
                      child: SearchCard()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 20, bottom: 10, top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Trending now 💥",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 27,
                                      fontWeight: FontWeight.w600)),
                              TextButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward,
                                    size: 25,
                                    color: Colors.white.withOpacity(.5)),
                                label: Text(
                                  'See all',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(.5),
                                  ),
                                ),
                              )
                            ],
                          )),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                                children: List.generate(10, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 250,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.white
                                                    .withOpacity(.4)),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    songs[index]['img']),
                                                fit: BoxFit.cover),
                                            color:
                                                Colors.white.withOpacity(.4)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        songs[index]['title'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: UI.appColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.white.withOpacity(.5),
                                            child: Text(
                                              'MT',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            '  By ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white
                                                    .withOpacity(.7)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }))),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 20, bottom: 10, top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Popular Category",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 27,
                                      fontWeight: FontWeight.w600)),
                            ],
                          )),
                      SingleChildScrollView(
                        //lists with kind tags
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, top: 20),
                          child: Row(
                              children:
                                  List.generate(song_type_1.length, (index) {
                            ////////// list tags
                            return Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    activeMenu1 = index;
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: activeMenu1 == index
                                              ? UI.appColor
                                              : Colors.black.withOpacity(.1),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 5),
                                          child: Text(
                                            song_type_1[index],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          })),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        // list horizential
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                                children: List.generate(10, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 250,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.white
                                                    .withOpacity(.4)),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    songs[index]['img']),
                                                fit: BoxFit.cover),
                                            color:
                                                Colors.white.withOpacity(.4)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        songs[index]['title'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: UI.appColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          songs[index]['description'],
                                          maxLines: 3,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Colors.white.withOpacity(.8),
                                              fontWeight: FontWeight.w200),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 20, bottom: 10, top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Recent Recipes",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(.8),
                                          fontSize: 27,
                                          fontWeight: FontWeight.w600)),
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward,
                                        size: 25,
                                        color: Colors.white.withOpacity(.5)),
                                    label: Text(
                                      'See all',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white.withOpacity(.5),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                    children: List.generate(10, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 250,
                                            height: 150,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.white
                                                        .withOpacity(.4)),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        songs[index]['img']),
                                                    fit: BoxFit.cover),
                                                color: Colors.white
                                                    .withOpacity(.4)),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            songs[index]['title'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: UI.appColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              songs[index]['description'],
                                              maxLines: 3,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white
                                                      .withOpacity(.8),
                                                  fontWeight: FontWeight.w200),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.white
                                                    .withOpacity(.5),
                                                child: Text(
                                                  'MT',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Text(
                                                '  By ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white
                                                        .withOpacity(.7)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }))),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 20, bottom: 10, top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Hot Creators",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(.8),
                                          fontSize: 27,
                                          fontWeight: FontWeight.w600)),
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward,
                                        size: 25,
                                        color: Colors.white.withOpacity(.5)),
                                    label: Text(
                                      'See all',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white.withOpacity(.5),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                    children: List.generate(10, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: CircleAvatar(
                                                backgroundImage: const AssetImage(
                                                    'assets/images/nong-nao-doll.jpg'),
                                                radius: 50,
                                                backgroundColor: UI.appColor),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Taylor Swift",
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(.7),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }))),
                          ),
                        ],
                      )
                    ],
                  ),
                ]))));
  }
}
