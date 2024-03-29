// ignore_for_file: prefer_const_constructors

import 'package:app/business_logic/cubit/places_cubit.dart';

import 'package:app/data/models/place.dart';

import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/screens/home/places/place_card.dart';
import 'package:app/presentation/screens/place_info/place_info_screen.dart';
import 'package:app/presentation/screens/statues/statues_screen.dart';

import 'package:app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  late List<Place> places;
  late List<Place> _searchedPlaces;

  @override
  void initState() {
    super.initState();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<PlacesCubit, PlacesState>(builder: (context, state) {
      if (state is PlacesLoaded) {
        places = state.places;
        return buildPlacesList();
      } else if (state is PlacesError) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context).translate("no data")),
            MaterialButton(
              onPressed: () {
                BlocProvider.of<PlacesCubit>(context).resetToInitial();
                BlocProvider.of<PlacesCubit>(context).getAllPlaces();
              },
              child: Text(AppLocalizations.of(context).translate("try again")),
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
            )
          ],
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    });
  }

  Widget buildPlacesList() {
    return Column(
      children: [
        SizedBox(
          width: 350,
          height: 45,
          child: TextFormField(
            onTap: () {
              _startSearching();
            },
            onChanged: (value) {
              setState(() {
                _search(value);
              });
            },
            controller: _searchController,
            decoration: InputDecoration(
                label: Text(AppLocalizations.of(context).translate("search")),
                contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(Icons.search),
                suffixIcon: _isSearching
                    ? IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                            _stopSearching();
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                )),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<PlacesCubit>(context).getAllPlaces();
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(20.0),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => PlaceCard(
                place: _searchController.text.isNotEmpty
                    ? _searchedPlaces[index]
                    : places[index],
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    placeInfoViewRoute,
                    arguments: PlaceInfoScreen(
                      place: _searchController.text.isNotEmpty
                          ? _searchedPlaces[index]
                          : places[index],
                    ),
                  );
                },
                onPressedBrowse: () {
                  Navigator.pushNamed(
                    context,
                    statuesViewRoute,
                    arguments: StatuesScreeen(
                      title:
                          Localizations.localeOf(context).languageCode == "en"
                              ? places[index].name
                              : places[index].arabicName,
                      placeId: places[index].id,
                    ),
                  );
                },
              ),
              itemCount: _searchController.text.isNotEmpty
                  ? _searchedPlaces.length
                  : places.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBlocWidget();
  }

  void _search(String searchText) {
    _searchedPlaces = places
        .where((place) => Localizations.localeOf(context).languageCode == "en"
            ? place.name.toLowerCase().contains(searchText.toLowerCase())
            : place.arabicName.contains(searchText))
        .toList();
  }

  void _startSearching() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _searchedPlaces.clear();
    });
  }
}
