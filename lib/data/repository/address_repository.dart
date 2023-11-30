import 'package:flutter_address_input/data/client/firebase_client.dart';
import 'package:flutter_address_input/domain/address.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../client/api_client.dart';

final addressRepositoryProvider =
    Provider.autoDispose<_BaseAddressRepository>((ref) {
  return AddressRepository(
    ref.read(apiClientProvider),
    ref.read(firestoreClientProvider),
  );
});

abstract class _BaseAddressRepository {
  Future<Address?> getAddress(String id);
  Future<void> addAddress(Address address);
  Stream<List<Address>> subscribeAddresses();
}

class AddressRepository implements _BaseAddressRepository {
  AddressRepository(
    this._apiClient,
    this._firebaseClient,
  );

  final ApiClient _apiClient;
  final BaseFirebaseClient _firebaseClient;

  @override
  Future<Address?> getAddress(String zipcode) async {
    final res = await _apiClient.search(zipcode);
    final address = res.results?.first;
    return address;
  }

  @override
  Future<void> addAddress(Address address) async {
    await _firebaseClient.addAddress(address);
  }

  @override
  Stream<List<Address>> subscribeAddresses() {
    return _firebaseClient.subscribeAddresses();
  }
}
