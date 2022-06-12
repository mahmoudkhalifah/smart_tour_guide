import 'package:app/data/api/statues_api.dart';
import 'package:app/data/models/statue.dart';
import 'package:image_picker/image_picker.dart';

class StatuesRepository {
  final StatuesAPI statuesAPI;

  StatuesRepository(this.statuesAPI);

  Future<List<Statue>> getStatues(int placeId) async {
    final statues = await statuesAPI.getStatues(placeId);
    return statues.map((statue) => Statue.fromJson(statue)).toList();
  }

  Future<Statue?> getStatueInfoByPhoto(XFile image, int placeId) async {
    final statues = await statuesAPI.getStatueInfoByPhoto(image,placeId);
    if (statues.isNotEmpty) {
      return statues.map((statue) => Statue.fromJson(statue)).toList().first;
    }
    return null;
  }
}