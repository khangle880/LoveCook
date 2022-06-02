import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

extension SharedPreferencesExtension on SharedPreferences {
  void saveToken(String token) {
    this.setString(SharedPreferencesKey.token, token);
  }

  String? get token {
    return this.getString(SharedPreferencesKey.token);
  }
}
