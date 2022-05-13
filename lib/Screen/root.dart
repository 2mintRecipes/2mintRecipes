import 'package:flutter/material.dart';
import 'package:x2mint_recipes/Screen/create-recipe/create.dart';
import 'package:x2mint_recipes/Screen/homepage.dart';
import 'package:x2mint_recipes/Screen/notification/notification.dart';
import 'package:x2mint_recipes/Screen/profile/profile.dart';
import 'package:x2mint_recipes/Screen/bookmark.dart';
import 'package:x2mint_recipes/components/nav_model.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';

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
            topRight:
                Radius.circular(currentIndex == navBtn.length - 1 ? 0.0 : 20.0),
            bottomLeft: Radius.circular(currentIndex == 0 ? 0.0 : 20.0),
            bottomRight:
                Radius.circular(currentIndex == navBtn.length - 1 ? 0.0 : 20.0),
          ),
        ),
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
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: currentIndex,
      children: const [
        HomePage(),
        Bookmark(),
        Create(),
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
                ? Image.asset(
                    navBtn[i].imagePath,
                    color: Colors.orangeAccent,
                    scale: 0.7,
                  )
                : Image.asset(
                    navBtn[i].imagePath,
                    color: Colors.white,
                    scale: 0.7,
                  ),
          ),
        ],
      ),
    );
  }
}
