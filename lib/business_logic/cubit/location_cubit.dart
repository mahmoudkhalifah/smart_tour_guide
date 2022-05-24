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
    LocationPermission per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied ||
        per == LocationPermission.deniedForever) {
      print("permission denied");
      LocationPermission per1 = await Geolocator.requestPermission();
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      emit(LocationLoaded(lat:currentLoc.latitude, long:currentLoc.longitude));
    } else {
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      emit(LocationLoaded(lat:currentLoc.latitude, long:currentLoc.longitude));
    }
  }

  void getNearistPlaceToUser(double userLat,double userLong,List<Place> places) {
    double minDistance = double.infinity;
    late String placeName;
    for (Place place in places) {
      if (minDistance  > Geolocator.distanceBetween(userLat, userLong, place.lat, place.long)) {
        minDistance = Geolocator.distanceBetween(userLat, userLong, place.lat, place.long);
        placeName = place.name;
      }
    }
    if (minDistance < 500) {
      emit(LocationDetected(placeName));
    }
    else {
      emit(LocationNotDetected("can't get the place"));
    }
    
  }

  void setPlace(String placeName) {
    emit(LocationDetected(placeName));
  }

  void clearLocation() {
    emit(LocationInitial());
  }

}
