// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/widgets/default_button.dart';
import 'package:flutter/material.dart';

class StatuesCard extends StatefulWidget {
  const StatuesCard({
    Key? key,
    required this.name,
    required this.onPressed,
    required this.description,
    required this.photoURL,
  }) : super(key: key);

  final Function() onPressed;
  final String description;
  final String photoURL;
  final String name;
  @override
  _StatuesCardState createState() => _StatuesCardState();
}

class _StatuesCardState extends State<StatuesCard> {
  bool isFavourite = false;
  bool isVisited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color.fromRGBO(232, 246, 239, 1),
      ),
      //color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(
          21,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(100, 115, 107, 1),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                  icon: Icon(
                    Icons.favorite_rounded,
                    color: isFavourite ? Colors.red : Colors.grey,
                  ),
                )
              ]
            ),
            SizedBox(
              width: 10,
            ),
            Column(children: [
              Text(
                widget.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  clipBehavior: Clip.hardEdge,
                  child: ClipRRect(
                    child: Image.network(
                      widget.photoURL,
                      height: 163,
                      width: 308,
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(
                height: 9,
              ),
              DefaultButton(
                  height: 35,
                  width: 125,
                  onPressed: widget.onPressed,
                  child: Text(
                    AppLocalizations.of(context).translate("learn more"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
