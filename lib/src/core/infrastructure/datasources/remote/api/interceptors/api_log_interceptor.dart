import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../common/utils/logger.dart';

class ApiLogInterceptor extends InterceptorsWrapper {
  final jsonEncoder = const JsonEncoder.withIndent('  ');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final method = options.method;
    logger.i('$method  ${options.uri}');
    logger.i('Headers: ${jsonEncoder.convert(options.headers)}');
    final data = options.data;
    if (data is FormData) {
      logger.i('Data: ${jsonEncoder.convert(
        data.fields.fold(<String, dynamic>{}, (previousValue, element) {
          (previousValue as Map)[element.key] = element.value;
          return previousValue;
        }),
      )}\n');
    } else {
      try {
        final json = jsonEncoder.convert(data);
        logger.i('Data: $json\n');
      } catch (error) {
        logger.i('Data: ${data.toString()}\n');
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.w(
        '''${response.requestOptions.method.toUpperCase()} ${response.requestOptions.uri} - ${response.statusCode}''');
    final json = jsonEncoder.convert(response.data);
    logger.w(
        """Response: ${(json.length > 2500) ? "${json.substring(0, 2500)}..." : json}\n""");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
        '''${err.requestOptions.method.toUpperCase()} ${err.requestOptions.uri} - ${err.response?.statusCode}''');
    logger.e('Error: ${err.error}');
    final json = jsonEncoder.convert(err.response?.data);
    logger.e(
        """Response: ${(json.length > 2500) ? "${json.substring(0, 2500)}..." : json}\n""");
    return super.onError(err, handler);
  }
}
