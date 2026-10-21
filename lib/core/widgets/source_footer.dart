import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import '../../l10n/app_localizations.dart';
import '../links/open_link.dart';

/// "Source: awsarindia.org" at the end of every content screen.
class SourceFooter extends ConsumerWidget {
  const SourceFooter({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final uri = Uri.tryParse(url);
    final host = uri?.host.replaceFirst('www.', '') ?? url;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Gap.xl),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Semantics(
          hint: l10n.sourceOpenHint,
          child: TextButton.icon(
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: Gap.xs)),
            onPressed: uri == null ? null : () => openLink(context, ref, uri),
            icon: const Icon(Icons.open_in_new, size: 18),
            label: Text(l10n.sourceLabel(host)),
          ),
        ),
      ),
    );
  }
}
