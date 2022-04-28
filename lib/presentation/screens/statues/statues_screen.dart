// ignore_for_file: prefer_const_constructors

import 'package:app/business_logic/cubit/places_cubit.dart';
import 'package:app/data/models/statue.dart';
import 'package:app/presentation/screens/statue_info/statue_info_screen.dart';
import 'package:app/presentation/screens/statues/statue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatuesScreeen extends StatefulWidget {
  const StatuesScreeen({Key? key,required this.title,required this.placeId}) : super(key: key);
  final String title;
  final placeId;
  @override
  _StatuesScreeenState createState() => _StatuesScreeenState();
}

class _StatuesScreeenState extends State<StatuesScreeen> {
  late List<Statue> statues;
  
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlacesCubit>(context).getStatues(widget.placeId);
  }

  Widget buildBlocWidget() {
    return BlocBuilder<PlacesCubit, PlacesState>(builder: (context, state) {
      if (state is StatuesLoaded) {
        statues = state.statues;
        return buildStatuesList();
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    });
  }

  Widget buildStatuesList() {
    return ListView.separated(
        padding: const EdgeInsets.all(20.0),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => StatuesCard(
          statue: statues[index],
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        StatueInfoScreen(statue: statues[index])));
          },
        ),
        itemCount: statues.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 20,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildBlocWidget(),
    );
  }
}
