import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/links/open_link.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/draft_badge.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/handoff_builder.dart';

class DonateInternationalScreen extends ConsumerWidget {
  const DonateInternationalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final content = ref.watch(contentProvider);
    final donate = content.value?.donate;
    final payUrl = donate?.fcra.paymentLinkUrl;
    return PageScaffold(
      title: l10n.donateIntlTitle,
      bottomBar: donate?.handoffEmail == null
          ? null
          : BottomActionBar(
              child: FilledButton.icon(
                onPressed: () => openLink(
                  context,
                  ref,
                  internationalDonationEmail(to: donate!.handoffEmail!, subject: l10n.emailSubjectDonateIntl),
                ),
                icon: const Icon(Icons.mail_outline),
                label: Text(l10n.fcraContact),
              ),
            ),
      body: AsyncValueView(
        value: content,
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) => ListView(
          padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
          children: [
            const SizedBox(height: Gap.sm),
            if (c.meta.draft) const DraftBadge(),
            for (final p in c.donate.fcra.body)
              Padding(
                padding: const EdgeInsets.only(bottom: Gap.md),
                child: Text(p, style: theme.textTheme.bodyLarge),
              ),
            for (final d in c.donate.fcra.details)
              MergeSemantics(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Gap.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.label, style: theme.textTheme.labelMedium),
                      SelectableText(d.value, style: theme.textTheme.bodyLarge),
                    ],
                  ),
                ),
              ),
            if (payUrl != null)
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: () => openLink(context, ref, Uri.parse(payUrl)),
                  icon: const Icon(Icons.open_in_new),
                  label: Text(l10n.fcraPayOnline),
                ),
              ),
            SourceFooter(url: c.donate.sourceUrl),
          ],
        ),
      ),
    );
  }
}
