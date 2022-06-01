import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

import '../../../core/core.dart';

abstract class ILoginRepository {
  Future<Either<Failure, SingleResponse<LoginModel>>> login(
      {required Map<String, dynamic> params});
}
