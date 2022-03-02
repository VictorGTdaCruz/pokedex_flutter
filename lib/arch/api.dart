import 'package:dio/dio.dart';

late Api api;

class Api {
  late Dio dio;

  Api.configure(String baseUrl) {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }
}