import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../responses/login_response.dart';

abstract class ILoginRepository {
  Future<Either<Failure, LoginResponse>> login(
      {required Map<String, dynamic> params});
}
