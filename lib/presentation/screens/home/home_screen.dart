// ignore_for_file: prefer_const_constructors

import 'package:app/presentation/screens/camera/camera_screen.dart';
import 'package:app/presentation/screens/home/menu/menu_screen.dart';
import 'package:flutter/material.dart';

import '../../../test_data.dart';
import 'places/places_screen.dart';

class HomeScreen extends StatefulWidget {
  bool isHome = true;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),child: widget.isHome?PlacesScreen(list: places):MenuScreen(),
            )
        ),   //child changes regarding to bottom bar selection
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4,
        color: Colors.grey[300],
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  widget.isHome = true;
                  setState(() {

                  });
                },
                icon: Icon(
                  Icons.home_rounded,
                  size: 30,
                  color: widget.isHome?Theme.of(context).colorScheme.primary:Colors.black,
                )
            ),
            Opacity(
              opacity: 0,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home_rounded,
                    size: 30,
                  )
              ),
            ),
            IconButton(
                onPressed: () {
                  widget.isHome = false;
                  setState(() {

                  });
                },
                icon: Icon(
                  Icons.menu_rounded,
                  size: 30,
                  color: !widget.isHome?Theme.of(context).colorScheme.primary:Colors.black,
                )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CameraScreen(),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.camera_alt_rounded,
          size: 35,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
