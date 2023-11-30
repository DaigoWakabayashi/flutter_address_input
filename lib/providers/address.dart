import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_address_input/enums/prefecture.dart';
import 'package:flutter_address_input/models/address.dart';
import 'package:flutter_address_input/providers/global_key.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address.g.dart';

/// [FirebaseFirestore] の addresses コレクションを購読する [Stream]
@riverpod
Stream<List<Address>> subscribeAddresses(SubscribeAddressesRef ref) {
  return FirebaseFirestore.instance.collection('addresses').snapshots().map(
        (snap) => snap.docs.map((doc) => Address.fromJson(doc.data())).toList(),
      );
}

typedef SearchAddressResponse = ({
  Prefecture address1,
  String address2,
  String address3,
});

/// 郵便番号から住所検索 API を叩き
/// 有効なレスポンスがあれば [SearchAddressResponse] を、なければ [null] を返す
///
/// API: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
@riverpod
Future<SearchAddressResponse?> searchAddressFromZipcode(
  SearchAddressFromZipcodeRef ref,
  String zipcode,
) async {
  try {
    final response = await http.get(
      Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipcode'),
    );
    // 正常なレスポンスのみ処理
    if (response.statusCode != 200) {
      throw Exception();
    }
    // パースして結果の配列を取得
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final results = body['results'] as List?;
    if (results == null || results.isEmpty) {
      throw Exception();
    }
    // 複数の住所のうち、先頭の住所を使う
    final addressMap = body['results'].first as Map<String, dynamic>;
    return (
      address1: Prefecture.values.byCode(addressMap['prefcode'] as String),
      address2: addressMap['address2'] as String,
      address3: addressMap['address3'] as String
    );
  } on Exception catch (_) {
    final messengerKey = ref.read(scaffoldMessengerKeyProvider).currentState;
    messengerKey?.showSnackBar(const SnackBar(content: Text('エラーが発生しました')));
    return null;
  }
}
