import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import 'link_launcher.dart';

/// Opens [uri] outside the app; shows a snackbar if nothing could open it
/// (no browser, no mail app, or offline).
Future<bool> openLink(BuildContext context, WidgetRef ref, Uri uri) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final failed = AppLocalizations.of(context).linkOpenFailed;
  final ok = await ref.read(linkLauncherProvider).open(uri);
  if (!ok) messenger?.showSnackBar(SnackBar(content: Text(failed)));
  return ok;
}
