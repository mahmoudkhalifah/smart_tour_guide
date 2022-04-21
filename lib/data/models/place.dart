import 'package:app/data/models/statue.dart';

class Place {
  late int id;
  late String name;
  late String description;
  late bool isAvailable;
  late List<dynamic> images;
  
  Place.fromJson(Map<String,dynamic> json) {
    id = json["id"];
    name = json["name"];
    isAvailable = json["is_available"];
    description = json["description"];
    images = json["images"];
  }
}