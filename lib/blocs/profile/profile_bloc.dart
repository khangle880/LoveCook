import 'package:shared_preferences/shared_preferences.dart';

import '../../../extensions/extensions.dart';
import '../../core/base/base_bloc.dart';
import '../../data/data.dart';
import '../blocs.dart';
import 'profile.dart';

class ProfileBloc extends BaseBloc<ProfileState> {
  final IMeRepository _profileRepository;
  final SharedPreferences _sharedPreferences;

  ProfileBloc(this._profileRepository, this._sharedPreferences);

  Stream<User?> get user => stateStream.map((event) => event.user);

  Future<void> checkProfile() async {
    final responseEither = await _profileRepository.getInfo();

    responseEither.fold((failure) {}, (data) {
      if (data.item != null) {
        _sharedPreferences.saveUser(data.item!);
        emit(ProfileState(state: state, success: true, user: data.item));
      }
    });
  }

  Future<void> changeProfile({required Map<String, dynamic> profile}) async {
    if (profile.isEmpty) {
      return;
    } else {
      final responseEither = await _profileRepository.update(data: profile);

      responseEither.fold((failure) {}, (data) {
        if (data.item != null) {
          _sharedPreferences.saveUser(data.item!);
          emit(ProfileState(state: state, success: true, user: data.item));
        }
      });
    }
  }
}
