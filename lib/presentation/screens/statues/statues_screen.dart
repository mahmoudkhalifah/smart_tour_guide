// ignore_for_file: prefer_const_constructors

import 'package:app/presentation/screens/home/contents/place_card.dart';
import 'package:app/presentation/screens/statues/statue_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../test_data.dart';

class StatuesScreeen extends StatefulWidget {
  StatuesScreeen({
    Key? key,
    required this.list
  }) : super(key: key);

  final List list;
  @override
  _StatuesScreeenState createState() => _StatuesScreeenState();
}

class _StatuesScreeenState extends State<StatuesScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.all(20.0),
        scrollDirection: Axis.vertical,
        itemBuilder: (context,index) => StatuesCard(
          name: widget.list[index]["name"],
          description: widget.list[index]["description"],
          photoURL:widget.list[index]["photoURL"],
          onPressed: () {
            //naviagtor push widget.places[index]
          },
        ),
        itemCount: widget.list.length,
        separatorBuilder: (context,index) => SizedBox(height: 20,),
      ),
    );
  }
}