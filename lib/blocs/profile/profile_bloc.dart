import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../extensions/extensions.dart';
import '../../core/base/base_bloc.dart';
import '../../data/data.dart';
import '../blocs.dart';

class ProfileBloc extends BaseBloc<ProfileState> {
  final IMeRepository _profileRepository;
  final IUserRepository _userRepository;
  final SharedPreferences _sharedPreferences;
  final IUploadRepository _uploadRepository;

  ProfileBloc(this._profileRepository, this._sharedPreferences,
      this._userRepository, this._uploadRepository) {
    emit(ProfileState(state: state, loggedUser: _sharedPreferences.user));
  }

  Stream<User?> get user => stateStream.map((event) => event.user);

  setUser(User user) async {
    final responseEither = await _userRepository.getUser(userId: user.id!);

    responseEither.fold((failure) {}, (data) {
      if (data.item != null) {
        emit(ProfileState(state: state, success: true, user: data.item));
      }
    });
  }

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

  Future<String> uploadImage(String filePath) async {
    final imageResponseEither =
        await _uploadRepository.uploadFileData(filePath: filePath);
    return imageResponseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data.item?.urls?[0] ?? '';
    });
  }

  void updateAvatar(String filePath) async {
    final path = await uploadImage(filePath);
    changeProfile(profile: {'avatarUrl': path});
  }

  handleFollow(User user, bool follow) {
    final handleFollowService =
        follow ? _userRepository.follow : _userRepository.unfollow;

    return handleFollowService(userId: user.id!).then((value) {
      var currentUser = state!.user;
      var newUser;
      if (follow) {
        newUser = currentUser?.copyWith(
            followerUsers: currentUser.followerUsers!..add(user.id!));
      } else {
        newUser = currentUser?.copyWith(
            followerUsers: currentUser.followerUsers!
              ..removeWhere(
                (element) => element == user.id!,
              ));
      }
      emit(ProfileState(state: state, user: newUser));
      GetIt.I.get<AppBloc>().notiFollowChange();
    }).catchError((e) {});
  }

  Future logout() async {
    return _sharedPreferences.clear();
  }
}
