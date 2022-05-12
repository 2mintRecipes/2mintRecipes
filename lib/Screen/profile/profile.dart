import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:x2mint_recipes/Screen/login.dart';
import 'package:x2mint_recipes/Screen/profile/edit_profile.dart';
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
                      Colors.white.withOpacity(1), BlendMode.darken),
                  image: const AssetImage("assets/images/bg.jpg"),
                ),
              ),
            ),
          ),
          getBody(),
        ],
      ),
    );
  }

  Widget getBody() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
        child: SingleChildScrollView(
          controller: ScrollController(),
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
          child: Column(
            children: [
              getBasicInfo(),
              getOverview(),
              getGallary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBasicInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const GFAvatar(
          backgroundImage: AssetImage("assets/images/MIT2021.png"),
          shape: GFAvatarShape.circle,
          size: 64,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              const SizedBox(height: 10),
              const Text(
                "@TienNHM",
                style: TextStyle(
                    fontSize: 18,
                    color: UI.appColor,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: editProfile,
                child: const Text(
                  'Chỉnh sửa',
                  style: TextStyle(color: Colors.white),
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () async {
                  await authClass.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => const Login()),
                      (route) => false);
                },
                child: const Text(
                  'Đăng xuất',
                  style: TextStyle(color: Colors.white),
                  softWrap: true,
                ),
              ),
            ],
          ),
        )
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

  Widget getGallary() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "My Gallary",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
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
                      width: 250,
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage(songs[index]['img']),
                              fit: BoxFit.cover),
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
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
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(.4),
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
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

  void logout() {
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
