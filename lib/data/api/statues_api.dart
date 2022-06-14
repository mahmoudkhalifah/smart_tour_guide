import 'dart:convert';

import 'package:app/data/models/statue.dart';
import 'package:app/strings.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';


class StatuesAPI {
  late Dio dio;

  StatuesAPI() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 60 * 1000,
    );

    dio = Dio(options);
    dio.options.headers["Authorization"] =
        "Token fe17fa90bc66b10e2ca10ee4da8e7bde1080f671";
  }

  Future<List<dynamic>> getStatues(int placeId) async {
    try {
      Response response = await dio.get("statues/place=$placeId");
      return response.data;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<dynamic>> getStatueInfoByPhoto(XFile image, int placeId) async {
    try {
      String imageName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image":
            await MultipartFile.fromFile(image.path, filename:imageName),
      });
      Response response = await dio.post("predict/place=$placeId",data: formData);
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
