import 'package:app/data/api/places_api.dart';
import 'package:app/data/models/place.dart';
import 'package:app/data/models/statue.dart';

class PlacesRepository {
  final PlacesAPI placesAPI;

  PlacesRepository(this.placesAPI);

  Future<List<Place>> getAllPlaces() async {
    final places = await placesAPI.getAllPlaces();
    return places.map((place) => Place.fromJson(place)).toList();
  }

  Future<List<Statue>> getStatues(int placeId) async {
    final statues = await placesAPI.getStatues(placeId);
    return statues.map((statue) => Statue.fromJson(statue)).toList();
  }
}