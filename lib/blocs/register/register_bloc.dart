import 'package:lovecook/blocs/register/register_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../../../extensions/extensions.dart';

class RegisterBloc extends BaseBloc<RegisterState> {
  final ILoginRepository _loginRepository;
  final SharedPreferences _sharedPreferences;

  RegisterBloc(this._loginRepository, this._sharedPreferences);

  Future register(String email, String password) async {
    if (email.length == 0 || password.length == 0) {
      return;
    }
    emitWaiting(true);

    final responseEither = await _loginRepository
        .register(params: {"name": email.split("@")[0],"email": email, "password": password});

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
        emit(RegisterState(state: state, success: true));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
