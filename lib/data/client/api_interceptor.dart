import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(<String, dynamic>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
    });
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    log(err.toString());
    // switch (err.type) {
    //   case DioErrorType.cancel:
    //     err.error = 'リクエストがキャンセルされました。';
    //     break;
    //   case DioErrorType.receiveTimeout:
    //   case DioErrorType.connectTimeout:
    //   case DioErrorType.sendTimeout:
    //     err.error = 'タイムアウトしました。通信環境が良い場所で再度お試しください。';
    //     break;
    //   case DioErrorType.other:
    //     if (err.error is SocketException) {
    //       err.error = 'ネットワークに接続できませんでした。通信環境が良い場所で再度お試しください。';
    //     } else {
    //       err.error = '予期せぬエラーが発生しました。しばらくしてから再度お試しください。';
    //     }
    //     break;
    //   case DioErrorType.response:
    //     if ([500, 501, 502, 503, 504, 505, 506, 507, 508, 510, 511]
    //         .contains(err.response?.statusCode)) {
    //       err.error = 'サーバーエラーが発生しました。しばらくしてから再度お試しください。';
    //     } else {
    //       err.error = '予期せぬエラーが発生しました。しばらくしてから再度お試しください。';
    //     }
    //     break;
    // }
  }
}
