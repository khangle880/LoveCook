import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base_response.dart';
import '../../../core/core.dart';
import '../../responses/responses.dart';

abstract class IChatRepository {
  Future<Either<Failure, ListResponse<ChatMessageResponse>>> sendMessage(
      {required Map<String, dynamic> params});
}
