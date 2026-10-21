import 'package:flutter/material.dart';

/// Validates [form] and, if anything is wrong, scrolls the first invalid
/// field into view. Returns true when the form is valid.
bool validateAndRevealFirstError(FormState form) {
  final invalid = form.validateGranularly();
  if (invalid.isEmpty) return true;
  // validateGranularly returns fields in no fixed order; pick the topmost.
  final first = invalid.reduce((a, b) {
    final ya = (a.context.findRenderObject() as RenderBox?)?.localToGlobal(Offset.zero).dy ?? 0;
    final yb = (b.context.findRenderObject() as RenderBox?)?.localToGlobal(Offset.zero).dy ?? 0;
    return ya <= yb ? a : b;
  });
  final ctx = first.context;
  Scrollable.ensureVisible(
    ctx,
    alignment: 0.2,
    duration: MediaQuery.disableAnimationsOf(ctx) ? Duration.zero : const Duration(milliseconds: 250),
    curve: Curves.easeOutCubic,
  );
  return false;
}
