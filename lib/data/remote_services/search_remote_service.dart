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
      {required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request('v1/search/', Method.GET,
        queryParameters: query);

    return SingleResponse<SearchModel>.fromJson(response);
  }
}
