import 'package:dartz/dartz.dart';
import '../../core/base/base_response.dart';

import '../../core/core.dart';
import '../data.dart';

class LoginRepository extends ILoginRepository {
  final INetworkInfo networkInfo;
  final ILoginRemoteService remoteService;

  LoginRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, SingleResponse<LoginModel>>> login(
      {required Map<String, dynamic> params}) async {
    // final isConnected = await networkInfo.isConnected;
    try {
      final remoteData = await remoteService.login(params: params);
      return Right(remoteData);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
