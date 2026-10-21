import 'models/contact.dart';
import 'models/get_involved_info.dart';
import 'models/media_item.dart';
import 'models/opportunity.dart';
import 'models/org.dart';
import 'models/programme.dart';

/// What the app knows about where its content came from.
class ContentMeta {
  const ContentMeta({
    required this.locale,
    required this.draft,
    required this.fellBackToEnglish,
    required this.skippedItems,
  });

  final String locale;

  /// True when any file is a machine/draft translation.
  final bool draft;

  /// Files that were missing in [locale] and loaded from English instead.
  final List<String> fellBackToEnglish;

  /// Item paths skipped because they failed to parse.
  final List<String> skippedItems;
}

class AppContent {
  const AppContent({
    required this.meta,
    required this.org,
    required this.eduAnchors,
    required this.programmes,
    required this.opportunities,
    required this.donate,
    required this.volunteer,
    required this.contact,
    required this.media,
  });

  final ContentMeta meta;
  final Org org;
  final EduAnchorsInfo eduAnchors;
  final List<Programme> programmes;
  final List<Opportunity> opportunities;
  final DonateInfo donate;
  final VolunteerInfo volunteer;
  final Contact contact;
  final List<MediaItem> media;

  Programme? programmeById(String id) => programmes.where((p) => p.id == id).firstOrNull;

  Opportunity? opportunityById(String id) => opportunities.where((o) => o.id == id).firstOrNull;
}
