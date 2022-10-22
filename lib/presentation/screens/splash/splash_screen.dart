// ignore_for_file: prefer_const_constructors

import 'dart:async';
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


  final TextStyle style = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.bold,
    fontSize: 35,
    color: Colors.white
  );

  Future checkFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, a1, a2) => LoginScreen(),
          transitionsBuilder: (context, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 1000),
        ),
      );
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, a1, a2) => WelcomeScreen(),
          transitionsBuilder: (context, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      checkFirstTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: const [Color(0xffffb319), Color(0xffFFE194)],
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Smart",style: style,),
          Text("Tour",style: style,),
          Text("Guide",style: style,),
          // Center(
          //   child: Image.asset("assets/images/splash.png",width: MediaQuery.of(context).size.width*0.8,errorBuilder: (context, error, stackTrace) => SizedBox(),)
          // ),
        ],
      ),
    ));
  }
}
