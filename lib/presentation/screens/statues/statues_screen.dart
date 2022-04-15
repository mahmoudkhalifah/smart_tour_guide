// ignore_for_file: prefer_const_constructors

import 'package:app/presentation/screens/statue_info/statue_info_screen.dart';
import 'package:app/presentation/screens/statues/statue_card.dart';
import 'package:flutter/material.dart';

class StatuesScreeen extends StatefulWidget {
  const StatuesScreeen({Key? key, required this.list,required this.title}) : super(key: key);
  final String title;
  final List list;
  @override
  _StatuesScreeenState createState() => _StatuesScreeenState();
}

class _StatuesScreeenState extends State<StatuesScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20.0),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => StatuesCard(
          name: widget.list[index]["name"],
          description: widget.list[index]["description"],
          photoURL: widget.list[index]["photosURL"][0],
          onPressed: () {
            //naviagtor push widget.places[index]
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        StatueInfoScreen(info: widget.list[index])));
          },
        ),
        itemCount: widget.list.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 20,
        ),
      ),
    );
  }
}
