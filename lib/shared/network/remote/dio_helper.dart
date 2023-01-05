import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {'Content-Type': 'application/json', 'lang': 'en'}),
    );
  }

  static Future<Response>? getData({
    @required url,
    Map<String, dynamic>? query,
    String? lang = 'ar',
    String? authorization,
  }) async {
    dio!.options.headers = {'lang': lang, 'Authorization': authorization};
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response>? postData({
    @required String? url,
    Map<String, dynamic>? query,
    @required Map<String, dynamic>? data,
    String? lang = 'ar',
    String? authorization,
  }) async {
    dio!.options.headers = {'lang': lang, 'Authorization': authorization};
    return await dio!.post(url!, data: data);
  }
}
