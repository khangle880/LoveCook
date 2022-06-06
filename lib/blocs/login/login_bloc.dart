import 'package:shared_preferences/shared_preferences.dart';

import 'login_state.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../../extensions/extensions.dart';

class LoginBloc extends BaseBloc<LoginState> {
  final ILoginRepository _loginRepository;
  final IMeRepository _profileRepository;
  final SharedPreferences _sharedPreferences;

  LoginBloc(
      this._loginRepository, this._profileRepository, this._sharedPreferences);

  Future<void> checkToken() async {
    if (_sharedPreferences.token == null || _sharedPreferences.token!.isEmpty) {
      emit(LoginState(state: state, success: false));
    }
    emit(LoginState(state: state, success: true));
  }

  Future<void> login(String email, String password) async {
    if (email.length == 0 || password.length == 0) {
      return;
    }

    final responseEither = await _loginRepository
        .login(params: {"email": email, "password": password});

    responseEither.fold((failure) {}, (data) {
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
