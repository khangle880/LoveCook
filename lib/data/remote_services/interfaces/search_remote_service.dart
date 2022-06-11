import '../../../core/base/base_response.dart';
import '../../data.dart';

abstract class ISearchRemoteService {
  Future<SingleResponse<SearchModel>> search({
    required Map<String, dynamic> query,
  });
}
