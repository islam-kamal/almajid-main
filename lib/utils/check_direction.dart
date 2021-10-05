import 'package:localize_and_translate/localize_and_translate.dart';
dynamic checkDirection({dirArabic, dirEnglish}) {
  if (translator.currentLanguage == 'ar') {
    return dirArabic;
  } else {
    return dirEnglish;
  }
}
