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

  void getNearistPlaceToUser(
      double userLat, double userLong, List<Place> places) {
    double minDistance = double.infinity;
    Place? nearestPlace;
    for (Place place in places) {
      if (minDistance >
          Geolocator.distanceBetween(
              userLat, userLong, place.lat, place.long)) {
        minDistance = Geolocator.distanceBetween(
            userLat, userLong, place.lat, place.long);
        nearestPlace = place;
      }
    }
    if (minDistance < nearestPlace!.range ) {
      emit(LocationDetected(nearestPlace.name,nearestPlace.arabicName, nearestPlace.id));
    } else {
      emit(LocationNotDetected("too far"));
    }
  }

  void setPlace(String placeName, List<Place> places) {
    if (placeName != "") {
      Place place = places.singleWhere((place) => place.name == placeName);
      emit(LocationDetected(place.name,place.arabicName,place.id));
    } else {
      emit(LocationNotDetected("choose place"));
    }
  }

  void clearLocation() {
    emit(LocationInitial());
  }
}
