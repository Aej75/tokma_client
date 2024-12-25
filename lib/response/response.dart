import 'dart:core';

import 'package:dio/dio.dart';
import 'package:tokma_client/config/fetch_config.dart';
import 'package:tokma_client/response/data_node.dart';

import '../typedef/decoder.dart';

class HttpResponse<T, K> {
  T? data;
  int? statusCode;
  String? message;
  bool success;
  dynamic rawBody;

  HttpResponse({
    this.data,
    this.statusCode,
    this.message,
    required this.success,
    required this.rawBody,
  });
  factory HttpResponse.fromDioResponse(Response response, Decoder<K>? decoder,
      JsonResponseNode? node, final TokmaClientConfig globalFetchConfig,
      {List<int> validStatusCodes = const [200, 201, 204, 304]}) {
    ///check if there is modification from local request else check from global fetch config for root node modifications
    final rootNode =
        node != null ? node.nodeName : globalFetchConfig.dataNode.nodeName;
    final successNode = globalFetchConfig.successNode.nodeName;
    final json = response.data;
    T? data;
    final ok = successNode != null
        ? (json[successNode].toString().toLowerCase() == 'true' ||
            json[successNode].toString().toLowerCase() == 'ok' ||
            json[successNode].toString().toLowerCase() == 'success')
        : validStatusCodes.contains(response.statusCode);
    final payloadData = rootNode == null ? json : json[rootNode];
    if (ok && payloadData != null && decoder != null) {
      if (T == List<K>) {
        data = (payloadData as List).map((e) => decoder(e)).toList() as T;
      } else {
        data = decoder(payloadData) as T;
        if (payloadData != null && payloadData is List) {
          data = payloadData.first as T;
        } else {
          data = decoder(payloadData as Map<String, dynamic>) as T;
        }
      }
    }
    if (decoder == null) {
      data = payloadData;
    }

    return HttpResponse<T, K>(
        data: data,
        statusCode: response.statusCode,
        message: errorMessageDecoder(json),
        rawBody: json,
        success: ok);
  }
}

String? errorMessageDecoder(Map<String, dynamic> json) {
  final message = json['message'];
  final ok = json['ok'] as bool? ?? false;
  if (message is String) {
    return message;
  } else if (message is List) {
    return message
        .map((e) => e is Map<String, dynamic> ? e['message'] : e)
        .join(",");
  }
  return ok ? null : 'something went wrong ';
}

class APIResponseList<T> extends HttpResponse<List<T>, T> {
  APIResponseList(
      {super.data,
      super.message,
      super.statusCode,
      super.rawBody,
      required super.success});
  factory APIResponseList.fromDioResponse(
      Response response,
      Decoder<T>? decoder,
      JsonResponseNode? node,
      final TokmaClientConfig globalFetchConfig,
      {List<int> validStatusCodes = const [200, 201, 204, 304]}) {
    final json = response.data;
    final baseData = HttpResponse<List<T>, T>.fromDioResponse(
        response, decoder, node, globalFetchConfig,
        validStatusCodes: validStatusCodes);

    return APIResponseList<T>(
        data: baseData.data,
        message: baseData.message,
        rawBody: json,
        statusCode: baseData.statusCode,
        success: baseData.success);
  }
}

class APIResponse<T> extends HttpResponse<T, T> {
  APIResponse({
    super.data,
    super.message,
    super.statusCode,
    super.rawBody,
    required super.success,
  });

  //from dio response
  factory APIResponse.fromDioResponse(Response response, Decoder<T>? decoder,
      JsonResponseNode? node, final TokmaClientConfig globalFetchConfig,
      {List<int> validStatusCodes = const [200, 201, 204, 304]}) {
    final baseData = HttpResponse<T, T>.fromDioResponse(
        response, decoder, node, globalFetchConfig,
        validStatusCodes: validStatusCodes);
    final json = response.data;

    return APIResponse(
        data: baseData.data,
        message: baseData.message,
        statusCode: baseData.statusCode,
        rawBody: json,
        success: baseData.success);
  }
}
