// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:app/presentation/screens/login_signup/login_signup_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) => LoginScreen(),
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
            child: Text("Your Tour Guide",
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
