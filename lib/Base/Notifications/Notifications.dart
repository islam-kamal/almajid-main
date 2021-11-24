
import 'dart:async';
import 'package:almajidoud/Base/shared_preference_manger.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class AppPushNotifications {
  BuildContext context;
  AppPushNotifications({this.context});
  FirebaseMessaging _firebaseMessaging;
  GlobalKey<NavigatorState> navigatorKey;

  static StreamController<Map<String, dynamic>> _onMessageStreamController =
  StreamController.broadcast();
  static StreamController<Map<String, dynamic>> _streamController =
  StreamController.broadcast();

  static final Stream<Map<String, dynamic>> onFcmMessage =
      _streamController.stream;

  void notificationSetup(GlobalKey<NavigatorState> navigatorKey) {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      _firebaseMessaging = FirebaseMessaging.instance;
      this.navigatorKey = navigatorKey;
      print("===================================");
      requestPermissions();
      getFcmToken();
      notificationListeners();
    });

  }

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void requestPermissions() {
    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    /*   _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });*/
  }

  Future<String> getFcmToken() async {
/*    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('msgToken', await _firebaseMessaging.getToken());*/
    sharedPreferenceManager.writeData(CachingKey.FIREBASE_TOKEN, await _firebaseMessaging.getToken());
    print('firebase token => ${await _firebaseMessaging.getToken()??""}');
    print("_____________" + await _firebaseMessaging.getToken());
    return await _firebaseMessaging.getToken();
  }

  void notificationListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=>CustomCircleNavigationBar()));
    });

  }

  Future<dynamic> _onNotificationMessage(Map<String, dynamic> message) async {
    print("------- ON MESSAGE -------5555555----- $message");

    _onMessageStreamController.add(message);
  }

  Future<dynamic> _onNotificationResume(Map<String, dynamic> message) async {

    print("------- ON RESUME ------66666666------ $message");

    _streamController.add(message);
  }

  Future<dynamic> _onNotificationLaunch(Map<String, dynamic> message) async {
    print("------- ON LAUNCH -----7777777777777------- $message");

  }

  void killNotification() {
    _onMessageStreamController.close();
    _streamController.close();
  }


}
