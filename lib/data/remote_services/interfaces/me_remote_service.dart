import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

abstract class IMeRemoteService {
  Future<SingleResponse<User>> getInfo();
  Future<PagingListResponse<RecipeModel>> getLikedRecipe({required Map<String, dynamic> query});
  Future<SingleResponse<User>> update({required Map<String, dynamic> data});
  Future<SingleResponse<SingleType>> changePassword(
      {required Map<String, dynamic> data});
  Future<SingleResponse<SingleType>> deleteAccount();
}
