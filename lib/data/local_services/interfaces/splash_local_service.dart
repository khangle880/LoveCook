import '../../responses/responses.dart';

abstract class ISplashLocalService {
  Future<SplashResponse> getResponse({Map<String, dynamic>? params});
}
