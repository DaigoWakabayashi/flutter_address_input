import 'dart:convert';

import 'package:flutter_address_input/enums/prefecture.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

/// 郵便番号から住所を取得する
///
/// API: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
/// レスポンスサンプル
/// ```json
/// {
/// 	"message": null,
/// 	"results": [
/// 		{
/// 			"address1": "北海道",
/// 			"address2": "美唄市",
/// 			"address3": "上美唄町協和",
/// 			"kana1": "ﾎｯｶｲﾄﾞｳ",
/// 			"kana2": "ﾋﾞﾊﾞｲｼ",
/// 			"kana3": "ｶﾐﾋﾞﾊﾞｲﾁｮｳｷｮｳﾜ",
/// 			"prefcode": "1",
/// 			"zipcode": "0790177"
/// 		},
/// 		{
/// 			"address1": "北海道",
/// 			"address2": "美唄市",
/// 			"address3": "上美唄町南",
/// 			"kana1": "ﾎｯｶｲﾄﾞｳ",
/// 			"kana2": "ﾋﾞﾊﾞｲｼ",
/// 			"kana3": "ｶﾐﾋﾞﾊﾞｲﾁｮｳﾐﾅﾐ",
/// 			"prefcode": "1",
/// 			"zipcode": "0790177"
/// 		}
/// 	],
/// 	"status": 200
/// }
/// ```
typedef AddressResponse = ({
  Prefecture address1,
  String address2,
  String address3,
});

final addressFromZipcodeFutureProvider = FutureProvider.autoDispose
    .family<AddressResponse?, String>((ref, zipcode) async {
  final response = await http.get(
    Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipcode'),
  );
  // 正常なレスポンスのみ処理
  if (response.statusCode != 200) {
    return null;
  }
  // パースして整形
  final body = jsonDecode(response.body) as Map<String, dynamic>;
  final addressMap = body['results'].first as Map<String, dynamic>;
  return (
    address1: Prefecture.values.byCode(addressMap['prefcode'] as String),
    address2: addressMap['address2'] as String,
    address3: addressMap['address3'] as String
  );
});
