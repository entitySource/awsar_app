import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens links outside the app. Screens go through this provider so tests
/// can record launches instead of opening anything.
abstract class LinkLauncher {
  Future<bool> open(Uri uri);
}

class UrlLauncherLinkLauncher implements LinkLauncher {
  const UrlLauncherLinkLauncher();

  @override
  Future<bool> open(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}

final linkLauncherProvider = Provider<LinkLauncher>((ref) => const UrlLauncherLinkLauncher());
