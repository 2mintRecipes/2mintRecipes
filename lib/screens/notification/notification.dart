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
        padding:
            const EdgeInsets.only(top: 50, bottom: 20, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            getTitle(),
            const SizedBox(
              height: 20,
            ),

            /// Notification type
            getNotificationTypes(),

            /// List of notifications
            getListNotifications(),
          ],
        ));
  }

  Widget getTitle() {
    return Row(
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
            return GestureDetector(
                onTap: () {
                  setState(() {
                    activeType = index;
                    getNotifications(getActiveNotificationsType());
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
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
                        top: 5, bottom: 5, left: 10, right: 10),
                    child: Text(
                      notificationsTypeLabel[index],
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget getNotificationItem(dynamic notification) {
    double notificationWidth = MediaQuery.of(context).size.width - 60;
    double contentWidth = notificationWidth * .7;
    double photoWidth = notificationWidth * .2;

    return GestureDetector(
      onTap: () async {
        await notificationService.makeNotificationRead(notification['id']);
        // await getNotifications(getActiveNotificationsType());
        var result = await notificationService
            .getNotificationsByStatus(getActiveNotificationsType());
        setState(() {
          _notifications = result;
        });
      },
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
                      width: photoWidth,
                      height: photoWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/MIT2021.png"),
                              fit: BoxFit.cover),
                          color: UI.appColor),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: contentWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            notification?['title'] ?? '',
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
                            notification?['content'] ?? '',
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
          return const Center(child: CircularProgressIndicator());
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
                  return getNotificationItem(_notifications[index]);
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
