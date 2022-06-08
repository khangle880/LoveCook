import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../data.dart';
import '../responses/responses.dart';

class ChatRepository extends IChatRepository {
  final INetworkInfo networkInfo;
  final IChatRemoteService remoteService;

  ChatRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, List<ChatMessageResponse>>> sendMessage(
      {required Map<String, dynamic> params}) async {
    try {
      final remoteData = await remoteService.sendMessage(params: params);

      return Right(remoteData);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
