import 'package:app/data/api/places_api.dart';
import 'package:app/data/models/place.dart';

class PlacesRepository {
  final PlacesAPI placesAPI;

  PlacesRepository(this.placesAPI);

  Future<List<Place>> getAllPlaces() async {
    final places = await placesAPI.getAllPlaces();
    List<Place> sortedPlaces = places.map((place) => Place.fromJson(place)).toList();
    sortedPlaces.sort((a,b) {
      return a.isAvailable == true? 0:1;
    });
    return sortedPlaces;
  }
}