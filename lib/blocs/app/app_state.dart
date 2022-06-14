import 'dart:ui';

import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final Locale? locale;
  final bool? followChange;
  final bool? clearMessage;

  AppState(
      {AppState? state, Locale? locale, bool? followChange, bool? clearMessage})
      : locale = locale ?? state?.locale ?? Locale('en'),
        followChange = followChange ?? state?.followChange,
        clearMessage = clearMessage ?? state?.clearMessage;

  @override
  List<Object?> get props => [locale, followChange, clearMessage];
}
