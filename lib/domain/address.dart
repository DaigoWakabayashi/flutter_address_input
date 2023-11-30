import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

/// 住所にあたるモデルクラス
///
/// 各プロパティ名は、日本郵便が公開している
/// 郵便番号検索API（https://zipcloud.ibsnet.co.jp/doc/api）
/// のレスポンスに合わせている
@freezed
class Address with _$Address {
  const factory Address({
    /// 郵便番号
    ///
    /// 7桁の数字。ハイフンなし。
    ///
    required String zipcode,

    /// 都道府県コード
    required String prefcode,

    /// 都道府県名
    required String address1,

    /// 市区町村名
    required String address2,

    /// 町域名
    required String address3,

    /// 建物名
    required String? address4,
  }) = _Address;

  factory Address.fromJson(Map<String, Object?> json) =>
      _$AddressFromJson(json);
}
