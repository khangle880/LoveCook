import 'package:dartz/dartz.dart';
import '../../../core/core.dart';
import '../../responses/responses.dart';

abstract class IChatRepository {
  Future<Either<Failure, List<ChatMessageResponse>>> sendMessage(
      {required Map<String, dynamic> params});
}
