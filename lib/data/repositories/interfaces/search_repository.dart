import 'package:dartz/dartz.dart';

import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../data.dart';
import '../../enum.dart';

abstract class ISearchRepository {
  Future<Either<Failure, SingleResponse<SearchModel>>> search({
    required String query,
    required SearchType searchType,
    int? page,
    int? limit,
  });
}
