import 'package:dartz/dartz.dart';

import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../data.dart';

abstract class ISearchRepository {
  Future<Either<Failure, SingleResponse<SearchModel>>> search(
      {required Map<String, dynamic> query});
}
