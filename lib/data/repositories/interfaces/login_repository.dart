import 'package:dartz/dartz.dart';
import '../../../core/base/base_response.dart';
import '../../data.dart';

import '../../../core/core.dart';

abstract class ILoginRepository {
  Future<Either<Failure, SingleResponse<LoginModel>>> login(
      {required Map<String, dynamic> params});
  Future<Either<Failure, SingleResponse<LoginModel>>> register(
      {required Map<String, dynamic> params});
}
