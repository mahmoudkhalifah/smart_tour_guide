import 'package:app/strings.dart';
import 'package:dio/dio.dart';

class PlacesAPI {


  late Dio dio;

  PlacesAPI() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
    dio.options.headers["Authorization"] = "Token fe17fa90bc66b10e2ca10ee4da8e7bde1080f671";
  }

  //TODO language change
  Future<List<dynamic>> getAllPlaces() async {
    try {
      Response response = await dio.get("en/places/");
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }
}