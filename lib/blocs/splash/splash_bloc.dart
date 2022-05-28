import 'dart:async';

import '../../core/core.dart';
import '../../data/data.dart';
import 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashState> {
  final ISplashRepository _splashRepository;

  SplashBloc(this._splashRepository);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);

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
