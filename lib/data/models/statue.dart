class Statue {
  late int id;
  late String name;
  late String description;
  late String arabicName;
  late String arabicDescription;
  late List<dynamic> images;
  late String voiceOver;
  late String arabicVoiceOver;

  Statue.fromJson(Map<String,dynamic> json) {
    id = json["id"];
    name = json["display_name"];
    description = json["description"];
    arabicName = json["display_name_arabic"];
    arabicDescription = json["description_arabic"];
    images = json["images"];
    voiceOver = json["voice_over"];
    arabicVoiceOver = json["voice_over_arabic"];
  }
}