
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';


BaseOptions options = new BaseOptions(
  baseUrl: "https://www.huffpost.com",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

final Dio dio = Dio(options)
  ..transformer = FlutterTransformer()
  ..interceptors.addAll(<Interceptor>[
    InterceptorsWrapper(onRequest: (RequestOptions options) async {
      if (options.data is Map) {
        (options.data as Map).removeWhere((k, v) => v == null);
      }
    }),
    InterceptorsWrapper(
        onRequest: (RequestOptions options) async {},
        onResponse: (Response response) async {
          return response; // continue
        },
        onError: (error) async {
          if (error.response.statusCode == 401) {}
          return error;
        }),
    LogInterceptor(responseBody: true, error: true, requestBody: true),
  ]);
