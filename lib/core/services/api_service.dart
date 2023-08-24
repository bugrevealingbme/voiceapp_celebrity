import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio();
  }

  Future<Map<String, String>> apiHeader({String? anotherToken}) async {
    return {'package': 'net.metareverse.voiceapp'};
  }

  Future<Response?> sendGetRequest({
    required String endPoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    bool? disableLog,
  }) async {
    if (kDebugMode && disableLog != true) {
      //${headers.toString()}
      log("<<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>");
      log("Endpoint: $endPoint,\n headers: null koydum, queryParameters: ${queryParameters.toString()}");
      log("<<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>");
    }
    try {
      Response response = await dio.get(endPoint,
          queryParameters: queryParameters,
          options: Options(headers: headers, contentType: 'application/json'));

      if (kDebugMode) {
        //response: ${response.data}
        log("Endpoint $endPoint, statusCode: ${response.statusCode}");
      }
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        String? message = '';
        message = e.response?.statusCode == HttpStatus.notFound ||
                e.response?.statusCode == HttpStatus.unauthorized ||
                e.response?.statusCode == HttpStatus.internalServerError
            ? 'not_found'
            : e.response?.data['message'];
        log("DioError: Endpoint $endPoint, response: $message}, statusCode: ${e.response?.statusCode}");
        log("<<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>");
      }
      return e.response;
    }
  }

  Future<Response?> sendPostRequest({
    required String endPoint,
    required Map<String, dynamic>? postData,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    bool? disableLog,
  }) async {
    if (kDebugMode && disableLog != true) {
      log("<<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>");
      log(
        "Endpoint: $endPoint,\n postData: ${postData.toString()},\n headers: null koydum, queryParameters: ${queryParameters.toString()}",
      );
      log("<<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>");
    }
    try {
      final postEncData = json.encode(postData);

      Response response = await dio.post(
        endPoint,
        data: json.encode({
          'action': postEncData,
          'timestamp': (DateTime.now().millisecondsSinceEpoch / 1000).round()
        }),
        queryParameters: queryParameters,
        options: Options(headers: headers, contentType: 'application/json'),
      );

      if (kDebugMode) {
        //response: ${response.data}
        log(
          "Endpoint $endPoint, statusCode: ${response.statusCode}",
        );
      }
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        String? message = '';
        message = e.response?.statusCode == HttpStatus.notFound ||
                e.response?.statusCode == HttpStatus.unauthorized ||
                e.response?.statusCode == HttpStatus.internalServerError
            ? 'not_found'
            : e.response?.data != null
                ? e.response?.data['message']
                : e.response?.data;
        log("Endpoint $endPoint, response: $message}, statusCode: ${e.response?.statusCode}");
        log("<<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>");
      }
      return e.response;
    }
  }

  Future<Response?> sendPostFormDataRequest({
    required String endPoint,
    required FormData? postData,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Function(int count, int total)? onSendProgress,
  }) async {
    if (kDebugMode) {
      //{headers.toString()}
      log("<<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>");
      log(
        "Endpoint: $endPoint,\n postData: ${postData.toString()},\n headers: null koydum, queryParameters: ${queryParameters.toString()}",
      );
      log("<<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>");
    }

    try {
      Response response = await dio.post(
        endPoint,
        data: postData,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          contentType: 'application/json',
        ),
        onSendProgress: onSendProgress,
      );

      if (kDebugMode) {
        log(
          "Endpoint $endPoint, response: ${response.data}, statusCode: ${response.statusCode}",
        );
      }
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        String? message = '';
        message = e.response?.statusCode == HttpStatus.notFound ||
                e.response?.statusCode == HttpStatus.unauthorized ||
                e.response?.statusCode == HttpStatus.internalServerError
            ? 'not_found'
            : e.response?.data;
        log("Endpoint $endPoint, response: $message}, statusCode: ${e.response?.statusCode}");
        log("<<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>");
      }
      return e.response;
    }
  }
}
