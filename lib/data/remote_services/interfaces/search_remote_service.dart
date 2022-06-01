import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';
import 'package:lovecook/data/enum.dart';

abstract class ISearchRemoteService {
  Future<SingleResponse<SearchModel>> search({
    required String query,
    required SearchType searchType,
    int? page,
    int? limit,
  });
}
