import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import '../app.dart';
import '../models/api_resp.dart';
import '../presets/api_paths.dart';

ApiResp respNew = ApiResp(
  ok: false,
  rdata: null,
  msgs: [],
  message: '',
);

class MyDio {
  static String baseUrl = ApiPaths.baseUrl;

  late Dio _dio;

  MyDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 500,
      // 30 seconds
      receiveTimeout: 60 * 1000,
      // 60 seconds

      responseType: ResponseType.plain,
      headers: {
        Headers.contentTypeHeader: "application/json",
      },
    );

    _dio = Dio(options);

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response resp = await _dio.get(path,
          queryParameters: queryParameters,
          options: Options(responseType: ResponseType.plain, headers: {
            Headers.contentTypeHeader: "application/json",
          }));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp;
      if (resp.data.toString().isNotEmpty) {
        apiResp = jsonDecode(resp.data);
      }
      return apiResp;
    } on DioError catch (e) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
      debugPrint("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(e.requestOptions.queryParameters.toString());

      if (e.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      debugPrint("************** Error End ************************");
      if (e.type == DioErrorType.response) {
        // ignore: avoid_print
        print(path);
        throw Exception('No proper response from server');
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioErrorType.other) {
        throw Exception('Something went wrong with server communication');
      }
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<dynamic> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceivedProgress,
  }) async {
    try {
      Response resp = await _dio.put(baseUrl + path,
          data: data,
          options: Options(responseType: ResponseType.plain, headers: {
            Headers.contentTypeHeader: "application/json",
          }));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp;
      if (resp.data.toString().isNotEmpty) {
        apiResp = jsonDecode(resp.data);
      }
      return apiResp;
    } on DioError catch (e) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
      debugPrint("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(e.requestOptions.queryParameters.toString());

      if (e.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      debugPrint("************** Error End ************************");
      if (e.type == DioErrorType.response) {
        throw Exception('No proper response from server');
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioErrorType.other) {
        throw Exception('Something went wrong with server communication');
      }
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
