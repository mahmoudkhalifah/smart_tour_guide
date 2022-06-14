part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoaded extends LocationState {
  final double lat;
  final double long;

  LocationLoaded({required this.lat, required this.long});
}

class LocationServiceDisabled extends LocationState {
  final String errorMessage;

  LocationServiceDisabled(this.errorMessage);
}

class LocationPermissionDenied extends LocationState {
  final String errorMessage;

  LocationPermissionDenied(this.errorMessage);
}

class LocationDetected extends LocationState {
  final String placeName;
  final String arabicPlaceName;
  final int placeId;
  LocationDetected(this.placeName,this.arabicPlaceName,this.placeId);
}

class LocationNotDetected extends LocationState {
  final String errorMessage;

  LocationNotDetected(this.errorMessage);
}