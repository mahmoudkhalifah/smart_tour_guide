// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) => WelcomeScreen(),
            transitionsBuilder: (context, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 1000),
          ),
        )
    );
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
