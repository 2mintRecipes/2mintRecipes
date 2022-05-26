import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x2mint_recipes/screens/home/homepage.dart';
import 'package:x2mint_recipes/screens/profile/profile.dart';

import '../../utils/app_ui.dart';

class SeeAllHotCreatorPage extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final String tittle;
  const SeeAllHotCreatorPage({
    required this.data,
    required this.tittle,
    Key? key,
  }) : super(key: key);

  @override
  State<SeeAllHotCreatorPage> createState() => _SeeAllHotCreatorPageState();
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

class _SeeAllHotCreatorPageState extends State<SeeAllHotCreatorPage> {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitleSection(),
          // getBannerSection(),
          // getBasicInfoSection(),
          // getIngredientSection(),
          // getStepsSection(),
          // getEditWidget(),
        ],
      ),
    );
  }

  Widget getTitleSection() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  icon: const SizedBox(
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  )),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Text(
                  widget.tittle,
                  maxLines: 5,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              )
            ],
          ),
        ));
  }

  Widget getListItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: ScrollController(),
      child: Column(
        children: List.generate(
          widget.data.length,
          (index) {
            return GestureDetector(
              onTap: () {
                _pushScreen(context: context, screen: Profile()); //
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: MediaQuery.of(context).size.width * .5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.white.withOpacity(.4),
                      ),
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(widget.data[index]['image']),
                          fit: BoxFit.cover),
                      color: Colors.white.withOpacity(.4),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.data[index]['name'],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
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
                        backgroundColor: Colors.white.withOpacity(.5),
                        child: const Text(
                          'MT',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      Text(
                        '  By ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(.7),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
