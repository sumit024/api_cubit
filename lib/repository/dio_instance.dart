import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
class DioInstance{

  DioInstance._internal();

  static DioInstance _dioInstance = DioInstance._internal();
  factory DioInstance(){
    return _dioInstance;
  }
  final Dio dio=_getDioInstance();

  static Dio _getDioInstance(){
    var dio= Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
    ));
    dio.interceptors.add(PrettyDioLogger());
    return dio;
  }
}