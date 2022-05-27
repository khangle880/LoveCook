import 'dart:ui';

import '../enums.dart';

/// Handle this logic when add/remove locale
class LocaleBuilder {
  static Locale getLocale(String languageCode) {
    switch (languageCode) {
      case 'ko':
        return Locale(Language.ko.code, 'KR');
      case 'en':
        return Locale(Language.en.code, 'US');
      default:
        return Locale(Language.ko.code, 'KR');
    }
  }
}
