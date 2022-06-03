import '../../../core/base/base_response.dart';
import '../../data.dart';
import '../../enum.dart';

abstract class ISearchRemoteService {
  Future<SingleResponse<SearchModel>> search({
    required String query,
    required SearchType searchType,
    int? page,
    int? limit,
  });
}
