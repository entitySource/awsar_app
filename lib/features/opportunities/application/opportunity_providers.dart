import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_providers.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/content/models/opportunity.dart';
import '../../../core/storage/prefs_provider.dart';
import '../domain/opportunity_filter.dart';

/// Saved opportunity ids, kept on the phone. When someone is signed in the
/// list is merged with their account and every change is copied there too.
class SavedOpportunities extends Notifier<Set<String>> {
  static const _key = 'saved_opportunities';

  @override
  Set<String> build() {
    final local = (ref.watch(prefsProvider).getStringList(_key) ?? const []).toSet();
    if (ref.watch(authControllerProvider) != null) unawaited(_mergeWithAccount(local));
    return local;
  }

  Future<void> _mergeWithAccount(Set<String> local) async {
    final remote = ref.read(savedRemoteProvider);
    try {
      final cloud = await remote.fetch();
      await remote.addAll(local.difference(cloud));
      if (!ref.mounted) return;
      final merged = {...cloud, ...state};
      state = merged;
      await ref.read(prefsProvider).setStringList(_key, merged.toList());
    } catch (_) {
      // Offline or server error: the phone copy still works; next sign-in retries.
    }
  }

  /// Returns true if [id] is now saved.
  Future<bool> toggle(String id) async {
    final next = {...state};
    final saved = next.add(id) || !next.remove(id);
    state = next;
    await ref.read(prefsProvider).setStringList(_key, next.toList());
    if (ref.read(authControllerProvider) != null) {
      final remote = ref.read(savedRemoteProvider);
      try {
        saved ? await remote.addAll([id]) : await remote.remove(id);
      } catch (_) {
        // Kept on the phone; merged into the account on the next sign-in.
      }
    }
    return saved;
  }
}

final savedOpportunitiesProvider = NotifierProvider<SavedOpportunities, Set<String>>(SavedOpportunities.new);

class OpportunityFilterController extends Notifier<OpportunityFilter> {
  @override
  OpportunityFilter build() => const OpportunityFilter();

  void setType(OpportunityType? type) => state = state.copyWith(type: () => type);
  void setQuery(String query) => state = state.copyWith(query: query);
  void setSavedOnly(bool value) => state = state.copyWith(savedOnly: value);
  void clear() => state = const OpportunityFilter();
}

final opportunityFilterProvider = NotifierProvider<OpportunityFilterController, OpportunityFilter>(
  OpportunityFilterController.new,
);

final filteredOpportunitiesProvider = Provider<AsyncValue<List<Opportunity>>>((ref) {
  final filter = ref.watch(opportunityFilterProvider);
  final saved = ref.watch(savedOpportunitiesProvider);
  return ref.watch(contentProvider).whenData((c) => filter.apply(c.opportunities, saved));
});
