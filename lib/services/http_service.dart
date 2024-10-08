import 'dart:io';

import 'package:caution_companion/data/models/result.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/services/storage_service.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpService{
  static String baseUrl = "https://caution-companion.onrender.com";

  static String register = "/users";
  static String login = "/users/login";
  static String getUser = "/users/me";
  static String changePassword = "/users/password";
  static String forgotPassword = "/users/forgot-password";
  static String verifyToken = "/users/reset-password/verify-token";
  static String resetPassword = "/users/reset-password";
  static String reports = "/reports";
  static String getReports = "/reports/latest";
  static String uploadfile = "/files/upload";
  
  
  static Dio _getDioClient(Map<String, dynamic>? queryParameters) {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60000),
      receiveTimeout: const Duration(seconds: 60000),
      responseType: ResponseType.json
    ))..interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        options.headers['authorization'] = "Bearer ${await serviceLocator<StorageService>().getToken("token") ?? ""}";
        options.queryParameters = queryParameters??{};
        return handler.next(options);
      }
    ))..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));
    return dio;
  }


  static Future<Result<dynamic>> post(String path, Map<String, dynamic> data, {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _getDioClient(queryParameters).post(path, data: data);
      // return AppHttpResponse(false, response.data, '');
      return Result.success(response.data);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  static Future<Result<dynamic>> get(String path, Map<String, dynamic> data, {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _getDioClient(queryParameters).get(path, data: data,);
      // return AppHttpResponse(false, response.data, '');
      return Result.success(response.data);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  static Future<Result<dynamic>> patch(String path, Map<String, dynamic> data, {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _getDioClient(queryParameters).patch(path, data: data);
      // AppHttpResponse res = AppHttpResponse(false, response.data, '');
      return Result.success(response.data);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  static Future<Result<dynamic>> put(String path, Map<String, dynamic> data,) async{
    try{
      Response response = await _getDioClient({}).put(path, data: data);
      // AppHttpResponse res = AppHttpResponse(false, response.data, '');
      return Result.success(response.data);
    } on DioException catch (e){
      return handleError(e);
    }
  }

  static Future<Result<dynamic>> delete(String path, Map<String, dynamic> data, {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _getDioClient(queryParameters).delete(path, data: data);
      // AppHttpResponse res = AppHttpResponse(false, response.data, '');
      return Result.success(response.data);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  static Future<Result<dynamic>> uploadFile(String path, File file) async{
    final formData = FormData.fromMap(
      {'file': await MultipartFile.fromFile(file.path)}
    );

    try{
      Response response = await _getDioClient({}).post(path, data: formData);
      return Result.success(response.data);
    } on DioException catch(e){
      return handleError(e);
    }
  }





  static Result handleError(DioException e) {
    dynamic data = e.response?.data;
    if (e.response != null) {
      if(e.response?.statusCode==401){
        AppRoute.go(AppRoute.login,popAll: true);
        return Result.error(CustomError(message: 'Unauthorized Access', statusCode: e.response!.statusCode));
      }
      
      else if (data != null && data is Map && data.isNotEmpty) {
        Map<String, dynamic> d = Map.from(data);
        return Result.error(CustomError(message: d['message'], statusCode: e.response!.statusCode));
      } else {
        return Result.error(CustomError(message: e.message!, statusCode: e.response!.statusCode));
      }
    } else {
      return Result.error(CustomError(message: e.message??'', statusCode: e.response!.statusCode));
    }
  }
}