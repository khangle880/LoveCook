import 'package:shared_preferences/shared_preferences.dart';
import 'package:lovecook/blocs/login/login_state.dart';
import 'package:lovecook/core/core.dart';
import 'package:lovecook/data/data.dart';
import '../../../extensions/extensions.dart';

class LoginBloc extends BaseBloc<LoginState> {
  final ILoginRepository _loginRepository;
  final SharedPreferences _sharedPreferences;

  LoginBloc(this._loginRepository, this._sharedPreferences);

  Future<void> checkToken() async {
    if (_sharedPreferences.token != null &&
        _sharedPreferences.token!.isNotEmpty) {
      emit(LoginState(state: state, success: true));
    }
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
