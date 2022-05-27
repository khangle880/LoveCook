import '../enums.dart';

extension EnvironmentExtension on Environment {
  String get value => ['dev', 'staging', 'prod'][index];
}