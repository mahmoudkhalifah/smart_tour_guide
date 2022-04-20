// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/screens/login_signup/login_signup_screen.dart';
import 'package:app/presentation/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future checkFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    
    if (_seen) {
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) => LoginScreen(),
            transitionsBuilder: (context, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 2000),
          ),
      );
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) => WelcomeScreen(),
            transitionsBuilder: (context, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 1500),
          ),
      );
    }
  }

  
  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: const [
                  Color(0xffffb319),
                  Color(0xffFFE194)
                ],
              )
          ),
          child: Center(
            child: Text(AppLocalizations.of(context).translate("splash"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40
              ),
            ),
          ),
        )
    );
  }
}
