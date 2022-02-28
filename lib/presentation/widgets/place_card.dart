// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'default_button.dart';


/// You MUST specify photo's url
/// You MUST specify description text
/// You MUST specify on pressed function for learn more button







class PlaceCard extends StatefulWidget {
  PlaceCard({
    Key? key,
    required this.onPressed,
    required this.description,
    required this.photoURL,
  }) : super(key: key);

  bool favouriteClicked = false;
  bool visitedClicked   = false;

  final Function() onPressed;
  final String description;
  final String photoURL;

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color.fromRGBO(232 , 246, 239, 1),
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
                Text(
                  'Bey Citadal',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(100, 115, 107, 1),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: (){
                        setState(() {
                          widget.visitedClicked =!widget.visitedClicked;
                        });
                      },
                      icon: Icon(
                        Icons.add_task_outlined,
                        color: widget.visitedClicked? Colors.orange : Colors.black,
                      ),
                      iconSize: 24,
                    ),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          widget.favouriteClicked = !widget.favouriteClicked;
                        });
                      },
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: widget.favouriteClicked? Colors.red : Colors.grey,
                      ),
                      iconSize: 24,
                    ),
                  ],
                )
              ],
            ),
            Column(
                children:[
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      clipBehavior: Clip.hardEdge,
                      child: ClipRRect(
                        child: Image.network(
                          widget.photoURL,
                          height: 163,
                          width: 308,
                          fit: BoxFit.cover,
                        ),
                      )
                  ),

                  SizedBox(
                    height: 9,
                  ),
                  Center(
                    child: DefaultButton(
                        height: 35,
                        width: 150,
                        onPressed: widget.onPressed,
                        child:Text(
                          "Learn More",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )
                    ),
                  ),
                ]
            ),
          ],
        ),
      ) ,
    );
  }
}
