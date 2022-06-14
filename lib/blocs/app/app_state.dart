import 'dart:ui';

import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final Locale? locale;
  final bool? followChange;

  AppState({
    AppState? state,
    Locale? locale,
    bool? followChange,
  })  : locale = locale ?? state?.locale ?? Locale('en'),
        followChange = followChange ?? state?.followChange;

  @override
  List<Object?> get props => [locale, followChange];
}
