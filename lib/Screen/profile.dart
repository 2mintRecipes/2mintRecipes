import 'package:flutter/material.dart';
import 'package:flutter_first/app_ui.dart';
import 'package:flutter_first/components/search_cart.dart';
import 'package:getwidget/getwidget.dart';

import '../database.dart';

class Profile extends StatefulWidget {
  static const routeName = '/Profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int activeMenu1 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Text(
          "My Profile",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const GFAvatar(
              backgroundImage: AssetImage("assets/images/nong-nao-doll.jpg"),
              shape: GFAvatarShape.circle,
              size: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "@TienNHM",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Click Me'),
                  ),
                ],
              ),
            )
          ],
        ),
      ])),
    );
  }
}
