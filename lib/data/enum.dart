import 'package:collection/collection.dart';

enum SearchType { recipe, post, user, product, all }

enum Gender { male, female, other }

enum UserRole { user, admin }

enum ViewRange { private, public }

enum Level { eazy, medium, hard }

extension EnumExt on Enum {
  String get shortString => this.toString().split('.').last.toUpperCase();
}

T? enumFromString<T>(Iterable<T> values, String? value) {
  if (value == null) return null;
  return values.firstWhereOrNull((type) =>
      type.toString().split(".").last.toLowerCase() == value.toLowerCase());
}

extension GenderExt on Gender {
  String get shortString => this.toString().split('.').last.toLowerCase();
}
