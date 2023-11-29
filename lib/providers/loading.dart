import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading.g.dart';

@riverpod
class Loading extends _$Loading {
  @override
  bool build() => false;

  /// ローディングを表示する
  void show() => state = true;

  /// ローディングを非表示にする
  void hide() => state = false;
}
