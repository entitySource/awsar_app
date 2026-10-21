import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/links/mailto.dart';
import '../../../core/links/open_link.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    Widget phone(String n) => Card(
      child: ListTile(
        leading: const Icon(Icons.call_outlined),
        title: Text(n),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => openLink(context, ref, telUri(n)),
      ).withHint(l10n.contactCallHint(n)),
    );
    Widget email(String e) => Card(
      child: ListTile(
        leading: const Icon(Icons.mail_outline),
        title: Text(e),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => openLink(context, ref, Uri(scheme: 'mailto', path: e)),
      ).withHint(l10n.contactEmailHint(e)),
    );

    return PageScaffold(
      title: l10n.contactTitle,
      body: AsyncValueView(
        value: ref.watch(contentProvider),
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) {
          final ct = c.contact;
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
            children: [
              if (ct.phones.isNotEmpty) ...[
                SectionHeader(l10n.contactPhone),
                for (final n in ct.phones) ...[phone(n), const SizedBox(height: Gap.sm)],
              ],
              if (ct.emails.isNotEmpty) ...[
                SectionHeader(l10n.contactEmail),
                for (final e in ct.emails) ...[email(e), const SizedBox(height: Gap.sm)],
              ],
              if (ct.offices.isNotEmpty) ...[
                SectionHeader(l10n.contactOffices),
                for (final o in ct.offices)
                  MergeSemantics(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: Gap.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(o.label, style: theme.textTheme.titleSmall),
                          const SizedBox(height: Gap.xs),
                          SelectableText(o.value, style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
              ],
              if (ct.helplines.isNotEmpty) ...[
                SectionHeader(l10n.contactHelplines),
                for (final h in ct.helplines) ...[
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.support_agent),
                      title: Text(h.value),
                      subtitle: Text(h.label),
                      onTap: () => openLink(context, ref, telUri(h.value)),
                    ).withHint(l10n.contactCallHint(h.value)),
                  ),
                  const SizedBox(height: Gap.sm),
                ],
              ],
              if (ct.eduAnchorsPhones.isNotEmpty || ct.eduAnchorsEmails.isNotEmpty) ...[
                SectionHeader(l10n.contactEduAnchors),
                for (final n in ct.eduAnchorsPhones) ...[phone(n), const SizedBox(height: Gap.sm)],
                for (final e in ct.eduAnchorsEmails) ...[email(e), const SizedBox(height: Gap.sm)],
              ],
              SourceFooter(url: ct.sourceUrl),
            ],
          );
        },
      ),
    );
  }
}

extension on Widget {
  Widget withHint(String hint) => Semantics(onTapHint: hint, child: this);
}
