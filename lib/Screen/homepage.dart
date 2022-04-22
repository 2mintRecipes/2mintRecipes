import 'package:flutter/material.dart';
import 'package:flutter_first/app_ui.dart';
import 'package:flutter_first/components/search_cart.dart';

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
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Find best recipes for cooking",
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      SearchCard(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: Row(
                  children: List.generate(song_type_1.length, (index) {
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
                                width: 2,
                                color: activeMenu1 == index
                                    ? UI.appColor
                                    : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                song_type_1[index],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: activeMenu1 == index
                                        ? UI.appColor
                                        : Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              })),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Row(
                    children: List.generate(10, (index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(songs[index]['img']),
                                    fit: BoxFit.cover),
                                color: UI.appColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            songs[index]['title'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 180,
                            child: Text(
                              songs[index]['description'],
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }))),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10, top: 30),
                child: Text("Trending Album For You",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: UI.appColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Row(
                        children: List.generate(10, (index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                width: 250,
                                height: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(songs[index]['img']),
                                        fit: BoxFit.cover),
                                    color: UI.appColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                songs[index]['title'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      );
                    }))),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, left: 0, bottom: 10),
                child: Text("Artist For You",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: UI.appColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Row(
                        children: List.generate(10, (index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/Reputation.png'),
                                    radius: 50),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Taylor Swift",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
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
    ]));
  }
}
