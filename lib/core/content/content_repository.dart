import 'dart:convert';

import 'package:flutter/services.dart';

import 'app_content.dart';
import 'json_read.dart';
import 'models/contact.dart';
import 'models/get_involved_info.dart';
import 'models/media_item.dart';
import 'models/opportunity.dart';
import 'models/org.dart';
import 'models/programme.dart';

/// Reads a bundled text asset. Swapped for a fake in tests.
typedef AssetReader = Future<String> Function(String path);

/// Loads the 8 content files for a locale from the bundle, in parallel.
/// A file missing in the requested locale falls back to English, so a
/// partial Hindi translation never blanks a screen.
class ContentRepository {
  ContentRepository({AssetReader? read}) : _read = read ?? rootBundle.loadString;

  final AssetReader _read;
  final _cache = <String, Future<AppContent>>{};

  static const files = ['org', 'eduanchors', 'programmes', 'opportunities', 'donate', 'volunteer', 'contact', 'media'];

  Future<AppContent> load(String locale) => _cache.putIfAbsent(locale, () => _load(locale));

  Future<AppContent> _load(String locale) async {
    final fellBack = <String>[];
    final skipped = <String>[];
    var draft = false;

    Future<Json> file(String name) async {
      Json decoded;
      try {
        decoded = jsonDecode(await _read('assets/content/$locale/$name.json')) as Json;
      } catch (_) {
        if (locale == 'en') rethrow;
        fellBack.add(name);
        decoded = jsonDecode(await _read('assets/content/en/$name.json')) as Json;
      }
      if ((decoded['meta'] as Json?)?['draft'] == true) draft = true;
      return decoded;
    }

    final loaded = await Future.wait(files.map(file));
    final byName = Map.fromIterables(files, loaded);
    void onSkip(String path, Object e) => skipped.add(path);

    final content = AppContent(
      meta: ContentMeta(locale: locale, draft: draft, fellBackToEnglish: fellBack, skippedItems: skipped),
      org: Org.fromJson(reqObj(byName['org']!, 'data', 'org'), 'org.data'),
      eduAnchors: EduAnchorsInfo.fromJson(reqObj(byName['eduanchors']!, 'data', 'eduanchors'), 'eduanchors.data'),
      programmes: objList(byName['programmes']!, 'items', 'programmes', Programme.fromJson, onSkip: onSkip)
        ..sort((a, b) => a.order.compareTo(b.order)),
      opportunities: objList(byName['opportunities']!, 'items', 'opportunities', Opportunity.fromJson, onSkip: onSkip),
      donate: DonateInfo.fromJson(reqObj(byName['donate']!, 'data', 'donate'), 'donate.data'),
      volunteer: VolunteerInfo.fromJson(reqObj(byName['volunteer']!, 'data', 'volunteer'), 'volunteer.data'),
      contact: Contact.fromJson(reqObj(byName['contact']!, 'data', 'contact'), 'contact.data'),
      media: objList(byName['media']!, 'items', 'media', MediaItem.fromJson, onSkip: onSkip),
    );
    return content;
  }
}
