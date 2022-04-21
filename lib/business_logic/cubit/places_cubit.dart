import 'package:app/data/models/place.dart';
import 'package:app/data/models/statue.dart';
import 'package:app/data/repository/places_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {

  final PlacesRepository placesRepository;

  PlacesCubit(this.placesRepository) : super(PlacesInitial());

  

  void getAllPlaces() {
    placesRepository.getAllPlaces().then((places) {
      emit(PlacesLoaded(places));
    });
  }
  
  void getStatues(int placeId) {
    placesRepository.getStatues(placeId).then((statues) {
      emit(StatuesLoaded(statues));
    });
  }

}
