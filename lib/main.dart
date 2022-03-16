// ignore_for_file: prefer_const_constructors

import 'package:app/presentation/screens/home/home_screen.dart';
import 'package:app/presentation/screens/login_signup/login_signup_screen.dart';
import 'package:app/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/camera/camera_screen.dart';
import 'package:camera/camera.dart';

void main() {
  runApp(
      MaterialApp(
        home: SplashScreen(),
        debugShowMaterialGrid: false,
        //home: HomeScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
              primary: Color(0xffffb319),
              secondary: Color(0xffE8F6EF)
          ),
        ),
      )
  );
}