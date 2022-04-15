// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/localization/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../widgets/default_button.dart';

/// You MUST specify photo's url
/// You MUST specify description text
/// You MUST specify on pressed function for learn more button

class PlaceCard extends StatefulWidget {
  const PlaceCard({
    Key? key,
    required this.name,
    required this.onPressed,
    this.onPressedBrowse,
    required this.description,
    required this.photoURL,
    required this.isAvailable,
  }) : super(key: key);

  final Function() onPressed;
  final Function()? onPressedBrowse;
  final String description;
  final String photoURL;
  final String name;
  final bool isAvailable;

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool favouriteClicked = false;
  bool visitedClicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color.fromRGBO(232, 246, 239, 1),
      ),
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
                SizedBox(
                  width: 10,
                ),
                if (widget.isAvailable)
                  Row(children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.green,
                      size: 15,
                    ),
                    Text(
                      AppLocalizations.of(context).translate("available"),
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    )
                  ]),
                //Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      visitedClicked = visitedClicked;
                    });
                  },
                  icon: Icon(
                    Icons.add_task_outlined,
                    color: visitedClicked ? Colors.orange : Colors.black,
                  ),
                  iconSize: 24,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      favouriteClicked = favouriteClicked;
                    });
                  },
                  icon: Icon(
                    Icons.favorite_rounded,
                    color: favouriteClicked ? Colors.red : Colors.grey,
                  ),
                  iconSize: 24,
                )
              ],
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
              Row(
                mainAxisAlignment: widget.isAvailable
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: [
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
                  if (widget.isAvailable)
                    DefaultButton(
                        height: 35,
                        width: 125,
                        onPressed: widget.onPressedBrowse!,
                        child: Text(
                          AppLocalizations.of(context).translate("browse place"),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
