import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_state.dart';
import 'skeleton.dart';

/// Loading → skeleton, error → [ErrorState] with retry, data → [data].
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({super.key, required this.value, required this.data, required this.onRetry});

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => switch (value) {
    AsyncData(:final value) => data(value),
    AsyncError() => Center(
      child: SingleChildScrollView(child: ErrorState(onRetry: onRetry)),
    ),
    _ => const SkeletonList(),
  };
}
