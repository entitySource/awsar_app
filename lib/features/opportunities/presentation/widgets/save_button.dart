import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../application/opportunity_providers.dart';

class SaveOpportunityButton extends ConsumerWidget {
  const SaveOpportunityButton({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final saved = ref.watch(savedOpportunitiesProvider).contains(id);
    return IconButton(
      tooltip: saved ? l10n.oppUnsave : l10n.oppSave,
      isSelected: saved,
      icon: const Icon(Icons.bookmark_border),
      selectedIcon: const Icon(Icons.bookmark),
      onPressed: () async {
        HapticFeedback.selectionClick();
        final messenger = ScaffoldMessenger.of(context);
        final nowSaved = await ref.read(savedOpportunitiesProvider.notifier).toggle(id);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(nowSaved ? l10n.oppSavedSnack : l10n.oppRemovedSnack)));
      },
    );
  }
}
