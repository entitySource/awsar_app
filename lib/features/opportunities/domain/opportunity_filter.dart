import '../../../core/content/models/opportunity.dart';

class OpportunityFilter {
  const OpportunityFilter({this.type, this.query = '', this.savedOnly = false});

  /// Null means all types.
  final OpportunityType? type;
  final String query;
  final bool savedOnly;

  bool get isActive => type != null || query.trim().isNotEmpty || savedOnly;

  OpportunityFilter copyWith({OpportunityType? Function()? type, String? query, bool? savedOnly}) => OpportunityFilter(
    type: type == null ? this.type : type(),
    query: query ?? this.query,
    savedOnly: savedOnly ?? this.savedOnly,
  );

  /// Case-insensitive match on title, provider, summary and tags.
  List<Opportunity> apply(List<Opportunity> items, Set<String> savedIds) {
    final q = query.trim().toLowerCase();
    return items.where((o) {
      if (type != null && o.type != type) return false;
      if (savedOnly && !savedIds.contains(o.id)) return false;
      if (q.isEmpty) return true;
      final haystack = [o.title, o.provider ?? '', o.summary, ...o.tags].join(' ').toLowerCase();
      return haystack.contains(q);
    }).toList();
  }
}
