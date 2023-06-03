import 'package:dio/dio.dart';
import 'package:equatable_pagination/src/service/get_it.dart';
import 'package:flutter/material.dart';

class HttpQuery {
  /* ---------------------------------- HttpQuery ---------------------------------- */

  Future<dynamic> get(
      {required String url, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headerData}) async {
    try {
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
      };

      Map<String, dynamic> tempQueryParameters = queryParameters ?? {};
      if (headerData != null) header.addAll(headerData);
      final Response result = await getIt<Dio>().get(
        url,
        options: Options(
          sendTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 60000),
          headers: header,
        ),
        queryParameters: tempQueryParameters,
      );
      return result.data;
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectionTimeout) {
        debugPrint(error.type.name);
      }
      if (error.type == DioErrorType.receiveTimeout) {
        debugPrint(error.type.name);
      }
      return error;
    }
  }

  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headerData,
  }) async {
    Map<String, dynamic> header = {
      "Content-Type": "application/json",
    };
    Map<String, dynamic> tempQueryParameters = queryParameters ?? {};

    if (headerData != null) header.addAll(headerData);

    final Response result = await getIt<Dio>().post(
      url,
      options: Options(
        method: 'POST',
        sendTimeout: const Duration(milliseconds: 120000),
        receiveTimeout: const Duration(milliseconds: 120000),
        headers: header,
      ),
      queryParameters: tempQueryParameters,
      data: data,
    );
    return result.data;
  }

  Future<dynamic> patch({
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headerData,
  }) async {
    Map<String, dynamic> header = {
      "Content-Type": "application/json",
    };
    Map<String, dynamic> tempQueryParameters = queryParameters ?? {};

    if (headerData != null) header.addAll(headerData);

    final Response result = await getIt<Dio>().patch(
      url,
      options: Options(
        method: 'PATCH',
        sendTimeout: const Duration(milliseconds: 120000),
        receiveTimeout: const Duration(milliseconds: 120000),
        headers: header,
      ),
      queryParameters: tempQueryParameters,
      data: data,
    );
    return result.data;
  }

  Future<dynamic> put({
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headerData,
  }) async {
    Map<String, dynamic> header = {
      "Content-Type": "application/json",
    };

    if (headerData != null) header.addAll(headerData);
    Map<String, dynamic> tempQueryParameters = queryParameters ?? {};
    final Response result = await getIt<Dio>().put(
      url,
      options: Options(
        sendTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 120000),
        headers: header,
      ),
      queryParameters: tempQueryParameters,
      data: data,
    );
    return result.data;
  }

  Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headerData,
  }) async {
    Map<String, dynamic> header = {
      "Content-Type": "application/json",
    };
    Map<String, dynamic> tempQueryParameters = queryParameters ?? {};

    if (headerData != null) header.addAll(headerData);
    final Response result = await getIt<Dio>().delete(
      url,
      options: Options(
        headers: header,
      ),
      queryParameters: tempQueryParameters,
      data: data,
    );
    return result.data;
  }
}
