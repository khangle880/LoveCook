import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../responses/responses.dart';

abstract class ISplashRepository {
  Future<Either<Failure, SplashResponse>> getResponse({Map<String, dynamic>? params});
}
