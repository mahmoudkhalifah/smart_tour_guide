import 'dart:convert';

import 'package:flutter/services.dart';

class PlacesAPI {
  //todo add dio and get form API not local json file


  Future<List<dynamic>> getAllPlaces() async {
    //todo get from API not local using dio
    try {
      print("getAllPlaces");
      String jsonString = await rootBundle.loadString("assets/data/places.json");
      print(json.decode(jsonString));
      return json.decode(jsonString);
    } catch (e) {
      print(e);
      return [];
    }
    //todo now
  }

  Future<List<dynamic>> getStatues(int placeId) async {
    //todo get from API not local using dio
    //todo must provide place id to the API
    try {
      String jsonString = await rootBundle.loadString("assets/data/statues.json");
      print(json.decode(jsonString));
      return json.decode(jsonString);
    } catch (e) {
      print(e);
    }
    return [];
    //todo now
  }

}