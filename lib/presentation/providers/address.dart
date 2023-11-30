import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_address_input/domain/address.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/address_repository.dart';

part 'address.g.dart';

/// [FirebaseFirestore] の addresses コレクションを購読する [Stream]
@riverpod
Stream<List<Address>> subscribeAddresses(SubscribeAddressesRef ref) {
  return FirebaseFirestore.instance.collection('addresses').snapshots().map(
        (snap) => snap.docs.map((doc) => Address.fromJson(doc.data())).toList(),
      );
}

/// 郵便番号から住所検索 API を叩き
/// 有効なレスポンスがあれば [SearchAddressResponse] を、なければ [null] を返す
///
/// API:
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
@riverpod
Future<Address?> searchAddressFromZipcode(
  SearchAddressFromZipcodeRef ref,
  String zipcode,
) async {
  final repo = ref.read(addressRepositoryProvider);
  final address = await repo.getAddress(zipcode);
  return address;
}
