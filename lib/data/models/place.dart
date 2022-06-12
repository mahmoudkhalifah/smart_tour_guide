import 'package:url_launcher/url_launcher.dart';

class Place {
  late int id;
  late String name;
  late String description;
  late bool isAvailable;
  late List<dynamic> images;
  late double lat;
  late double long;
  late int range;
  
  Place.fromJson(Map<String,dynamic> json) {
    id = json["id"];
    name = json["name"];
    isAvailable = json["is_available"];
    description = json["description"];
    images = json["images"];
    lat = json["lat"];
    long = json["lon"];
    range = json["range"];
  }
  
    void openLocation(double lat, double long) async {
    var uri = Uri.parse("geo:$lat,$long?z=18");
    try {
      await launchUrl(uri);
    } catch (e) {
      print(e);
    }
  }
}