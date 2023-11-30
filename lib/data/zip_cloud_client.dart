import 'package:dio/dio.dart';
import 'package:flutter_address_input/domain/address.dart';
import 'package:retrofit/http.dart';

part 'zip_cloud_client.g.dart';

///
/// ドキュメント: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
@RestApi(baseUrl: 'https://zipcloud.ibsnet.co.jp/api')
abstract class ZipCloudClient {
  factory ZipCloudClient(Dio dio, {String baseUrl}) = _ZipCloudClient;

  ///
  /// 郵便番号から住所検索 API を叩く
  ///
  @GET('/search')
  Future<List<Address>> search(@Query('zipcode') String zipcode);
}
