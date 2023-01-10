import 'package:dio/dio.dart';

class NetworkClient {
  static NetworkClient? _instance;
  static NetworkClient? get instance {
    _instance ??= NetworkClient._init();
    return _instance;
  }

  late Dio dio;
  NetworkClient._init() {
    dio = Dio();
  }
}
