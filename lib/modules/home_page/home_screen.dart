// ignore_for_file: prefer_const_constructors

import 'package:app/shared/components/place_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Home Screen"),
          ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: PlaceCard(
              description: 'Is a 15th-century defensive fortress located on the Mediterranean sea coast, '
                  'inssdf Alexandria, Egypt Is a 15th-century defensive fortress located on the '
                  'Mediterranean sea coast, in Alexandria, Egypt.Is a 15th-century defensive fortress'
                  ' located on the Mediterranean sea coast, in Alexandria, Egypt.Is a 15th-century defensive fortress located on the Mediterranean sea coast, in Alexandria, Egypt.',
              onPressed: () {},
              photoURL: 'https://www.blog.motifphotos.com/wp-content/uploads/2021/05/panorama-photo-02-1024x248.jpg',
            )
          ),
        ],
      ),
    );
  }
}
