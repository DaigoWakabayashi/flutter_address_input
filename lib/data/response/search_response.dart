import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/address.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  const SearchResponse({required this.status, this.results});

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  final int status;
  final List<Address>? results;

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}
