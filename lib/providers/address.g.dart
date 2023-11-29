// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchAddressHash() => r'ca37709804e7edaa8f5b7b9faf3bc65fd78f0450';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 郵便番号から住所を取得する [FutureProvider]
///
/// API: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
/// Copied from [searchAddress].
@ProviderFor(searchAddress)
const searchAddressProvider = SearchAddressFamily();

/// 郵便番号から住所を取得する [FutureProvider]
///
/// API: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
/// Copied from [searchAddress].
class SearchAddressFamily extends Family<AsyncValue<AddressResponse?>> {
  /// 郵便番号から住所を取得する [FutureProvider]
  ///
  /// API: http://zipcloud.ibsnet.co.jp/doc/api
  /// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
  ///
  /// Copied from [searchAddress].
  const SearchAddressFamily();

  /// 郵便番号から住所を取得する [FutureProvider]
  ///
  /// API: http://zipcloud.ibsnet.co.jp/doc/api
  /// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
  ///
  /// Copied from [searchAddress].
  SearchAddressProvider call(
    String zipcode,
  ) {
    return SearchAddressProvider(
      zipcode,
    );
  }

  @override
  SearchAddressProvider getProviderOverride(
    covariant SearchAddressProvider provider,
  ) {
    return call(
      provider.zipcode,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchAddressProvider';
}

/// 郵便番号から住所を取得する [FutureProvider]
///
/// API: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
/// Copied from [searchAddress].
class SearchAddressProvider
    extends AutoDisposeFutureProvider<AddressResponse?> {
  /// 郵便番号から住所を取得する [FutureProvider]
  ///
  /// API: http://zipcloud.ibsnet.co.jp/doc/api
  /// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
  ///
  /// Copied from [searchAddress].
  SearchAddressProvider(
    String zipcode,
  ) : this._internal(
          (ref) => searchAddress(
            ref as SearchAddressRef,
            zipcode,
          ),
          from: searchAddressProvider,
          name: r'searchAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchAddressHash,
          dependencies: SearchAddressFamily._dependencies,
          allTransitiveDependencies:
              SearchAddressFamily._allTransitiveDependencies,
          zipcode: zipcode,
        );

  SearchAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.zipcode,
  }) : super.internal();

  final String zipcode;

  @override
  Override overrideWith(
    FutureOr<AddressResponse?> Function(SearchAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchAddressProvider._internal(
        (ref) => create(ref as SearchAddressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        zipcode: zipcode,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AddressResponse?> createElement() {
    return _SearchAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchAddressProvider && other.zipcode == zipcode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, zipcode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchAddressRef on AutoDisposeFutureProviderRef<AddressResponse?> {
  /// The parameter `zipcode` of this provider.
  String get zipcode;
}

class _SearchAddressProviderElement
    extends AutoDisposeFutureProviderElement<AddressResponse?>
    with SearchAddressRef {
  _SearchAddressProviderElement(super.provider);

  @override
  String get zipcode => (origin as SearchAddressProvider).zipcode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
