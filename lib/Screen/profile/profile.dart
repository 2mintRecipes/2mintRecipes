import 'package:flutter/material.dart';
import 'package:flutter_first/app_ui.dart';
import 'package:flutter_first/components/search_cart.dart';
import 'package:getwidget/getwidget.dart';

import '../../database.dart';

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
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "My Profile",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const GFAvatar(
                    backgroundImage:
                        AssetImage("assets/images/nong-nao-doll.jpg"),
                    shape: GFAvatarShape.circle,
                    size: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Nguyễn Thanh Tiến",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "@TienNHM",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text('Chỉnh sửa'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Trending Foods For You",
                      style: TextStyle(
                          color: UI.appColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      controller: ScrollController(),
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(10, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                Container(
                                  width: 250,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage(songs[index]['img']),
                                          fit: BoxFit.cover),
                                      color: UI.appColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  songs[index]['title'],
                                  style: const TextStyle(
                                      color: Colors.white,
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
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
                ],
              ),
            ],
          ),
        ));
  }
}
