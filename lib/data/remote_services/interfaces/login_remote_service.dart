import '../../responses/responses.dart';

abstract class ILoginRemoteService {
  Future<LoginResponse> login({required Map<String, dynamic> params});
}
