import 'package:flutter/material.dart';

/// "Fix the highlighted fields" shown above a form's primary button, so it
/// never covers the button the way a snackbar would. Announced by TalkBack.
class FormErrorHint extends StatelessWidget {
  const FormErrorHint(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Icon(Icons.error_outline, size: 18, color: scheme.error),
            const SizedBox(width: 4),
            Expanded(
              child: Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.error)),
            ),
          ],
        ),
      ),
    );
  }
}
