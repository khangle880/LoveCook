import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../data/data.dart';

extension SharedPreferencesExtension on SharedPreferences {
  void saveToken(String token) {
    this.setString(SharedPreferencesKey.token, token);
  }

  String? get token {
    return this.getString(SharedPreferencesKey.token);
  }

  void saveUser(User user) {
    final String user_encode = jsonEncode(user);
    this.setString(SharedPreferencesKey.accountInfo, user_encode);
  }

  User? get user {
    final encode_user = this.getString(SharedPreferencesKey.accountInfo);
    if (encode_user != null && encode_user.isNotEmpty) {
      final User user = User.fromJson(jsonDecode(encode_user));
      return user;
    } else {
      return null;
    }
  }
}
