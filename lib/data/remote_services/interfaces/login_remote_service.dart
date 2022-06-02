import '../../../core/base/base_response.dart';
import '../../data.dart';

abstract class ILoginRemoteService {
  Future<SingleResponse<LoginModel>> login({required Map<String, dynamic> params});
}
