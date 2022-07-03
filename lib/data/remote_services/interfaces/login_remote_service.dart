import '../../../core/base/base_response.dart';
import '../../data.dart';

abstract class ILoginRemoteService {
  Future<SingleResponse<LoginModel>> login({required Map<String, dynamic> params});

  Future<SingleResponse<LoginModel>> register({required Map<String, dynamic> params});
}
