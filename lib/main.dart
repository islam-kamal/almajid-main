
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';

import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'Base/Notifications/local_notification_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// receive message when app is in background without clicking on the notification
Future<void> _backgroundHandler(RemoteMessage message) async{

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );

  await Firebase.initializeApp();
  /// maintain the push message if the application is closed
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  runApp(
    MaterialApp(
      home: LocalizedApp(
        child: MyApp(),

      ),
     theme: ThemeData(
        accentColor: mainColor,
        primaryColor: mainColor,
        fontFamily: checkDirection(
            dirArabic: "Cairo", dirEnglish: "Cairo")
    ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
class MyApp extends StatefulWidget{
  static var app_langauge;
  static var app_location;
  static var country_currency ;
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType();
    app_langauge = newLocale.languageCode;
    state.setState(() => state.local = newLocale);
  }

  static void restartApp(BuildContext context) {

    context.findAncestorStateOfType<_MyAppState>().restartApp();

  }
}

class _MyAppState extends State<MyApp> {
  Locale local;
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      get_Static_data();
      cartRepository.create_quote(context: context);
      key = UniqueKey();
    });
  }
  @override
  void initState() {
    get_Static_data();
    _fcmConfigure(context);
  }
  void get_Static_data()async{
    await sharedPreferenceManager.readString(CachingKey.USER_COUNTRY_CODE).then((value){
      if(value == ''){
        MyApp.app_location = 'sa';
        MyApp.country_currency = MyApp.app_location == 'sa' ?translator.translate("SAR")
            : MyApp.app_location == 'uae'? translator.translate("AED") :  translator.translate("KWD");
      }else{
        MyApp.app_location = value;
        MyApp.country_currency = MyApp.app_location == 'sa' ?translator.translate("SAR")
            : MyApp.app_location == 'uae'? translator.translate("AED") : translator.translate("KWD");
      }

    });
    await sharedPreferenceManager.readString(CachingKey.APP_LANGUAGE).then((value){
      if(value == ''){
        MyApp.app_langauge = translator.activeLanguageCode;
      }else{
        MyApp.app_langauge = value;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(

      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          return KeyedSubtree(
            key:key ,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  accentColor: mainColor,
                  primaryColor: mainColor,
                  fontFamily: checkDirection(
                      dirArabic: "Cairo", dirEnglish: "Cairo")
              ),
              title: 'Al Majed Oud',
              home: SplashScreen(),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              locale: local,
// Android + iOS Delegates
              // locale: translator.locale, // Active locale
              supportedLocales: translator.locals(),
            ),
          );
        });
      },
    );
  }

  Future<void> _fcmConfigure(BuildContext context) async{
    LocalNotificationService.initialize(context);
    final _firebaseMessaging = FirebaseMessaging.instance;
    ///required by IOS permissions
    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    // //get the current device token
    // _getCustomerNotification();

    ///gives you the message on which use taps
    ///and it opened from the terminated state
    _firebaseMessaging.getInitialMessage().then((message) {
      if(message !=null){
        final routeMessage = message.data['route'];
        if (StaticData.vistor_value != "visitor") {
          switch (routeMessage) {
            case "order_update":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => OrdersScreen( increment_id: "" )));
              break;
          }
        }
      }
    });


    ///app open on ForeGround. notification will not be visibile but you will receive the data
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification !=null){
        LocalNotificationService.display(message);
      }
    });

    ///app in background and not terminated when you click on the notification this should be triggered
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeMessage = message.data['route'];

      if (StaticData.vistor_value != "visitor") {
        switch (routeMessage) {
          case "order_update":
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => OrdersScreen( increment_id: "" )));
            break;
        }
      }
    });
  }


}
