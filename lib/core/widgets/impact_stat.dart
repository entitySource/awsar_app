import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../content/models/labeled_value.dart';

/// "12,000+ / Children enrolled", read by TalkBack as one phrase.
class ImpactStat extends StatelessWidget {
  const ImpactStat(this.stat, {super.key});

  final LabeledValue stat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return MergeSemantics(
      child: Container(
        padding: const EdgeInsets.all(Gap.lg),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(stat.value, style: theme.textTheme.headlineMedium?.copyWith(color: scheme.primary)),
            const SizedBox(height: Gap.xs),
            Text(stat.label, style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

/// Two columns on phones, three on wide screens; heights follow content so
/// nothing overflows at large text sizes.
class ImpactGrid extends StatelessWidget {
  const ImpactGrid({super.key, required this.stats});

  final List<LabeledValue> stats;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final textScale = MediaQuery.textScalerOf(context).scale(1);
        final cols = textScale >= 1.6 ? 1 : (c.maxWidth >= 600 ? 3 : 2);
        final w = (c.maxWidth - Gap.md * (cols - 1)) / cols;
        return Wrap(
          spacing: Gap.md,
          runSpacing: Gap.md,
          children: [for (final s in stats) SizedBox(width: w, child: ImpactStat(s))],
        );
      },
    );
  }
}
