import 'package:awsar_app/core/content/models/opportunity.dart';
import 'package:awsar_app/features/opportunities/domain/opportunity_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Opportunity o(String id, OpportunityType t, String title, {List<String> tags = const []}) =>
      Opportunity(id: id, type: t, title: title, summary: 'summary', sample: false, sourceUrl: 'https://x', tags: tags);

  final items = [
    o('a', OpportunityType.scholarship, 'Merit scholarship', tags: ['Class 12']),
    o('b', OpportunityType.mentorship, 'Career mentor'),
    o('c', OpportunityType.internship, 'NGO internship'),
  ];

  test('no filter returns everything', () {
    expect(const OpportunityFilter().apply(items, {}), hasLength(3));
  });

  test('type, query (incl. tags) and saved-only combine', () {
    expect(const OpportunityFilter(type: OpportunityType.mentorship).apply(items, {}).single.id, 'b');
    expect(const OpportunityFilter(query: 'class 12').apply(items, {}).single.id, 'a');
    expect(const OpportunityFilter(savedOnly: true).apply(items, {'c'}).single.id, 'c');
    expect(const OpportunityFilter(type: OpportunityType.scholarship, savedOnly: true).apply(items, {'c'}), isEmpty);
  });
}
