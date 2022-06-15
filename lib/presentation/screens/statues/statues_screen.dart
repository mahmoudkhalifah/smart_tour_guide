// ignore_for_file: prefer_const_constructors

import 'package:app/business_logic/cubit/statues_cubit.dart';
import 'package:app/data/models/statue.dart';
import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/screens/statue_info/statue_info_screen.dart';
import 'package:app/presentation/screens/statues/statue_card.dart';
import 'package:app/presentation/widgets/offline_builder.dart';
import 'package:app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatuesScreeen extends StatefulWidget {
  const StatuesScreeen({Key? key, required this.title, required this.placeId})
      : super(key: key);
  final String title;
  final int placeId;
  @override
  _StatuesScreeenState createState() => _StatuesScreeenState();
}

class _StatuesScreeenState extends State<StatuesScreeen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  late List<Statue> statues;
  late List<Statue> _searchedStatues;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StatuesCubit>(context).getStatues(widget.placeId);
  }

  Widget buildBlocWidget() {
    return BlocBuilder<StatuesCubit, StatuesState>(builder: (context, state) {
      if (state is StatuesLoaded) {
        statues = state.statues;
        return buildStatuesList();
      } else if (state is StatuesError) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(AppLocalizations.of(context).translate("no data")),
            MaterialButton(
              onPressed: () {
                BlocProvider.of<StatuesCubit>(context).resetToInitial();
                BlocProvider.of<StatuesCubit>(context).getStatues(widget.placeId);
              },
              child: Text(AppLocalizations.of(context).translate("try again")),
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
            )
          ]),
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

  Widget buildStatuesList() {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<StatuesCubit>(context).getStatues(widget.placeId);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10,0),
            child: SizedBox(
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
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20.0),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => StatuesCard(
                statue: _searchController.text.isNotEmpty
                          ? _searchedStatues[index]
                          : statues[index],
                onPressed: () {
                  Navigator.pushNamed(context, statueInfoViewRoute,
                      arguments: StatueInfoScreen(statue: _searchController.text.isNotEmpty
                          ? _searchedStatues[index]
                          : statues[index],));
                },
              ),
              itemCount: _searchController.text.isNotEmpty
                  ? _searchedStatues.length
                  : statues.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: OfflineBuilderWidget(child: buildBlocWidget(),isButton: false,),
    );
  }

    void _search(String searchText) {
    _searchedStatues = statues
        .where((statue) => Localizations.localeOf(context).languageCode == "en"
            ? statue.name.toLowerCase().contains(searchText.toLowerCase())
            : statue.arabicName.contains(searchText))
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
      _searchedStatues.clear();
    });
  }
}
