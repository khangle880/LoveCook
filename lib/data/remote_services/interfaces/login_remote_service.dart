import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

abstract class ILoginRemoteService {
  Future<SingleResponse<LoginModel>> login({required Map<String, dynamic> params});
}
