import 'package:get_it/get_it.dart';
import '../../core/base/base_response.dart';
import '../../core/core.dart';
import '../data.dart';
import '../enum.dart';

class SearchRemoteService implements ISearchRemoteService {
  late final INetworkUtility _networkUtility;

  SearchRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<SingleResponse<SearchModel>> search(
      {required String query,
      required SearchType searchType,
      int? page,
      int? limit}) async {
    Map<String, dynamic> queryParams = {
      'q': query,
      'type': searchType.shortString,
    };
    if (page != null) queryParams.putIfAbsent('page', () => page);
    if (limit != null) queryParams.putIfAbsent('limit', () => limit);
    final response = await _networkUtility.request('v1/search/', Method.GET,
        queryParameters: queryParams);

    return SingleResponse<SearchModel>.fromJson(response);
  }
}
