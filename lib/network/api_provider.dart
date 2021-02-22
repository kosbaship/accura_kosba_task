import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class APIProvider{
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com/",
    ),
  );

   static Future<Response> fetchData({@required String path, Map<String, dynamic> queryParameters}) async {
    return await dio.get(path);
  }
}
