// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      zipcode: json['zipcode'] as String,
      address1: json['address1'] as String,
      address2: json['address2'] as String,
      address3: json['address3'] as String,
      address4: json['address4'] as String?,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'zipcode': instance.zipcode,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'address4': instance.address4,
    };
