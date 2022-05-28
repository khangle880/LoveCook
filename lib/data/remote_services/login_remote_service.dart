import 'package:get_it/get_it.dart';
import 'package:viiv/core/core.dart';
import 'package:viiv/data/data.dart';
import 'package:viiv/data/responses/login_response.dart';

class LoginRemoteService implements ILoginRemoteService {
  late final INetworkUtility _networkUtility;

  LoginRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<LoginResponse> login({required Map<String, dynamic> params}) async {
    final response = await _networkUtility.request('v1/auth/login', Method.GET,
        data: params);

    return LoginResponse.fromJson(response.data);
  }
}
