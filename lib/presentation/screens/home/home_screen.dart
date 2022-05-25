// ignore_for_file: prefer_const_constructors

import 'package:app/business_logic/cubit/location_cubit.dart';
import 'package:app/business_logic/cubit/places_cubit.dart';
import 'package:app/data/models/place.dart';
import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/screens/home/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'places/places_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isHome = true;
  late List<Place> availablePlaces;
  LocationCubit locationCubit = LocationCubit();

  void getPlaces() async {
    availablePlaces =
        await BlocProvider.of<PlacesCubit>(context).getAllPlaces();
    availablePlaces =
        availablePlaces.where((place) => place.isAvailable).toList();
  }

  @override
  void initState() {
    super.initState();
    getPlaces();
  }

  @override
  void dispose() {
    locationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: isHome ? PlacesScreen() : MenuScreen(),
        )), //child changes regarding to bottom bar selection
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4,
        color: Colors.grey[200],
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  isHome = true;
                  setState(() {});
                },
                icon: Icon(
                  Icons.home_rounded,
                  size: 30,
                  color: isHome
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black,
                )),
            Opacity(
              opacity: 0,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home_rounded,
                    size: 30,
                  )),
            ),
            IconButton(
                onPressed: () {
                  isHome = false;
                  setState(() {});
                },
                icon: Icon(
                  Icons.menu_rounded,
                  size: 30,
                  color: !isHome
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black,
                )),
          ],
        ),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => locationCubit,
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            var sheetController = showModalBottomSheet(
                backgroundColor: Colors.grey[100],
                context: context,
                builder: (newContext) => BlocProvider.value(
                    //create:(_) => LocationCubit(),
                    value: locationCubit,
                    child:
                        Scaffold(body: buildCameraImagePickerBottomSheet())));
            sheetController.then((value) {});
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.camera_alt_rounded,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildSnapTips() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).translate("snap tips"),
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.w900,
            fontSize: 26,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/tip 1.png",
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 10.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                AppLocalizations.of(context).translate("snap tip1"),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/tip 2.png",
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 10.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                AppLocalizations.of(context).translate("snap tip2"),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/tip 3.png",
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 10.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                AppLocalizations.of(context).translate("snap tip3"),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getDropDownItemsList(bool isDetected) {
    List<DropdownMenuItem<String>> items = availablePlaces
        .map((e) => e.name)
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
    if (!isDetected) {
      items.add(DropdownMenuItem<String>(
        value: "Not Detected",
        child: Text("Not Detected"),
      ));
    }
    return items;
  }

  Widget buildLocationRow() {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        String placeName = "";
        if (state is LocationInitial) {
          BlocProvider.of<LocationCubit>(context).getlocation();
        } else if (state is LocationLoaded) {
          BlocProvider.of<LocationCubit>(context)
              .getNearistPlaceToUser(state.lat, state.long, availablePlaces);
        } else if (state is LocationDetected) {
          placeName = state.placeName;
        } else if (state is LocationNotDetected) {
          placeName = "Not Detected";
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state is LocationDetected
                ? Text(
                    "You are currently in",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  )
                : SizedBox(),
            state is LocationNotDetected
                ? LimitedBox(
                  maxWidth: 150,
                  child: Text(
                      state.errorMessage,
                      maxLines: 3,
                      style: TextStyle(color: Colors.red),
                    ),
                )
                : SizedBox(),
            SizedBox(width: 5,),
            state is LocationInitial ? CircularProgressIndicator() : SizedBox(),
            state is LocationDetected || state is LocationNotDetected
                ? Column(
                    children: [
                      DropdownButton<String>(
                          value: placeName,
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          menuMaxHeight: 100,
                          itemHeight: 50,
                          elevation: 2,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          underline: Container(
                            height: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onChanged: (String? newValue) {
                            placeName = newValue!;
                            if (placeName != "Not Detected") {
                              BlocProvider.of<LocationCubit>(context)
                                  .setPlace(placeName,availablePlaces);
                            } else {
                              BlocProvider.of<LocationCubit>(context)
                                  .setPlace("",availablePlaces);
                            }

                            print(placeName);
                          },
                          items: state is LocationDetected
                              ? getDropDownItemsList(true)
                              : getDropDownItemsList(false)),
                    ],
                  )
                : SizedBox(),
            IconButton(
              onPressed: () {
                BlocProvider.of<LocationCubit>(context).clearLocation();
              },
              icon: Icon(
                Icons.close,
                size: 20,
              ),
            )
          ],
        );
      },
    );
  }

  Widget buildCameraImagePickerBottomSheet() {
    final ImagePicker _picker = ImagePicker();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildLocationRow(),
          SizedBox(height: 10,),
          BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MaterialButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: state is LocationDetected
                        ? () async {
                            print(state.placeId);
                            // Capture a photo
                            final XFile? photo = await _picker.pickImage(
                                source: ImageSource.camera);
                          }
                        : () {
                            final snackbar = SnackBar(
                              content: Text("choose location first"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    shape: CircleBorder(),
                  ),
                  MaterialButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: state is LocationDetected
                        ? () async {
                            // Pick an image
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);
                          }
                        : () {
                            final snackbar = SnackBar(
                              content: Text("choose location first"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.photo,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    shape: CircleBorder(),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          buildSnapTips(),
        ],
      ),
    );
  }
}
