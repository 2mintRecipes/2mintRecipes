import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x2mint_recipes/screens/home/homepage.dart';
import 'package:x2mint_recipes/screens/profile/profile.dart';

import '../../utils/app_ui.dart';
import '../profile/seeAllHotCreators.dart';

class HotCreators extends StatefulWidget {
  const HotCreators({
    Key? key,
  }) : super(key: key);

  @override
  State<HotCreators> createState() => _HotCreatorsState();
}

void _pushScreen({required BuildContext context, required Widget screen}) {
  ThemeData themeData = Theme.of(context);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => Theme(data: themeData, child: screen),
    ),
  );
}

class _HotCreatorsState extends State<HotCreators> {
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getBody() {
    return Padding(
        padding: const EdgeInsets.only(
            top: UI.topPadding, bottom: 20, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 20, bottom: 10, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hot Creators",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _pushScreen(
                          context: context,
                          screen: const SeeAllHotCreatorPage(
                              data: [], tittle: "Hot Creator"));
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 25,
                      color: Colors.white.withOpacity(.5),
                    ),
                    label: Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(.5),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  children: List.generate(
                    10,
                    //_allRecipes.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/MIT2021.png'),
                                  radius: 50,
                                  backgroundColor: UI.appColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Taylor Swift",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 20)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
