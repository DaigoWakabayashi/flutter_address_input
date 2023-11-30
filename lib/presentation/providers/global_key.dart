import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global_key.g.dart';

/// [ScaffoldMessengerState] を持つ [GlobalKey]
/// 主に [SnackBar] の表示に使う
@riverpod
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey(
  ScaffoldMessengerKeyRef ref,
) =>
    GlobalKey<ScaffoldMessengerState>();
