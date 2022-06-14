import 'package:get_it/get_it.dart';
import 'package:lovecook/core/base/base.dart';
import 'package:lovecook/data/data.dart';
import 'package:lovecook/extensions/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/base/base_response.dart';
import '../../widgets/pagination_widget/pagination_helper.dart';
import '../app/app_bloc.dart';
import 'follow.dart';

class FollowBloc extends BaseBloc<FollowState> {
  final IUserRepository _userRepository;
  final SharedPreferences _sharedPreferences;
  FollowBloc(this._userRepository, this._sharedPreferences) {
    emit(
        (state ?? FollowState()).copyWith(loggedUser: _sharedPreferences.user));
  }

  setUserId(User user) {
    emit((state ?? FollowState()).copyWith(currrentUserId: user.id));
  }

  PaginationHelper<User>? follwerPagiHelper;
  PaginationHelper<User>? followingPagiHelper;

  Future<PagingListResponse<User>> getFollowers(
      {required String userId, required int page}) async {
    Map<String, dynamic> queryParams = {
      'page': page,
    };
    final responseEither =
        await _userRepository.getFollowers(userId: userId, query: queryParams);
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<PagingListResponse<User>> getFollowings(
      {required String userId, required int page}) async {
    Map<String, dynamic> queryParams = {
      'page': page,
    };
    final responseEither =
        await _userRepository.getFollowings(userId: userId, query: queryParams);
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  handleFollow(User user, bool follow) {
    final handleFollowService =
        follow ? _userRepository.follow : _userRepository.unfollow;

    return handleFollowService(userId: user.id!).then((value) {
      var profile = state!.loggedUser;
      var newProfile;
      if (follow) {
        newProfile = profile?.copyWith(
            followingUsers: profile.followingUsers!..add(user.id!));
      } else {
        newProfile = profile?.copyWith(
            followingUsers: profile.followingUsers!
              ..removeWhere(
                (element) => element == user.id!,
              ));
      }
      emit(state!.copyWith(loggedUser: newProfile));
      GetIt.I.get<AppBloc>().notiFollowChange();
      if (state?.currrentUserId == state?.loggedUser?.id) {
        final newFollowers = follwerPagiHelper!.items
          ..insertUnique(0, user, (e) => e.id == user.id)
          ..toList();
        follwerPagiHelper!.updateList(newFollowers);
        final newFollowings = followingPagiHelper!.items
          ..insertUnique(0, user, (e) => e.id == user.id)
          ..toList();
        followingPagiHelper!.updateList(newFollowings);
      }
    }).catchError((e) {});
  }

  @override
  void dispose() {
    super.dispose();
    followingPagiHelper = null;
    follwerPagiHelper = null;
  }
}
