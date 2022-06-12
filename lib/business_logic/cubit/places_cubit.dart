import 'package:app/data/models/place.dart';
import 'package:app/data/repository/places_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {

  final PlacesRepository placesRepository;

  PlacesCubit(this.placesRepository) : super(PlacesInitial());
  
  Future<List<Place>> getAllPlaces() {
    return placesRepository.getAllPlaces().then((places) {
      if (places.isNotEmpty) {
        emit(PlacesLoaded(places));
      }
      else {
        emit(PlacesError());
      }
      return places;
    });
  }

}
