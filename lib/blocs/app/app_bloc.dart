import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../core/core.dart';
import '../../enums.dart';
import '../../theme/theme.dart';
import 'app_state.dart';

class AppBloc extends BaseBloc<AppState> {
  late SharedPreferences _prefs;

  AppBloc() {
    _prefs = GetIt.I.get<SharedPreferences>();
    emit(AppState(
      locale: LocaleBuilder.getLocale(Language.en.code),
    ));
  }
  Stream<bool?> get followStream =>
      stateStream.map((event) => event.followChange);
  Stream<bool?> get clearMessageStream =>
      stateStream.map((event) => event.clearMessage);

  Future<void> init() async {
    final languageCode = _prefs.getString(SharedPreferencesKey.languageCode);

    emit(AppState(
      state: state,
      locale: LocaleBuilder.getLocale(languageCode ?? Language.en.code),
    ));
  }

  notiFollowChange() {
    emit(AppState(state: state, followChange: true));
  }

  clearMessage() {
    emit(AppState(state: state, clearMessage: true));
  }

  Future<void> changeLanguage(String languageCode) async {
    await _prefs.setString(SharedPreferencesKey.languageCode, languageCode);
    emit(AppState(
      locale: LocaleBuilder.getLocale(languageCode),
      state: state,
    ));
  }
}
