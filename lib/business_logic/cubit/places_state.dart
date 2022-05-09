// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'places_cubit.dart';

@immutable
abstract class PlacesState {}

class PlacesInitial extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<Place> places;
  PlacesLoaded(this.places);
}

class StatuesLoaded extends PlacesState {
  final List<Statue> statues;
  StatuesLoaded(this.statues);
}


