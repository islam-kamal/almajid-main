import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: IOSInitializationSettings(
              requestSoundPermission: false,
              requestBadgePermission: false,
              requestAlertPermission: false,
            ));

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String route) async {
      if (route != null) {
        // Navigator.of(context).pushNamed(route);
        if (StaticData.vistor_value != "visitor") {
          switch (route) {
            case "order_update":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => OrdersScreen(
                    increment_id: "",
                  )));
              break;
          }
        }

      }
    });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
            "easyapproach",
            "easyapproach channel",
            'easyapproach description',
            importance: Importance.max,
            priority: Priority.high,
            ongoing: true,

            styleInformation: BigTextStyleInformation(''),
          ),
          iOS: IOSNotificationDetails());

      await _notificationsPlugin.show(
        id,
        message.notification.title,
        message.notification.body,
        notificationDetails,
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

}
