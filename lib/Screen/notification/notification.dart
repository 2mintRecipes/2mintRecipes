import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:x2mint_recipes/services/notifications.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';
import 'package:x2mint_recipes/utils/database.dart';

class MyNotification extends StatefulWidget {
  static const routeName = '/notification';
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  int activeType = 0;
  NotificationsService notificationService = NotificationsService();
  late Future _notificationsFuture;
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    getNotifications("UNREAD");
  }

  String getActiveNotificationsType() {
    if (activeType == 0) {
      return 'UNREAD';
    } else {
      return 'ALL';
    }
  }

  Future getNotifications(String status) async {
    _notificationsFuture = notificationService.getNotificationsByStatus(status);
  }

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
          padding: const EdgeInsets.only(left: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              getTitle(),

              /// Notification type
              getNotificationTypes(),

              /// List of notifications
              getListNotifications(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Notifications",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget getNotificationTypes() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: ScrollController(),
      child: Row(
        children: List.generate(
          notificationsTypeLabel.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 25),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    activeType = index;
                    getNotifications(getActiveNotificationsType());
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
                          notificationsTypeLabel[index],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getNotificationItem(int index) {
    double cWidth = MediaQuery.of(context).size.width * 0.65;
    double notificationWidth = MediaQuery.of(context).size.width * 0.88;

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
                  color: Colors.white.withOpacity(.4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/MIT2021.png"),
                              fit: BoxFit.cover),
                          color: UI.appColor),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: cWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            _notifications[index]['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _notifications[index]['content'],
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
  }

  Widget getListNotifications() {
    return FutureBuilder(
      future: _notificationsFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          _notifications = snapshot.data;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: ScrollController(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                _notifications.length,
                (index) {
                  return getNotificationItem(index);
                },
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
