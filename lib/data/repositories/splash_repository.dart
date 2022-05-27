import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../local_services/local_services.dart';
import '../remote_services/remote_services.dart';
import '../responses/responses.dart';
import 'interfaces/interfaces.dart';

class SplashRepository extends ISplashRepository {
  final ISplashRemoteService remoteService;
  final ISplashLocalService localService;
  final INetworkInfo networkInfo;

  SplashRepository({
    required this.remoteService,
    required this.localService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SplashResponse>> getResponse({Map<String, dynamic>? params}) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.getResponse();
        // TODO: cache remote data here
        return Right(remoteData);
      } else {
        final localData = await localService.getResponse();
        return Right(localData);
      }
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
