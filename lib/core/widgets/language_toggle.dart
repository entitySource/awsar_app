import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../l10n/locale_controller.dart';

/// EN | हिं segmented switch shown in every app bar.
class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localeControllerProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Tooltip(
        message: l10n.languageToggleTooltip,
        child: SegmentedButton<String>(
          key: const Key('language-toggle'),
          showSelectedIcon: false,
          style: SegmentedButton.styleFrom(
            visualDensity: VisualDensity.standard,
            tapTargetSize: MaterialTapTargetSize.padded,
            padding: const EdgeInsets.symmetric(horizontal: 4),
          ),
          segments: [
            ButtonSegment(
              value: 'en',
              label: Semantics(label: l10n.languageEnglish, excludeSemantics: true, child: const Text('EN')),
            ),
            ButtonSegment(
              value: 'hi',
              label: Semantics(label: l10n.languageHindi, excludeSemantics: true, child: const Text('हिं')),
            ),
          ],
          selected: {locale.languageCode},
          onSelectionChanged: (s) => ref.read(localeControllerProvider.notifier).set(Locale(s.first)),
        ),
      ),
    );
  }
}
