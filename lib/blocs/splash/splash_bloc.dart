import 'dart:async';

import 'package:lovecook/extensions/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashState> {
  final ISplashRepository _splashRepository;
  final IMeRepository _profileRepository;
  final SharedPreferences _sharedPreferences;

  SplashBloc(
      this._splashRepository, this._profileRepository, this._sharedPreferences);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);
  Future<void> checkToken() async {
    if (_sharedPreferences.token != null &&
        _sharedPreferences.token!.isNotEmpty) {
      final responseEither = await _profileRepository.getInfo();

      responseEither.fold((failure) {
        emit(SplashState(status: SplashStatus.not_authenticated));
      }, (data) {
        if (data.success && data.item != null) {
          _sharedPreferences.saveUser(data.item!);
          emit(SplashState(status: SplashStatus.authenticated));
        } else {
          emit(SplashState(status: SplashStatus.not_authenticated));
        }
      });
    }
  }

  Future<void> loadData() async {
    emitLoading(true);
    await Future.delayed(Duration(seconds: 2));
    emit(
      SplashState(state: state, success: true),
    );
    emitLoading(false);

    // sample call repository
    final responseEither = await _splashRepository.getResponse();
    responseEither.fold((failure) {
      // TODO: handle failure here
    }, (data) {
      // TODO: handle data here
    });

    await Future.delayed(Duration(seconds: 3));

    emitWaiting(true);
    await Future.delayed(Duration(seconds: 2));
    emit(
      SplashState(state: state, error: 'This is base'),
    );
    emitWaiting(false);

    print("Next error event is coming");
    await Future.delayed(Duration(seconds: 2));
    emit(
      SplashState(state: state, error: 'This is base'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
