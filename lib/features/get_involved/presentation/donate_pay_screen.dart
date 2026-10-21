import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/content/models/get_involved_info.dart';
import '../../../core/links/open_link.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/handoff_builder.dart';

/// UPI QR for an Indian donation. The donor pays in their own UPI app;
/// the app never handles money. Details (PAN included) stay in memory.
class DonatePayScreen extends ConsumerWidget {
  const DonatePayScreen({super.key, required this.upi, required this.details, this.receiptEmail});

  final UpiInfo upi;
  final DonationDetails details;

  /// Where the 80G receipt request goes; null hides that option.
  final String? receiptEmail;

  /// "1,500.5" -> "1500.50", the form UPI apps expect.
  static String upiAmount(String typed) {
    final n = double.tryParse(typed.replaceAll(',', '').trim()) ?? 0;
    return n.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final amount = upiAmount(details.amount);
    final shownAmount = amount.endsWith('.00') ? amount.substring(0, amount.length - 3) : amount;
    final payUri = upi.payUri(amount: amount, note: l10n.donatePayNote);

    return PageScaffold(
      title: l10n.donatePayTitle,
      bottomBar: BottomActionBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton.icon(
              key: const Key('donate-pay-upi'),
              style: ctaButtonStyle(theme.colorScheme),
              onPressed: () => openLink(context, ref, payUri),
              icon: const Icon(Icons.account_balance_wallet_outlined),
              label: Text(l10n.donatePayOpenApp),
            ),
            const SizedBox(height: Gap.sm),
            TextButton(
              key: const Key('donate-pay-done'),
              onPressed: () => context.go(Routes.getInvolved),
              child: Text(l10n.successDone),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
        children: [
          const SizedBox(height: Gap.sm),
          if (upi.demo)
            Card(
              key: const Key('donate-pay-demo'),
              color: theme.colorScheme.tertiaryContainer,
              child: ListTile(
                leading: Icon(Icons.science_outlined, color: theme.colorScheme.onTertiaryContainer),
                title: Text(
                  l10n.donatePayDemo,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onTertiaryContainer),
                ),
              ),
            ),
          const SizedBox(height: Gap.lg),
          Semantics(
            header: true,
            child: Text(
              l10n.donatePayAmount(shownAmount, upi.payeeName),
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: Gap.lg),
          Center(
            child: Semantics(
              image: true,
              label: l10n.donatePayQrLabel(shownAmount, upi.payeeName),
              child: Container(
                key: const Key('donate-pay-qr'),
                padding: const EdgeInsets.all(Gap.md),
                // QR scanners need dark modules on a light background, in either theme.
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: QrImageView(
                  data: payUri.toString(),
                  size: 232,
                  backgroundColor: Colors.white,
                  eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF0B1F2A)),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Color(0xFF0B1F2A),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: Gap.lg),
          Text(l10n.donatePayScanHint, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
          const SizedBox(height: Gap.lg),
          Card(
            child: ListTile(
              title: Text(l10n.donatePayUpiId, style: theme.textTheme.labelMedium),
              subtitle: SelectableText(upi.vpa, style: theme.textTheme.titleMedium),
              trailing: IconButton(
                key: const Key('donate-pay-copy'),
                tooltip: l10n.donatePayCopy,
                icon: const Icon(Icons.copy),
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  await Clipboard.setData(ClipboardData(text: upi.vpa));
                  messenger.showSnackBar(SnackBar(content: Text(l10n.donatePayCopied)));
                },
              ),
            ),
          ),
          if (receiptEmail != null) ...[
            const SizedBox(height: Gap.md),
            OutlinedButton.icon(
              key: const Key('donate-pay-receipt'),
              onPressed: () async {
                final uri = donationEmail(
                  to: receiptEmail!,
                  subject: l10n.emailSubjectDonate(details.name.trim()),
                  d: details,
                );
                final ok = await openLink(context, ref, uri);
                if (ok && context.mounted) context.go(Routes.handoffSent);
              },
              icon: const Icon(Icons.receipt_long_outlined),
              label: Text(l10n.donatePayReceipt),
            ),
          ],
          const SizedBox(height: Gap.xxl),
        ],
      ),
    );
  }
}
