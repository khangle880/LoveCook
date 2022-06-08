import 'package:get_it/get_it.dart';

import '../../core/base/base_response.dart';
import '../../core/core.dart';
import '../data.dart';

class LoginRemoteService implements ILoginRemoteService {
  late final INetworkUtility _networkUtility;

  LoginRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<SingleResponse<LoginModel>> login(
      {required Map<String, dynamic> params}) async {
    final response = await _networkUtility.request('v1/auth/login', Method.POST,
        data: params);

    return SingleResponse<LoginModel>.fromJson(response);
  }
}
