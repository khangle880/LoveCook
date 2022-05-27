enum Language { ko, en }

enum Environment { dev, staging, prod }

extension LanguageExt on Language {
  String get code => ['ko', 'en'][index];
}