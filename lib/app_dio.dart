import 'package:dio/dio.dart';


class AppDio {
  static late Dio _dio;
  static void init() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: "https://newsapi.org/v2/top-headlines",
      connectTimeout: const Duration(seconds: 20),
    );
    _dio = Dio(baseOptions);
  }

  static Future get({
    required String category,
  }) {
    return _dio.get("", queryParameters: {
      "country": "us",
      "category": category,
      "apiKey": "2ed58f61455141cf8f8e60b3582dc5fb",
    });
  }
}
