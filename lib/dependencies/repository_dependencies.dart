import 'package:get_it/get_it.dart';
import 'package:lovecook/data/repositories/upload_repository.dart';

import '../data/data.dart';

class RepositoryDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<ISplashRepository>(() => SplashRepository(
          remoteService: injector(),
          localService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<ILoginRepository>(() => LoginRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<IRecipeRepository>(() => RecipeRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<IUserRepository>(() => UserRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<IMeRepository>(() => MeRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<IProductRepository>(() => ProductRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<IPostRepository>(() => PostRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<ICommentRepository>(() => CommentRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<ILookupRepository>(() => LookupRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<ISearchRepository>(() => SearchRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<IChatRepository>(() =>
        ChatRepository(networkInfo: injector(), remoteService: injector()));
    injector
        .registerFactory<IUploadRepository>(() => UploadRepository(injector()));
  }
}
