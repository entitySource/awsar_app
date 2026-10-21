import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/prefs_provider.dart';

const supportedLocales = [Locale('en'), Locale('hi')];

class LocaleController extends Notifier<Locale> {
  static const _key = 'locale';

  @override
  Locale build() {
    final saved = ref.watch(prefsProvider).getString(_key);
    return supportedLocales.firstWhere((l) => l.languageCode == saved, orElse: () => supportedLocales.first);
  }

  Future<void> set(Locale locale) async {
    state = locale;
    await ref.read(prefsProvider).setString(_key, locale.languageCode);
  }

  Future<void> toggle() => set(state.languageCode == 'en' ? const Locale('hi') : const Locale('en'));
}

final localeControllerProvider = NotifierProvider<LocaleController, Locale>(LocaleController.new);
