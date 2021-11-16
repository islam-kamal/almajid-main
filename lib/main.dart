
import 'package:almajidoud/test.dart';
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

class MyApp extends StatelessWidget {
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
                    dirArabic: "Almarai", dirEnglish: "Almarai")),
            title: 'Al Majed Oud',
            home: SplashScreen(),
            localizationsDelegates:
            translator.delegates, // Android + iOS Delegates
            locale: translator.locale, // Active locale
            supportedLocales: translator.locals(),
          );
        });
      },
    );
  }
}
