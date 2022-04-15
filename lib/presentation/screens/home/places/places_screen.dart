// ignore_for_file: prefer_const_constructors

import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/screens/home/places/place_card.dart';
import 'package:app/presentation/screens/place_info/place_info_screen.dart';
import 'package:app/presentation/screens/statues/statues_screen.dart';
import 'package:flutter/material.dart';

import '../../../../test_data.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({
    Key? key,
    required this.list
  }) : super(key: key);

  final List list;
  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 350,
          height: 45,
          child: TextFormField(
            decoration: InputDecoration(
                label: Text(AppLocalizations.of(context).translate("search")),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                )
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(20.0),
            scrollDirection: Axis.vertical,
            itemBuilder: (context,index) => PlaceCard(
              isAvailable: widget.list[index]["isAvailable"],
              name: widget.list[index]["name"],
              description: widget.list[index]["description"],
              photoURL:widget.list[index]["photosURL"][0],
              onPressed: () {
                //naviagtor push widget.places[index]
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PlaceInfoScreen(title:widget.list[index]["name"], info: widget.list[index])
                ));
              },
              onPressedBrowse: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StatuesScreeen(title: widget.list[index]["name"],list:statues)));
              },
            ),
            itemCount: widget.list.length,
            separatorBuilder: (context,index) => SizedBox(height: 20,),
          ),
        ),
      ],
    );
  }
}
