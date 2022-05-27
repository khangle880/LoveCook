import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import '../responses/responses.dart';
import 'interfaces/interfaces.dart';

class SplashRemoteService implements ISplashRemoteService {
  late final INetworkUtility _networkUtility;

  SplashRemoteService() : _networkUtility = GetIt.I.get<INetworkUtility>(instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<SplashResponse> getResponse({Map<String, dynamic>? params}) async {
    final response = await _networkUtility.request('v1/api/dummy_end_point', Method.GET);
    return SplashResponse.fromJson(response.data);
  }
}
