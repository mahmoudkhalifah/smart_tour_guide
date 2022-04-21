class Statue {
  late int id;
  late String name;
  late String description;
  late List<dynamic> images;
  late String voiceOver;

  Statue.fromJson(Map<String,dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    images = json["images"];
    voiceOver = json["voice_over"];
  }
}