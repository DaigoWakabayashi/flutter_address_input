import 'dart:convert';

import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_address_input/data/response/search_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

final apiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  return ApiClient(Dio()..interceptors.add(AwesomeDioInterceptor()));
});

///
/// ドキュメント: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
@RestApi(baseUrl: 'https://zipcloud.ibsnet.co.jp/api')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  ///
  /// 郵便番号から住所検索 API を叩く
  ///
  @GET('/search')
  Future<SearchResponse> search(@Query('zipcode') String zipcode);
}
