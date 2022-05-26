import 'dart:math';

import 'package:app/data/models/place.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  late List<Place> places;

  void getlocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(LocationPermissionDenied(
            "no permissions"));
      } else {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          emit(LocationServiceDisabled("GPS off"));
        } else {
          Position currentLoc = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best);
          emit(LocationLoaded(
              lat: currentLoc.latitude, long: currentLoc.longitude));
        }
      }
    } else {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationServiceDisabled("GPS off"));
      } else {
        Position currentLoc = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        emit(LocationLoaded(
            lat: currentLoc.latitude, long: currentLoc.longitude));
      }
    }
  }

  void openAppSettings() {
    Geolocator.openAppSettings();
  }

  void openLocationSettings() {
    Geolocator.openLocationSettings();
  }

  // void getlocation() async {
  //   LocationPermission per = await Geolocator.checkPermission();
  //   bool serviceEnabled;
  //   if (per == LocationPermission.denied ||
  //       per == LocationPermission.deniedForever) {
  //     print("permission denied");
  //     LocationPermission per1 = await Geolocator.requestPermission();
  //     if (!(per1 == LocationPermission.denied ||
  //         per1 == LocationPermission.deniedForever)) {
  //       Position currentLoc = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best);
  //       serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //       if (serviceEnabled) {
  //         Position currentLoc = await Geolocator.getCurrentPosition(
  //             desiredAccuracy: LocationAccuracy.best);
  //         emit(LocationLoaded(
  //             lat: currentLoc.latitude, long: currentLoc.longitude));
  //       } else {
  //         emit(LocationNotDetected("Please open GPS or choose yourself"));
  //       }
  //     } else {
  //       emit(LocationNotDetected("No location permission!Please choose place"));
  //     }
  //   } else {
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     Position currentLoc = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.best);
  //     if (serviceEnabled) {
  //       emit(LocationLoaded(
  //           lat: currentLoc.latitude, long: currentLoc.longitude));
  //     } else {
  //       emit(LocationNotDetected("Please open GPS or choose yourself"));
  //     }
  //   }
  // }

  void getNearistPlaceToUser(
      double userLat, double userLong, List<Place> places) {
    double minDistance = double.infinity;
    late String placeName;
    late int placeId;
    for (Place place in places) {
      if (minDistance >
          Geolocator.distanceBetween(
              userLat, userLong, place.lat, place.long)) {
        minDistance = Geolocator.distanceBetween(
            userLat, userLong, place.lat, place.long);
        placeName = place.name;
        placeId = place.id;
      }
    }
    //TODO 500m or be put specific range for every place
    if (minDistance < 1500) {
      emit(LocationDetected(placeName, placeId));
    } else {
      emit(LocationNotDetected("too far"));
    }
  }

  void setPlace(String placeName, List<Place> places) {
    if (placeName != "") {
      int placeId = places.singleWhere((place) => place.name == placeName).id;
      print(placeId);
      emit(LocationDetected(placeName, placeId));
    } else {
      emit(LocationNotDetected("choose place"));
    }
  }

  void clearLocation() {
    emit(LocationInitial());
  }
}
