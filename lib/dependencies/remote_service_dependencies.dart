import 'package:get_it/get_it.dart';

import '../data/data.dart';

class RemoteServiceDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<ISplashRemoteService>(() => SplashRemoteService());
    injector.registerFactory<ILoginRemoteService>(() => LoginRemoteService());
    injector.registerFactory<IRecipeRemoteService>(() => RecipeRemoteService());
    injector.registerFactory<IUserRemoteService>(() => UserRemoteService());
    injector.registerFactory<IMeRemoteService>(() => MeRemoteService());
    injector.registerFactory<IProductRemoteService>(() => ProductRemoteService());
    injector.registerFactory<IPostRemoteService>(() => PostRemoteService());
    injector.registerFactory<ICommentRemoteService>(() => CommentRemoteService());
    injector.registerFactory<ILookupRemoteService>(() => LookupRemoteService());
    injector.registerFactory<ISearchRemoteService>(() => SearchRemoteService());
    injector.registerFactory<IChatRemoteService>(() => ChatRemoteService());
  }
}
