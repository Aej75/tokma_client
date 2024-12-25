import 'package:dio/dio.dart';
import 'package:tokma_client/response/api_response.dart';
import 'package:tokma_client/response/data_node.dart';
import 'package:tokma_client/typedef/decoder.dart';

abstract class ITokmaClient {
  ///T:return type of response
  ///K:return type of decoder
  Future<ApiResponseList<T>> getList<T>(
    String path, {
    Map<String, String> headers = const {},
    required Decoder<T>? decoder,
  });
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, String> headers = const {},
    required Decoder<T>? decoder,
  });
  Future<Response<dynamic>> getRaw(String path,
      {Map<String, dynamic> headers = const {}});

  Future<ApiResponse<T>> post<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
  });

  Future<Response<dynamic>> postRaw(String path,
      {Object data = const {}, Map<String, dynamic> headers = const {}});

  Future<ApiResponse<T>> upload<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    T Function(Map<String, dynamic>)? decoder,
  });

  Future<ApiResponse<T>> delete<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
  });

  Future<ApiResponseList<T>> postAndGetList<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
  });
  Future<ApiResponse<T>> patch<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      JsonResponseNode? dataNode});

  Future<ApiResponseList<T>> patchAndGetList<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      JsonResponseNode? dataNode});
  Future<ApiResponse<T>> put<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      JsonResponseNode? dataNode});

  Future<ApiResponseList<T>> putAndGetList<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      JsonResponseNode? dataNode});

  Future<Map<String, String>> getDefaultHeaders();
}
