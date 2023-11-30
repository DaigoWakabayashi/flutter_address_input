import 'package:dio/dio.dart';
import 'package:flutter_address_input/domain/address.dart';
import 'package:retrofit/http.dart';

part 'zip_cloud_client.g.dart';

///
/// ドキュメント: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
@RestApi(baseUrl: 'https://zipcloud.ibsnet.co.jp/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  ///
  /// 郵便番号から住所検索 API 叩く
  @GET('/search')
  Future<List<Address>> getAddressesFromZipcode(
    @Query('zipcode') String zipcode,
  );
}
