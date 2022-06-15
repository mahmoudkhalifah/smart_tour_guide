// ignore_for_file: prefer_const_constructors

import 'package:app/business_logic/cubit/location_cubit.dart';
import 'package:app/business_logic/cubit/places_cubit.dart';
import 'package:app/business_logic/cubit/statues_cubit.dart';
import 'package:app/data/api/statues_api.dart';
import 'package:app/data/models/place.dart';
import 'package:app/data/repository/statues_repository.dart';
import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/screens/home/menu/menu_screen.dart';
import 'package:app/presentation/screens/statue_info/statue_info_screen.dart';
import 'package:app/presentation/widgets/offline_builder.dart';
import 'package:app/strings.dart';
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
          padding: EdgeInsets.fromLTRB(10,10,10,0),
          child: isHome
              ? OfflineBuilderWidget(
                  child: PlacesScreen(),
                  isButton: false,
                )
              : MenuScreen(),
        )),
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
      floatingActionButton: OfflineBuilderWidget(
        isButton: true,
        child: BlocProvider(
          create: (context) => locationCubit,
          child: BlocBuilder<PlacesCubit, PlacesState>(
            builder: (context, state) {
              if(state is PlacesLoaded) {
                getPlaces();
              }
              return FloatingActionButton(
                elevation: 0,
                onPressed: state is PlacesLoaded && state is! PlacesError
                    ? () {
                        var sheetController = showModalBottomSheet(
                            backgroundColor: Colors.grey[100],
                            context: context,
                            builder: (newContext) => BlocProvider.value(
                                value: locationCubit,
                                child: Scaffold(
                                    body:
                                        buildCameraImagePickerBottomSheet())));
                        sheetController.then((value) {});
                      }
                    : () {},
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildTip(String image, String tip) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          errorBuilder: (context, error, stackTrace) => SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          ),
          height: 50,
          width: 50,
        ),
        const SizedBox(
          width: 10.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            tip,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
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
        buildTip("assets/images/tip1.png",
            AppLocalizations.of(context).translate("snap tip1")),
        const SizedBox(
          height: 10.0,
        ),
        buildTip("assets/images/tip2.png",
            AppLocalizations.of(context).translate("snap tip2")),
        const SizedBox(
          height: 10.0,
        ),
        buildTip("assets/images/tip3.png",
            AppLocalizations.of(context).translate("snap tip3")),
      ],
    );
  }

  List<DropdownMenuItem<String>> getDropDownItemsList(bool isDetected) {
    List<DropdownMenuItem<String>> items = availablePlaces
        .map((e) => [e.name, e.arabicName])
        .map<DropdownMenuItem<String>>((List<String> value) {
      return DropdownMenuItem<String>(
        value: value[0],
        child: LimitedBox(
            maxWidth: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              Localizations.localeOf(context).languageCode == "en"
                  ? value[0]
                  : value[1],
              overflow: TextOverflow.ellipsis,
            )),
      );
    }).toList();
    if (!isDetected) {
      items.add(DropdownMenuItem<String>(
        value: AppLocalizations.of(context).translate("not detected"),
        child: Text(AppLocalizations.of(context).translate("not detected")),
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
        } else if (state is LocationNotDetected ||
            state is LocationServiceDisabled ||
            state is LocationPermissionDenied) {
          placeName = AppLocalizations.of(context).translate("not detected");
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state is LocationDetected
                ? LimitedBox(
                    maxWidth: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      AppLocalizations.of(context)
                          .translate("current location"),
                      maxLines: 3,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                : SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state is LocationServiceDisabled
                    ? LimitedBox(
                        maxWidth: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate(state.errorMessage),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : SizedBox(),
                state is LocationPermissionDenied
                    ? LimitedBox(
                        maxWidth: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate(state.errorMessage),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : SizedBox(),
                state is LocationServiceDisabled ||
                        state is LocationPermissionDenied
                    ? MaterialButton(
                        onPressed: () {
                          state is LocationServiceDisabled
                              ? BlocProvider.of<LocationCubit>(context)
                                  .openLocationSettings()
                              : BlocProvider.of<LocationCubit>(context)
                                  .openAppSettings();
                        },
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("change settings"),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : SizedBox()
              ],
            ),
            state is LocationNotDetected
                ? LimitedBox(
                    maxWidth: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      AppLocalizations.of(context)
                          .translate(state.errorMessage),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              width: 5,
            ),
            state is LocationInitial ? CircularProgressIndicator() : SizedBox(),
            state is LocationDetected ||
                    state is LocationNotDetected ||
                    state is LocationServiceDisabled ||
                    state is LocationPermissionDenied
                ? LimitedBox(
                    maxWidth: MediaQuery.of(context).size.width * 0.5,
                    child: DropdownButton<String>(
                        alignment: Alignment.center,
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
                          if (placeName !=
                              AppLocalizations.of(context)
                                  .translate("not detected")) {
                            BlocProvider.of<LocationCubit>(context)
                                .setPlace(placeName, availablePlaces);
                          } else {
                            BlocProvider.of<LocationCubit>(context)
                                .setPlace("", availablePlaces);
                          }
                        },
                        items: state is LocationDetected
                            ? getDropDownItemsList(true)
                            : getDropDownItemsList(false)),
                  )
                : SizedBox(),
            IconButton(
              onPressed: () {
                BlocProvider.of<LocationCubit>(context).clearLocation();
              },
              color: Theme.of(context).colorScheme.primary,
              icon: Icon(
                Icons.replay,
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
    return BlocProvider(
      create: (context) => StatuesCubit(StatuesRepository(StatuesAPI())),
      //create: (context) => statuesCubit,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildLocationRow(),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  return BlocBuilder<StatuesCubit, StatuesState>(
                    builder: (context, statuesState) {
                      return BlocListener<StatuesCubit, StatuesState>(
                        bloc: BlocProvider.of<StatuesCubit>(context),
                        listener: (context, state) {
                          if (state is StatuePredictionLoading) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          } else if (state is StatuePredicted) {
                            Navigator.pop(context);
                            //Navigator.pop(context);
                            Navigator.pushNamed(context, statueInfoViewRoute,
                                arguments:
                                    StatueInfoScreen(statue: state.statue));
                          } else if (state is StatueNotPredicted) {
                            Navigator.pop(context);
                            final snackbar = SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .translate("prediction error")),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MaterialButton(
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: state is LocationDetected
                                  ? () async {
                                      // Capture a photo
                                      XFile? image = await _picker.pickImage(
                                          source: ImageSource.camera,
                                          maxHeight: 500,
                                          maxWidth: 500);

                                      if (image != null) {
                                        BlocProvider.of<StatuesCubit>(context)
                                            .getStatueInfoByPhoto(
                                                image, state.placeId);
                                      }
                                    }
                                  : () {
                                      final snackbar = SnackBar(
                                        content: Text(
                                            AppLocalizations.of(context)
                                                .translate("choose first")),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
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
                                      XFile? image = await _picker.pickImage(
                                          source: ImageSource.gallery,
                                          maxHeight: 500,
                                          maxWidth: 500);
                                      if (image != null) {
                                        BlocProvider.of<StatuesCubit>(context)
                                            .getStatueInfoByPhoto(
                                                image, state.placeId);
                                      }
                                    }
                                  : () {
                                      final snackbar = SnackBar(
                                        content: Text(
                                            AppLocalizations.of(context)
                                                .translate("choose first")),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              shape: CircleBorder(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              buildSnapTips(),
            ],
          ),
        ),
      ),
    );
  }
}
