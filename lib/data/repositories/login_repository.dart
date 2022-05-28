import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../data.dart';
import '../responses/login_response.dart';

class LoginRepository extends ILoginRepository {
  final INetworkInfo networkInfo;
  final ILoginRemoteService remoteService;

  LoginRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, LoginResponse>> login(
      {required Map<String, dynamic> params}) async {
    // final isConnected = await networkInfo.isConnected;
    try {
      final remoteData = await remoteService.login(params: params);
      print('Helloe');
      return Right(remoteData);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
