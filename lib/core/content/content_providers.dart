import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/locale_controller.dart';
import 'app_content.dart';
import 'content_repository.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) => ContentRepository());

/// Content for one locale code ('en' or 'hi').
final contentForLocaleProvider = FutureProvider.family<AppContent, String>(
  (ref, locale) => ref.watch(contentRepositoryProvider).load(locale),
);

/// Content for the language the user picked.
final contentProvider = FutureProvider<AppContent>((ref) {
  final locale = ref.watch(localeControllerProvider);
  return ref.watch(contentForLocaleProvider(locale.languageCode).future);
});
