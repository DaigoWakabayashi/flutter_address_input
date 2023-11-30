// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  /// 郵便番号
  ///
  /// 7桁の数字。ハイフンなし。
  ///
  String get zipcode => throw _privateConstructorUsedError;

  /// 都道府県名
  String get address1 => throw _privateConstructorUsedError;

  /// 市区町村名
  String get address2 => throw _privateConstructorUsedError;

  /// 町域名
  String get address3 => throw _privateConstructorUsedError;

  /// 建物名
  String? get address4 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call(
      {String zipcode,
      String address1,
      String address2,
      String address3,
      String? address4});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zipcode = null,
    Object? address1 = null,
    Object? address2 = null,
    Object? address3 = null,
    Object? address4 = freezed,
  }) {
    return _then(_value.copyWith(
      zipcode: null == zipcode
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String,
      address1: null == address1
          ? _value.address1
          : address1 // ignore: cast_nullable_to_non_nullable
              as String,
      address2: null == address2
          ? _value.address2
          : address2 // ignore: cast_nullable_to_non_nullable
              as String,
      address3: null == address3
          ? _value.address3
          : address3 // ignore: cast_nullable_to_non_nullable
              as String,
      address4: freezed == address4
          ? _value.address4
          : address4 // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
          _$AddressImpl value, $Res Function(_$AddressImpl) then) =
      __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String zipcode,
      String address1,
      String address2,
      String address3,
      String? address4});
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
      _$AddressImpl _value, $Res Function(_$AddressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zipcode = null,
    Object? address1 = null,
    Object? address2 = null,
    Object? address3 = null,
    Object? address4 = freezed,
  }) {
    return _then(_$AddressImpl(
      zipcode: null == zipcode
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String,
      address1: null == address1
          ? _value.address1
          : address1 // ignore: cast_nullable_to_non_nullable
              as String,
      address2: null == address2
          ? _value.address2
          : address2 // ignore: cast_nullable_to_non_nullable
              as String,
      address3: null == address3
          ? _value.address3
          : address3 // ignore: cast_nullable_to_non_nullable
              as String,
      address4: freezed == address4
          ? _value.address4
          : address4 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressImpl implements _Address {
  const _$AddressImpl(
      {required this.zipcode,
      required this.address1,
      required this.address2,
      required this.address3,
      required this.address4});

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  /// 郵便番号
  ///
  /// 7桁の数字。ハイフンなし。
  ///
  @override
  final String zipcode;

  /// 都道府県名
  @override
  final String address1;

  /// 市区町村名
  @override
  final String address2;

  /// 町域名
  @override
  final String address3;

  /// 建物名
  @override
  final String? address4;

  @override
  String toString() {
    return 'Address(zipcode: $zipcode, address1: $address1, address2: $address2, address3: $address3, address4: $address4)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.zipcode, zipcode) || other.zipcode == zipcode) &&
            (identical(other.address1, address1) ||
                other.address1 == address1) &&
            (identical(other.address2, address2) ||
                other.address2 == address2) &&
            (identical(other.address3, address3) ||
                other.address3 == address3) &&
            (identical(other.address4, address4) ||
                other.address4 == address4));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, zipcode, address1, address2, address3, address4);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(
      this,
    );
  }
}

abstract class _Address implements Address {
  const factory _Address(
      {required final String zipcode,
      required final String address1,
      required final String address2,
      required final String address3,
      required final String? address4}) = _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override

  /// 郵便番号
  ///
  /// 7桁の数字。ハイフンなし。
  ///
  String get zipcode;
  @override

  /// 都道府県名
  String get address1;
  @override

  /// 市区町村名
  String get address2;
  @override

  /// 町域名
  String get address3;
  @override

  /// 建物名
  String? get address4;
  @override
  @JsonKey(ignore: true)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
