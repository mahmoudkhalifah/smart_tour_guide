// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String,String> _localizedStrings;
  static LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelgate();

  AppLocalizations({
    required this.locale,
  });

  static AppLocalizations of(BuildContext context) =>
    Localizations.of(context, AppLocalizations);

  Future load() async {
    String jsonString =
      await rootBundle.loadString('languages/${locale.languageCode}.json');
    Map<String,dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value));
  }

  String translate(String key) {
    return _localizedStrings[key]??"";
  }
}

class _AppLocalizationsDelgate
  extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['ar','en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;

}