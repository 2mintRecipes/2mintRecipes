import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
}
