import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider =
    StateNotifierProvider<SettingsStateNotifier, SettingsState>(
        (ref) => SettingsStateNotifier(SettingsState()));

class SettingsStateNotifier extends StateNotifier<SettingsState> {
  SettingsStateNotifier(super.state);

  void setLocale(Locale locale) {
    state = SettingsState(locale: locale);
  }
}

class SettingsState {
  final Locale? locale;

  SettingsState({this.locale});
}
