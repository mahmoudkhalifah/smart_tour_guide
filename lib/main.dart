import 'dart:io';

import 'package:app/localization/app_localizations.dart';
import 'package:app/router.dart';
import 'package:app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _AppState? state = context.findAncestorStateOfType<_AppState>();
    state!.changeLanguage(newLocale);
  }
}

class _AppState extends State<App> {
  String defaultLocale = Platform.localeName;
  late Locale _locale = Locale(defaultLocale.split('_')[0]);
  late SharedPreferences prefs;
  late String _fontFamily = "Roboto";

  changeLanguage(Locale locale) {
    setState(() {
      prefs.setString('lang', locale.languageCode);
      _locale = locale;
      getFontFamily(locale.languageCode);
    });
  }

  getFontFamily(String language) {
    if (language == "en") {
      _fontFamily = "Roboto";
    } else if (language == "ar") {
      _fontFamily = "Tajawal";
    }
    setState(() {});
  }

  getLocalLocale() async {
    prefs = await SharedPreferences.getInstance();
    final String? language = prefs.getString('lang');
    if (language != null) {
      _locale = Locale(language);
      setState(() {});
    } else {
      _locale = Locale(defaultLocale.split('_')[0]);
    }
    getFontFamily(_locale.languageCode);
  }

  @override
  void initState() {
    getLocalLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'SA'),
      ],

      locale: _locale,

      localizationsDelegates: [
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      initialRoute: splashViewRoute,
      onGenerateRoute: AppRoute.generateRoute,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: _fontFamily,
        colorScheme: const ColorScheme.light(
            primary: Color(0xffffb319), secondary: Color(0xffE8F6EF)),
      ),
    );
  }
}
