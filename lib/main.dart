
import 'package:almajidoud/Base/Shimmer/list_shimmer.dart';
import 'package:almajidoud/screens/Payment/stc_pay/stc_pay_phone_screen.dart';
import 'package:almajidoud/screens/checkout/checkout_address_screen.dart';
import 'package:almajidoud/screens/checkout/checkout_payment_screen.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );
  runApp(
    LocalizedApp(
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget{
  static var app_langauge;
  static var app_location;
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType();
    print(newLocale.languageCode);
    app_langauge = newLocale.languageCode;
    print("app_langauge : ${app_langauge}");
    state.setState(() => state.local = newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale local;


  @override
  void initState() {
    get_Static_data();
  }
  void get_Static_data()async{
    await sharedPreferenceManager.readString(CachingKey.USER_COUNTRY_CODE).then((value){
      if(value == ''){
        MyApp.app_location = 'sa';
      }else{
        MyApp.app_location = value;
      }
      print("app_location : ${MyApp.app_location}");

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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                accentColor: mainColor,
                primaryColor: mainColor,
                fontFamily: checkDirection(
                    dirArabic: "Cairo", dirEnglish: "Cairo")
            ),
            title: 'Al Majed Oud',
            home: SplashScreen(),
            localizationsDelegates:
            translator.delegates, //
            locale: local,
// Android + iOS Delegates
           // locale: translator.locale, // Active locale
            supportedLocales: translator.locals(),
          );
        });
      },
    );
  }
}
