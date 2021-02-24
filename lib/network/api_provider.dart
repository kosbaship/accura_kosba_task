import 'dart:io';

import 'package:accura_kosba_task/shared/end_points.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class APIProvider{
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
    ),

  );

   static Future<Response> fetchData({@required String path, data}) async {

     (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
         (HttpClient client) {
       client.badCertificateCallback =
           (X509Certificate cert, String host, int port) => true;
       return client;
     };

     try {
       return await dio.post(path, data: data);
     } catch (e) {
       print('\n=========================================================');
       print(e);
       print('=========================================================\n\n');
       return(e);
     }

  }
}
