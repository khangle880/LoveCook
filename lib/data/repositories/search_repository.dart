import 'package:dartz/dartz.dart';
import '../../core/base/base_response.dart';
import '../enum.dart';

import '../../core/core.dart';
import '../data.dart';

class SearchRepository extends ISearchRepository {
  final INetworkInfo networkInfo;
  final ISearchRemoteService remoteService;

  SearchRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, SingleResponse<SearchModel>>> search({
    required String query,
    required SearchType searchType,
    int? page,
    int? limit,
  }) async {
    try {
      final result = await remoteService.search(
          query: query, searchType: searchType, limit: limit, page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }
}
