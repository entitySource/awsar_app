import 'package:flutter/material.dart';

/// Spacing on a 4/8 dp grid.
abstract final class Gap {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

/// Icon sizes as tokens, so icons at the same level match.
abstract final class IconSize {
  static const sm = 18.0;
  static const md = 24.0;
  static const lg = 28.0;
}

/// Widest a column of text gets on tablets and landscape, for readability.
const maxContentWidth = 680.0;

// Colours from design-system/awsar-india/MASTER.md (UI-UX Pro Max:
// "Trust & Authority", Swiss minimal; compassion blue + action orange).
// Primary and CTA are darkened one step from the generated palette so white
// text on them passes WCAG AA (5.4:1 and 5.2:1). The orange is reserved for
// the one donate action per screen.
// TODO(brand): swap primary for the AWSAR logo colour once scraped.
const _light = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0E7490),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFCFFAFE),
  onPrimaryContainer: Color(0xFF164E63),
  secondary: Color(0xFF155E75),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE0F2F7),
  onSecondaryContainer: Color(0xFF164E63),
  tertiary: Color(0xFFC2410C),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFEDD5),
  onTertiaryContainer: Color(0xFF7C2D12),
  error: Color(0xFFB91C1C),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFEE2E2),
  onErrorContainer: Color(0xFF7F1D1D),
  surface: Color(0xFFF5FDFE),
  onSurface: Color(0xFF0F2F3A),
  onSurfaceVariant: Color(0xFF475569),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFFFFFFF),
  surfaceContainer: Color(0xFFEEF8FA),
  surfaceContainerHigh: Color(0xFFE6F3F6),
  surfaceContainerHighest: Color(0xFFDCEDF1),
  outline: Color(0xFF64748B),
  outlineVariant: Color(0xFFCBE3EA),
  inverseSurface: Color(0xFF12303B),
  onInverseSurface: Color(0xFFE0F7FA),
  inversePrimary: Color(0xFF22D3EE),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
);

const _dark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF22D3EE),
  onPrimary: Color(0xFF0F172A),
  primaryContainer: Color(0xFF164E63),
  onPrimaryContainer: Color(0xFFCFFAFE),
  secondary: Color(0xFF67E8F9),
  onSecondary: Color(0xFF0F172A),
  secondaryContainer: Color(0xFF1B3E4A),
  onSecondaryContainer: Color(0xFFCFFAFE),
  tertiary: Color(0xFFFB923C),
  onTertiary: Color(0xFF0F172A),
  tertiaryContainer: Color(0xFF7C2D12),
  onTertiaryContainer: Color(0xFFFFEDD5),
  error: Color(0xFFF87171),
  onError: Color(0xFF0F172A),
  errorContainer: Color(0xFF7F1D1D),
  onErrorContainer: Color(0xFFFEE2E2),
  surface: Color(0xFF0B1E26),
  onSurface: Color(0xFFE0F7FA),
  onSurfaceVariant: Color(0xFFA5B4C3),
  surfaceContainerLowest: Color(0xFF07161C),
  surfaceContainerLow: Color(0xFF12303B),
  surfaceContainer: Color(0xFF102A34),
  surfaceContainerHigh: Color(0xFF173844),
  surfaceContainerHighest: Color(0xFF1E4553),
  outline: Color(0xFF7B93A3),
  outlineVariant: Color(0xFF24505F),
  inverseSurface: Color(0xFFE0F7FA),
  onInverseSurface: Color(0xFF12303B),
  inversePrimary: Color(0xFF0E7490),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
);

// Lexend (headings) and Source Sans 3 (body) have no Devanagari, so Hindi
// falls back to Noto Sans Devanagari.
const _fallback = ['NotoSansDevanagari'];
const _heading = 'Lexend';
const _body = 'SourceSans3';

ThemeData buildTheme({required bool hindi, Brightness brightness = Brightness.light}) {
  final scheme = brightness == Brightness.dark ? _dark : _light;
  // Devanagari matras need extra line height or they clip.
  final lineScale = hindi ? 1.2 : 1.0;
  final base = ThemeData(useMaterial3: true, colorScheme: scheme, brightness: brightness);

  TextStyle? t(
    TextStyle? s, {
    required String family,
    double? size,
    FontWeight? weight,
    double? height,
    double? spacing,
  }) => s?.copyWith(
    fontFamily: family,
    fontFamilyFallback: _fallback,
    fontSize: size,
    fontWeight: weight,
    height: (height ?? s.height ?? 1.3) * lineScale,
    letterSpacing: spacing,
    color: scheme.onSurface,
  );

  final tt = base.textTheme;
  final textTheme = tt.copyWith(
    displaySmall: t(tt.displaySmall, family: _heading, size: 36, weight: FontWeight.w600, height: 1.15, spacing: -0.6),
    headlineMedium: t(
      tt.headlineMedium,
      family: _heading,
      size: 28,
      weight: FontWeight.w600,
      height: 1.2,
      spacing: -0.4,
    ),
    headlineSmall: t(
      tt.headlineSmall,
      family: _heading,
      size: 22,
      weight: FontWeight.w600,
      height: 1.25,
      spacing: -0.2,
    ),
    titleLarge: t(tt.titleLarge, family: _heading, size: 20, weight: FontWeight.w600, height: 1.3, spacing: -0.1),
    titleMedium: t(tt.titleMedium, family: _heading, size: 16, weight: FontWeight.w500, height: 1.35),
    titleSmall: t(tt.titleSmall, family: _body, size: 14, weight: FontWeight.w600, height: 1.4),
    bodyLarge: t(tt.bodyLarge, family: _body, size: 17, height: 1.5),
    bodyMedium: t(tt.bodyMedium, family: _body, size: 15, height: 1.5),
    bodySmall: t(tt.bodySmall, family: _body, size: 13, height: 1.45),
    labelLarge: t(tt.labelLarge, family: _body, size: 15, weight: FontWeight.w600, spacing: 0.1),
    labelMedium: t(tt.labelMedium, family: _body, size: 13, weight: FontWeight.w600, spacing: 0.2),
    labelSmall: t(tt.labelSmall, family: _body, size: 12, weight: FontWeight.w600, spacing: 0.3),
  );

  final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  const minButton = Size(64, 52);

  return base.copyWith(
    textTheme: textTheme,
    scaffoldBackgroundColor: scheme.surface,
    iconTheme: IconThemeData(size: IconSize.md, color: scheme.onSurfaceVariant),
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      shape: Border(bottom: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0))),
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: Gap.xl),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: minButton,
        shape: buttonShape,
        textStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: Gap.xl),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(64, 48),
        shape: buttonShape,
        textStyle: textTheme.labelLarge,
        foregroundColor: scheme.primary,
        side: BorderSide(color: scheme.outline),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: buttonShape,
        textStyle: textTheme.labelLarge,
        foregroundColor: scheme.primary,
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(color: scheme.outline),
      labelStyle: textTheme.labelLarge,
      selectedColor: scheme.primaryContainer,
      checkmarkColor: scheme.onPrimaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: Gap.sm, vertical: Gap.sm),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerLowest,
      labelStyle: textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
      floatingLabelStyle: textTheme.bodyMedium?.copyWith(color: scheme.primary, fontWeight: FontWeight.w600),
      helperStyle: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: Gap.lg, vertical: Gap.lg),
      errorMaxLines: 3,
      helperMaxLines: 3,
    ),
    checkboxTheme: CheckboxThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: scheme.surfaceContainerLow,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surfaceContainerLow,
      indicatorColor: scheme.primaryContainer,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (s) => textTheme.labelMedium?.copyWith(
          color: s.contains(WidgetState.selected) ? scheme.onSurface : scheme.onSurfaceVariant,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (s) => IconThemeData(
          size: IconSize.md,
          color: s.contains(WidgetState.selected) ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
        ),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: scheme.primaryContainer,
        selectedForegroundColor: scheme.onPrimaryContainer,
        side: BorderSide(color: scheme.outline),
        textStyle: textTheme.labelLarge,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.android: FadeForwardsPageTransitionsBuilder()},
    ),
  );
}

/// The one high-emphasis "donate" action per screen, in the CTA orange.
ButtonStyle ctaButtonStyle(ColorScheme scheme) =>
    FilledButton.styleFrom(backgroundColor: scheme.tertiary, foregroundColor: scheme.onTertiary);
