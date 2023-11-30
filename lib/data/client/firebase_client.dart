import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_address_input/domain/address.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final firestoreClientProvider = Provider.autoDispose<BaseFirebaseClient>((ref) {
  return FirebaseClientImpl();
});

abstract class BaseFirebaseClient {
  Stream<List<Address>> subscribeAddresses();
  Future<void> addAddress(Address address);
}

class FirebaseClientImpl implements BaseFirebaseClient {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Address>> subscribeAddresses() {
    return _firestore.collection('addresses').snapshots().map(
          (qds) => qds.docs.map((doc) => Address.fromJson(doc.data())).toList(),
        );
  }

  @override
  Future<void> addAddress(Address address) async {
    await _firestore.collection('addresses').add(address.toJson());
  }
}
