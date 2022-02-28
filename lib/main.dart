// ignore_for_file: prefer_const_constructors

import 'package:app/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        //home: LoginScreen(),
        debugShowMaterialGrid: false,
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