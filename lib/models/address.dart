/// 住所にあたるモデルクラス
///
/// 各プロパティ名は、日本郵便が公開している
/// 郵便番号検索API（https://zipcloud.ibsnet.co.jp/doc/api）
/// のレスポンスに合わせている
final class Address {
  /// 郵便番号
  ///
  /// 7桁の数字。ハイフンなし。
  ///
  final String zipcode;

  /// 都道府県コード
  final String prefcode;

  /// 都道府県名
  final String address1;

  /// 市区町村名
  final String address2;

  /// 町域名
  final String address3;

  /// 建物名
  final String? address4;

  Address({
    required this.zipcode,
    required this.prefcode,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.address4,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      zipcode: json['zipcode'],
      prefcode: json['prefcode'],
      address1: json['address1'],
      address2: json['address2'],
      address3: json['address3'],
      address4: json['address4'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'zipcode': zipcode,
      'prefcode': prefcode,
      'address1': address1,
      'address2': address2,
      'address3': address3,
      'address4': address4,
    };
  }
}
