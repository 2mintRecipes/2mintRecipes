// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x2mint_recipes/screens/login.dart';
import 'package:x2mint_recipes/screens/profile/edit_profile.dart';
import 'package:x2mint_recipes/services/auth.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:getwidget/getwidget.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/utils/database.dart';

class Profile extends StatefulWidget {
  static const routeName = '/Profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int activeMenu1 = 0;
  SecureStorage secureStorage = SecureStorage();
  AuthClass authClass = AuthClass();

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
                    ))),
          )
        ],
      ),
    );
  }

  Widget getBody() {
    return Padding(
      padding: EdgeInsets.only(top: UI.topPadding, left: 30, right: 30),
      child: Column(
        children: [
          getBasicInfo(),
          SizedBox(
            height: 20,
          ),
          getOverview(),
          getGallery(),
        ],
      ),
    );
  }

  Widget getBasicInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const GFAvatar(
              backgroundImage: AssetImage("assets/images/MIT2021.png"),
              shape: GFAvatarShape.circle,
              size: 72,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 3, bottom: 3, left: 10, right: 10),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: editProfile,

                      ///
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: UI.appColor,
                        shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.manage_accounts),
                      label: const Text(
                        "Edit Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () async {
                    await authClass.signOut();
                    try {
                      await GoogleSignIn().disconnect();
                    } catch (e) {
                      print(e);
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => const Login()),
                        (route) => false);
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                    softWrap: true,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "@TienNHM",
              style: TextStyle(
                  fontSize: 18,
                  color: UI.appColor,
                  fontStyle: FontStyle.italic),
            ),
            const Text(
              "Nguyễn Huỳnh Minh Tiến",
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getOverview() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Recipes",
                style: TextStyle(
                  // fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "14",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              color: Colors.grey,
              thickness: 1.5,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Followers",
                style: TextStyle(
                  // fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "100",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              color: Colors.grey,
              thickness: 1.5,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Following",
                style: TextStyle(
                  // fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "10",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getGallery() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "My Gallery",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          // padding: const EdgeInsets.all(10),
          controller: ScrollController(),
          children: List.generate(
            10,
            (index) {
              return GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.width * .3,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage(mockRecipes[index]['img']),
                              fit: BoxFit.cover),
                          color: Colors.white),
                    ),
                    Text(
                      mockRecipes[index]['title'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),

                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * .35,
                    //   child: Text(
                    //     songs[index]['description'],
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //         fontSize: 12,
                    //         color: Colors.white.withOpacity(.4),
                    //         fontWeight: FontWeight.w600),
                    //   ),
                    // )
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  void editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfile(),
      ),
    );
  }

  void logout() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    secureStorage.deleteSecureData('uid');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }
}
