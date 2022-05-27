import '../responses/responses.dart';
import 'interfaces/interfaces.dart';

class SplashLocalService implements ISplashLocalService {
  SplashLocalService();

  @override
  Future<SplashResponse> getResponse({Map<String, dynamic>? params}) async {
    return Future.value(SplashResponse());
  }
}
