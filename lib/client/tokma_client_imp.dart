import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:tokma_client/client/i_tokma_client.dart';
import 'package:tokma_client/config/fetch_config.dart';
import 'package:tokma_client/response/api_response.dart';
import 'package:tokma_client/response/data_node.dart';
import 'package:tokma_client/typedef/decoder.dart';

class TokmaClient extends TokmaClientImpl {
  TokmaClient(TokmaClientConfig config) : super(config);
}

class TokmaClientImpl implements ITokmaClient {
  final TokmaClientConfig config;

  TokmaClientImpl(this.config);

  @override
  Future<ApiResponse<T>> delete<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<T>> get<T>(String path,
      {Map<String, String> headers = const {}, required Decoder<T>? decoder}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String>> getDefaultHeaders() async {
    final token = await config.token;
    return {
      'Authorization': token != null ? '${config.tokenPrefix}$token' : '',
    };
  }

  @override
  Future<ApiResponseList<T>> getList<T>(String path,
      {Map<String, String> headers = const {}, required Decoder<T>? decoder}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<Response<dynamic>> getRaw(String path,
      {Map<String, dynamic> headers = const {}}) async {
    final dio = await instance;
    final response = await dio.get(
      path,
      options: Options(headers: headers),
    );
    return response;
  }

  @override
  Future<ApiResponse<T>> patch<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      JsonResponseNode? dataNode}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseList<T>> patchAndGetList<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      JsonResponseNode? dataNode}) {
    // TODO: implement patchAndGetList
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<T>> post<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseList<T>> postAndGetList<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder}) {
    // TODO: implement postAndGetList
    throw UnimplementedError();
  }

  @override
  Future<Response> postRaw(String path,
      {Object data = const {}, Map<String, dynamic> headers = const {}}) {
    // TODO: implement postRaw
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<T>> put<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      JsonResponseNode? dataNode}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseList<T>> putAndGetList<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      JsonResponseNode? dataNode}) {
    // TODO: implement putAndGetList
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<T>> upload<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      T Function(Map<String, dynamic> p1)? decoder}) {
    // TODO: implement upload
    throw UnimplementedError();
  }

  Future<Dio> get instance async {
    return Dio(
      BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: Duration(milliseconds: config.connectTimeout),
          receiveTimeout: Duration(milliseconds: config.receiveTimeout),
          validateStatus: (d) => true,
          headers: await getDefaultHeaders()),
    )..interceptors.addAll([
        // LogInterceptor(
        //     requestBody: true, responseBody: true, responseHeader: false),
        RequestBodyIntercepter(),
        PrettyDioLogger(
            requestHeader: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90),
        ...config.interceptors,
        cacheIntercepter(),
      ]);
  }
}
