import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Grey blocks shaped like a list of cards, shown while content loads.
/// Hidden from TalkBack, which hears the "loading" label instead.
class SkeletonList extends StatelessWidget {
  const SkeletonList({super.key, this.count = 4});

  final int count;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;
    Widget bar(double widthFactor, double height) => FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: Alignment.centerLeft,
      child: Container(
        height: height,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      ),
    );
    return Semantics(
      label: MaterialLocalizations.of(context).refreshIndicatorSemanticLabel,
      child: ExcludeSemantics(
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(Gap.lg),
          itemCount: count,
          separatorBuilder: (_, _) => const SizedBox(height: Gap.lg),
          itemBuilder: (_, i) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bar(0.6, 22),
              const SizedBox(height: Gap.sm),
              bar(1, 14),
              const SizedBox(height: Gap.xs),
              bar(0.85, 14),
            ],
          ),
        ),
      ),
    );
  }
}
