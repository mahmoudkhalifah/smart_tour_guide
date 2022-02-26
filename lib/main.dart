// ignore_for_file: prefer_const_constructors

import 'package:app/modules/home_page/home_screen.dart';
import 'package:flutter/material.dart';
import 'modules/login_signup/login_signup_screen.dart';

void main() {
  runApp(
    MaterialApp(
      //home: LoginScreen(),
      home: HomeScreen(),
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