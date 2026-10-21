import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'language_toggle.dart';

/// Every screen's scaffold: title on the left, EN | हिं on the right.
class PageScaffold extends StatelessWidget {
  const PageScaffold({super.key, required this.title, required this.body, this.bottomBar});

  final String title;
  final Widget body;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    // Large system text grows the app bar instead of clipping a 2-line
    // (often Hindi) title; the bar itself caps scaling at 1.5x.
    final big = MediaQuery.textScalerOf(context).scale(1) > 1.2;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: big ? 104 : kToolbarHeight,
        title: MediaQuery.withClampedTextScaling(
          maxScaleFactor: 1.5,
          child: Semantics(header: true, child: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis)),
        ),
        actions: [MediaQuery.withClampedTextScaling(maxScaleFactor: 1.3, child: const LanguageToggle())],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomBar,
    );
  }
}

/// A primary action pinned above the system nav bar, in the thumb zone.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerLow,
      shape: Border(top: BorderSide(color: scheme.outlineVariant)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Gap.lg, Gap.md, Gap.lg, Gap.md),
          child: Center(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxContentWidth),
              child: SizedBox(width: double.infinity, child: child),
            ),
          ),
        ),
      ),
    );
  }
}
