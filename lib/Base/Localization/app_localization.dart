import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AppLocalization{
  final Locale locale;
  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context){
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocaliztionsDelegate();

  Map<String,String> _localizationString;

  Future<bool> load()async{
    String jsonString = await rootBundle.loadString('Lang/${locale.languageCode}.json');
    Map<String,dynamic> jsonMap = json.decode(jsonString);
    _localizationString = jsonMap.map((key, value){
      return MapEntry(key,value.toString());
    });
    return true;
  }

  String translate(String key){
    return _localizationString[key];
  }
}

class _AppLocaliztionsDelegate extends LocalizationsDelegate<AppLocalization>{
  const _AppLocaliztionsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async{
    AppLocalization localization = new AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
   return false;
  }
  
}