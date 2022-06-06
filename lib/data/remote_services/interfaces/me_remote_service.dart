import '../../../core/base/base_response.dart';
import '../../data.dart';

abstract class IMeRemoteService {
  Future<SingleResponse<User>> getInfo();
  Future<PagingListResponse<RecipeModel>> getLikedRecipes({required Map<String, dynamic> query});
  Future<PagingListResponse<RecipeModel>> getRecipes({required Map<String, dynamic> query});
  Future<SingleResponse<User>> update({required Map<String, dynamic> data});
  Future<SingleResponse<SingleType>> changePassword(
      {required Map<String, dynamic> data});
  Future<SingleResponse<SingleType>> deleteAccount();
}
