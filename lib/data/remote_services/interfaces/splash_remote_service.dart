import '../../../data/responses/responses.dart';

abstract class ISplashRemoteService {
  Future<SplashResponse> getResponse({Map<String, dynamic>? params});
}
