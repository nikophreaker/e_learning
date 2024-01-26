import 'package:dio/dio.dart';

class DioManager {
  static DioManager? _instance;

  static DioManager get instance {
    if (_instance != null) return _instance!;
    _instance = DioManager._init();
    return _instance!;
  }

  final String _baseUrl = 'https://api.kontenbase.com/query/api/v1/2810aabc-9dc5-4d37-8ff1-fd579e9d6f0c/';
  late final Dio dio;

  DioManager._init() {
    dio = Dio(
      BaseOptions(
        validateStatus: (_) => true,
        baseUrl: _baseUrl,
        followRedirects: true,
        contentType: Headers.jsonContentType,
        responseType:ResponseType.json,
      ),
    );
  }


  // Dio get dio => _dio();
  // Dio _dio() {
  //   final options = BaseOptions(
  //     baseUrl: "https://api.kontenbase.com/query/api/v1/2810aabc-9dc5-4d37-8ff1-fd579e9d6f0c/",
  //     connectTimeout: Duration(milliseconds: 5000),
  //     receiveTimeout: Duration(milliseconds: 3000),
  //     contentType: "application/json;charset=utf-8",
  //   );
  //
  //   var dio = Dio(options);
  //
  //   // dio.interceptors.add(LoggingInterceptors());
  //
  //   return dio;
  // }
}