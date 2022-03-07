import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

late Api api;

class Api {
  late Dio dio;

  Api.configure(String baseUrl) {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
// customization
//     dio.interceptors.add(PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         responseHeader: false,
//         error: true,
//         compact: true,
//         maxWidth: 90));
  }
}