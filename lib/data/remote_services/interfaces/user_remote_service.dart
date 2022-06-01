import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

abstract class IUserRemoteService {
  Future<SingleResponse<User>> getUser({required String userId});
  Future<PagingListResponse<User>> getUsers(
      {required Map<String, dynamic> query});
  Future<PagingListResponse<RecipeModel>> getLikedRecipes(
      {required String userId, required Map<String, dynamic> query});
  Future<SingleResponse<User>> follow({required String userId});
  Future<SingleResponse<User>> unfollow({required String userId});
}
