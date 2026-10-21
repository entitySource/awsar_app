import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../core/content/models/programme.dart';
import '../../../../core/widgets/programme_icon.dart';

class ProgrammeCard extends StatelessWidget {
  const ProgrammeCard({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card(
      child: InkWell(
        onTap: () => context.go(Routes.programme(programme.id)),
        child: Padding(
          padding: const EdgeInsets.all(Gap.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'programme-icon-${programme.id}',
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: scheme.secondaryContainer, borderRadius: BorderRadius.circular(12)),
                  child: Icon(programmeIcon(programme.icon), color: scheme.onSecondaryContainer),
                ),
              ),
              const SizedBox(width: Gap.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      programme.title,
                      style: theme.textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Gap.xs),
                    Text(
                      programme.summary,
                      style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (programme.impact.isNotEmpty) ...[
                      const SizedBox(height: Gap.sm),
                      Text(
                        '${programme.impact.first.value} · ${programme.impact.first.label}',
                        style: theme.textTheme.labelMedium?.copyWith(color: scheme.primary),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: Gap.sm),
              ExcludeSemantics(child: Icon(Icons.chevron_right, color: scheme.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }
}
