import 'package:dio/dio.dart';
import 'package:flutter_address_input/data/response/result.dart';

import '../../domain/address.dart';
import '../zip_cloud_client.dart';

abstract class _AddressRepository {
  Future<Result<Address>> getAddress(String id);
}

class AddressRepository implements _AddressRepository {
  AddressRepository([ZipCloudClient? client])
      : _client = client ?? ZipCloudClient(Dio());

  final ZipCloudClient _client;

  @override
  Future<Result<Address>> getAddress(String zipcode) {
    return _client
        .search(zipcode)
        .then((addresses) => Result<Address>.success(addresses.first))
        .catchError((error) => Result<Address>.failure(error));
  }
}
