import 'package:dartz/dartz.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';
import 'package:lovecook/data/enum.dart';

import '../../../core/core.dart';

abstract class ISearchRepository {
  Future<Either<Failure, SingleResponse<SearchModel>>> search({
    required String query,
    required SearchType searchType,
    int? page,
    int? limit,
  });
}
