// ignore_for_file: prefer_const_constructors

import 'package:app/business_logic/cubit/location_cubit.dart';
import 'package:app/business_logic/cubit/places_cubit.dart';
import 'package:app/data/api/places_api.dart';
import 'package:app/data/models/place.dart';
import 'package:app/data/repository/places_repository.dart';
import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/screens/camera/camera_screen.dart';
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
  late List<Place> places;

  @override
  void initState() {
    super.initState();
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
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          //TODO
          var sheetController = showModalBottomSheet(
              backgroundColor: Colors.grey[100],
              context: context,
              builder: (context) => buildCameraImagePickerBottomSheet());
          sheetController.then((value) {});
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.camera_alt_rounded,
          size: 35,
          color: Colors.white,
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

  Widget buildCameraImagePickerBottomSheet() {
    final ImagePicker _picker = ImagePicker();
    return BlocProvider(
      create: (context) => LocationCubit(),
      child: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          if(state is LocationInitial){
            BlocProvider.of<LocationCubit>(context).getlocation();
          } else if(state is LocationLoaded){
            //TODO should get places to pass it
            //BlocProvider.of<LocationCubit>(context).getNearistPlaceToUser(state.lat,state.long);
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Location"),
                    const SizedBox(
                      width: 10.0,
                    ),
                    state is LocationInitial
                        ? CircularProgressIndicator()
                        : SizedBox(),
                    state is LocationLoaded
                        ? Text("${state.lat}, ${state.long}")
                        : SizedBox(),
                    state is LocationDetected
                        ? Text(state.placeName)
                        : SizedBox(),
                    state is LocationNotDetected
                        ? Text(state.errorMessage)
                        : SizedBox(),
                    MaterialButton(onPressed: () {
                      BlocProvider.of<LocationCubit>(context).clearLocation();
                    }, child: Icon(Icons.close,size: 20,),height: 10,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MaterialButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: state is LocationDetected
                          ? () async {
                              // Capture a photo
                              final XFile? photo = await _picker.pickImage(
                                  source: ImageSource.camera);
                            }
                          : () {},
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
                          : () {},
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
                ),
                SizedBox(
                  height: 10,
                ),
                buildSnapTips(),
              ],
            ),
          );
        },
      ),
    );
  }
}
