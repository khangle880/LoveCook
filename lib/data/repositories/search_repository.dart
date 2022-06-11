import 'package:dartz/dartz.dart';

import '../../core/base/base_response.dart';
import '../../core/core.dart';
import '../data.dart';

class SearchRepository extends ISearchRepository {
  final INetworkInfo networkInfo;
  final ISearchRemoteService remoteService;

  SearchRepository({required this.networkInfo, required this.remoteService});

  @override
  Future<Either<Failure, SingleResponse<SearchModel>>> search(
      {required Map<String, dynamic> query}) async {
    try {
      final result = await remoteService.search(query: query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(exception: e));
    } on Exception catch (e) {
      return Left(UnknownFailure(exception: e));
    }
  }
}
