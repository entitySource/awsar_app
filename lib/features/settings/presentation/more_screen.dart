import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../core/l10n/locale_controller.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../../../l10n/app_localizations.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = ref.watch(localeControllerProvider);
    final user = ref.watch(authControllerProvider);

    Widget tile(IconData icon, String title, String route) => Card(
      child: ListTile(
        minTileHeight: 56,
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.go(route),
      ),
    );

    return PageScaffold(
      title: l10n.moreTitle,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
        children: [
          const SizedBox(height: Gap.sm),
          Card(
            child: ListTile(
              key: const Key('more-account'),
              minTileHeight: 64,
              leading: Icon(user == null ? Icons.login : Icons.account_circle_outlined),
              title: Text(user == null ? l10n.accountSignIn : (user.fullName ?? user.email)),
              subtitle: Text(user == null ? l10n.accountTileSignedOut : user.email),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(Routes.account),
            ),
          ),
          const SizedBox(height: Gap.sm),
          tile(Icons.info_outline, l10n.aboutTitle, Routes.about),
          const SizedBox(height: Gap.sm),
          tile(Icons.photo_library_outlined, l10n.mediaTitle, Routes.media),
          const SizedBox(height: Gap.sm),
          tile(Icons.call_outlined, l10n.contactTitle, Routes.contact),
          SectionHeader(l10n.settingsLanguage),
          RadioGroup<String>(
            groupValue: locale.languageCode,
            onChanged: (v) {
              if (v != null) ref.read(localeControllerProvider.notifier).set(Locale(v));
            },
            child: Card(
              child: Column(
                children: [
                  RadioListTile<String>(value: 'en', title: Text(l10n.languageEnglish)),
                  RadioListTile<String>(value: 'hi', title: Text(l10n.languageHindi)),
                ],
              ),
            ),
          ),
          SectionHeader(l10n.settingsAbout),
          Text(
            l10n.settingsAboutBody,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: Gap.xxl),
        ],
      ),
    );
  }
}
