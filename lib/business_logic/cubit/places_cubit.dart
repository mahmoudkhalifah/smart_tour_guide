import 'package:app/data/models/place.dart';
import 'package:app/data/models/statue.dart';
import 'package:app/data/repository/places_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {

  final PlacesRepository placesRepository;

  PlacesCubit(this.placesRepository) : super(PlacesInitial());

  void navigateTo(double lat, double long) async {
    //var uri = Uri.parse("google.navigation:q=$lat,$long&mode=d");
    var uri = Uri.parse("geo:$lat,$long?z=18");
    //https://www.google.com/maps/search/?api=1&query=
    try {
      await launchUrl(uri);
    } catch (e) {
      print(e);
    }
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri);
    // } else {
    //   throw 'Could not launch ${uri.toString()}';
    // }
  }
  
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
