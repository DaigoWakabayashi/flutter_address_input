// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchAddressFromZipcodeHash() =>
    r'47dd3cacd3ad49619f8b598b277159c988c6b46b';

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

/// 郵便番号から住所検索 API を叩き
/// 有効なレスポンスがあれば [SearchAddressResponse] を、なければ [null] を返す
///
/// API: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
///
/// Copied from [searchAddressFromZipcode].
@ProviderFor(searchAddressFromZipcode)
const searchAddressFromZipcodeProvider = SearchAddressFromZipcodeFamily();

/// 郵便番号から住所検索 API を叩き
/// 有効なレスポンスがあれば [SearchAddressResponse] を、なければ [null] を返す
///
/// API: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
///
/// Copied from [searchAddressFromZipcode].
class SearchAddressFromZipcodeFamily
    extends Family<AsyncValue<SearchAddressResponse?>> {
  /// 郵便番号から住所検索 API を叩き
  /// 有効なレスポンスがあれば [SearchAddressResponse] を、なければ [null] を返す
  ///
  /// API: http://zipcloud.ibsnet.co.jp/doc/api
  /// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
  ///
  ///
  /// Copied from [searchAddressFromZipcode].
  const SearchAddressFromZipcodeFamily();

  /// 郵便番号から住所検索 API を叩き
  /// 有効なレスポンスがあれば [SearchAddressResponse] を、なければ [null] を返す
  ///
  /// API: http://zipcloud.ibsnet.co.jp/doc/api
  /// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
  ///
  ///
  /// Copied from [searchAddressFromZipcode].
  SearchAddressFromZipcodeProvider call(
    String zipcode,
  ) {
    return SearchAddressFromZipcodeProvider(
      zipcode,
    );
  }

  @override
  SearchAddressFromZipcodeProvider getProviderOverride(
    covariant SearchAddressFromZipcodeProvider provider,
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
  String? get name => r'searchAddressFromZipcodeProvider';
}

/// 郵便番号から住所検索 API を叩き
/// 有効なレスポンスがあれば [SearchAddressResponse] を、なければ [null] を返す
///
/// API: http://zipcloud.ibsnet.co.jp/doc/api
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
///
/// Copied from [searchAddressFromZipcode].
class SearchAddressFromZipcodeProvider
    extends AutoDisposeFutureProvider<SearchAddressResponse?> {
  /// 郵便番号から住所検索 API を叩き
  /// 有効なレスポンスがあれば [SearchAddressResponse] を、なければ [null] を返す
  ///
  /// API: http://zipcloud.ibsnet.co.jp/doc/api
  /// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
  ///
  ///
  /// Copied from [searchAddressFromZipcode].
  SearchAddressFromZipcodeProvider(
    String zipcode,
  ) : this._internal(
          (ref) => searchAddressFromZipcode(
            ref as SearchAddressFromZipcodeRef,
            zipcode,
          ),
          from: searchAddressFromZipcodeProvider,
          name: r'searchAddressFromZipcodeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchAddressFromZipcodeHash,
          dependencies: SearchAddressFromZipcodeFamily._dependencies,
          allTransitiveDependencies:
              SearchAddressFromZipcodeFamily._allTransitiveDependencies,
          zipcode: zipcode,
        );

  SearchAddressFromZipcodeProvider._internal(
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
    FutureOr<SearchAddressResponse?> Function(
            SearchAddressFromZipcodeRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchAddressFromZipcodeProvider._internal(
        (ref) => create(ref as SearchAddressFromZipcodeRef),
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
  AutoDisposeFutureProviderElement<SearchAddressResponse?> createElement() {
    return _SearchAddressFromZipcodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchAddressFromZipcodeProvider &&
        other.zipcode == zipcode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, zipcode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchAddressFromZipcodeRef
    on AutoDisposeFutureProviderRef<SearchAddressResponse?> {
  /// The parameter `zipcode` of this provider.
  String get zipcode;
}

class _SearchAddressFromZipcodeProviderElement
    extends AutoDisposeFutureProviderElement<SearchAddressResponse?>
    with SearchAddressFromZipcodeRef {
  _SearchAddressFromZipcodeProviderElement(super.provider);

  @override
  String get zipcode => (origin as SearchAddressFromZipcodeProvider).zipcode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
