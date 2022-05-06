import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first/app_ui.dart';
import 'package:flutter_first/components/search_cart.dart';

import '../../database.dart';

class MyNotification extends StatefulWidget {
  static const routeName = '/notification';
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  int activeType = 0;

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
          getNotification(),
        ]));
  }

  Widget getNotification() {
    return ClipRRect(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
      child: SingleChildScrollView(
        controller: ScrollController(),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            getTitle(),

            /// Notification type
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              child: getNotificationTypes(),
            ),

            /// List of notifications
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getNotificationItems(),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget getTitle() {
    return Column(
      children: const [
        Text(
          "Notification",
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget getNotificationTypes() {
    return Row(
        children: List.generate(notificationType.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(right: 25),
        child: GestureDetector(
          onTap: () {
            setState(() {
              activeType = index;
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
                    borderRadius: BorderRadius.circular(15),
                    color: activeType == index
                        ? UI.appColor
                        : Colors.black.withOpacity(.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5, right: 10, bottom: 5, left: 10),
                    child: Text(
                      notificationType[index],
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
    }));
  }

  List<GestureDetector> getNotificationItems() {
    double cWidth = MediaQuery.of(context).size.width * 0.7;
    double notificationWidth = MediaQuery.of(context).size.width * 0.88;

    return List.generate(10, (index) {
      return GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: notificationWidth,
                  decoration: BoxDecoration(
                      // border: Border.all(width: 2, color: UI.appColor),
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(39, 105, 171, 120)),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: AssetImage(songs[index]['img']),
                                fit: BoxFit.cover),
                            color: UI.appColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: cWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              songs[index]['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              songs[index]['description'],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
