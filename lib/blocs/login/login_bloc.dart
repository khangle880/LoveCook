import 'package:shared_preferences/shared_preferences.dart';

import 'login_state.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../../extensions/extensions.dart';

class LoginBloc extends BaseBloc<LoginState> {
  final ILoginRepository _loginRepository;
  final SharedPreferences _sharedPreferences;

  LoginBloc(this._loginRepository, this._sharedPreferences);

  Future<void> checkToken() async {
    if (_sharedPreferences.token == null || _sharedPreferences.token!.isEmpty) {
      emit(LoginState(state: state, success: false));
    }
    emit(LoginState(state: state, success: true));
  }

  Future login(String email, String password) async {
    if (email.length == 0 || password.length == 0) {
      return;
    }
    emitWaiting(true);

    final responseEither = await _loginRepository
        .login(params: {"email": email, "password": password});

    emitWaiting(false);
     return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      if (!data.success) {
        return Future.error(data.error?.errorMessage ?? '');
      }
      if (data.item?.tokens?.access?.token != null &&
          data.item!.tokens!.access!.token!.isNotEmpty) {
        _sharedPreferences.saveToken(data.item!.tokens!.access!.token!);
        _sharedPreferences.saveUser(data.item!.user!);
        print(_sharedPreferences.token);
        print(data.item!.user);
        emit(LoginState(state: state, success: true));
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
  }
}
