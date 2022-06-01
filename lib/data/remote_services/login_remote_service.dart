import 'package:get_it/get_it.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/core/core.dart';
import 'package:lovecook/data/data.dart';

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
