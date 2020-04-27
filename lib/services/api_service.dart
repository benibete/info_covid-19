import 'dart:async';

import 'package:covid/main.dart';
import 'package:covid/model/api_response_model.dart';
import 'package:covid/model/post_type.dart';
import 'package:covid/services/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../ui/app.dart';

enum _RequestType { post, get, put, patch, delete }

/// Main APIService
///
/// This will create a singleton instance
///
class APIService {
  static const String _tag = '.APIService';
  static APIService _apiService = APIService._();
  static Dio _client;
  static bool _initialized = false;
  static APIService get api => _apiService;

  static AbstractApi _configApi;

  APIService._();

  @visibleForTesting
  set setMockInstance(APIService instance) => _apiService = instance;

  void init([Dio client, AbstractApi api]) async {
    if (!_initialized) {
      _configApi =
          api ?? (appConfig == AppConfig.dev ? DevApi() : ProductionApi());

      _client = client ?? Dio();
      _client.options.baseUrl = _configApi.build();
      _client.options.connectTimeout = 5000;
      _initialized = true;
    }
  }

  Future<APIResponse> _performRequest(
    _RequestType type,
    String resource, {
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParams,
    Map<String, dynamic> body,
  }) async {
    if (!_initialized) {
      init();
    }

    Response response;

    logger.i(
        '[$_tag] Requesting:  $resource | QueryParams: $queryParams | Body: $body | Method: ${describeEnum(type)}');

    if (headers != null) {
      _client.options.headers.addAll(headers);
    }

    queryParams?.removeWhere((k, v) => v == null);

    try {
      switch (type) {
        case _RequestType.post:
          response = await _client.post(resource,
              queryParameters: queryParams, data: body);
          break;
        case _RequestType.put:
          response = await _client.put(resource,
              queryParameters: queryParams, data: body);
          break;
        case _RequestType.get:
          response = await _client.get(resource, queryParameters: queryParams);
          break;
        case _RequestType.patch:
          response = await _client.patch(resource,
              queryParameters: queryParams, data: body);
          break;
        case _RequestType.delete:
          response = await _client.delete(resource,
              queryParameters: queryParams, data: body);
          break;
      }

      return APIResponse(
        response?.data,
        response?.statusCode,
        headers: response?.headers,
      );
    } on DioError catch (e) {
      logger.e(
          '[$_tag] Request error:  ${e.error} | Status Code: ${e.response?.statusCode} | Response: ${e.response} | Request: ${e.request?.uri} | Type: ${e.type} | Headers:${e.response?.headers?.map}');
      return APIResponse(
        e.response?.data,
        e.response?.statusCode,
        headers: e.response?.headers,
        dioErrorType: e?.type,
      );
    }
  }

  /// Gets the updated case stats
  Future<APIResponse> getStats() async {
    return await _performRequest(
      _RequestType.get,
      '/stats',
    );
  }

  /// Gets the posts accordingly by [postType]
  Future<APIResponse> getPosts<T>(PostType postType, {int id}) async {
    Map<String, int> queryParams;
    if (id != null) {
      queryParams = {"categories": id};
    }
    return await _performRequest(
      _RequestType.get,
      postType.getRequestType(),
      queryParams: queryParams,
    );
  }
}
