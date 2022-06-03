enum Language { ko, en }

enum Environment { dev, staging, prod }

enum ChatMessageType { text, image, button }

class SenderType {
  static const String chatbot = 'chatbot';
  static const String user = 'user';
}

extension LanguageExt on Language {
  String get code => ['ko', 'en'][index];
}

enum ButtonSize { large, medium, small }
