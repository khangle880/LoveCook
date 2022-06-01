import 'dart:developer';

import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/enum.dart';
import 'package:lovecook/blocs/login/login_state.dart';
import 'package:lovecook/core/core.dart';
import 'package:lovecook/data/data.dart';

class TestApiBloc extends BaseBloc<LoginState> {
  final IUserRepository _loginRepository;
  final IMeRepository _meRepository;
  final IRecipeRepository _recipeRepository;
  final IProductRepository _productRepository;
  final IPostRepository _postRepository;
  final ICommentRepository _commentRepository;
  final ILookupRepository _lookupRepository;
  final ISearchRepository _searchRepository;
  TestApiBloc(
    this._loginRepository,
    this._meRepository,
    this._recipeRepository,
    this._productRepository,
    this._postRepository,
    this._commentRepository,
    this._lookupRepository,
    this._searchRepository,
  );

  Future<void> loadRecipes() async {
    emitLoading(true);
    getRecipes().then((value) {
      if (value.success) {
        log(value.items.toString());
      } else {
        log(value.error?.error ?? '');
      }
    }, onError: (e) {
      log(e.toString());
    }).whenComplete(() => emitLoading(false));
  }

  Future<PagingListResponse> getRecipes() async {
    final responseEither = await _recipeRepository.getRecipes(query: {});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<void> loadProducts() async {
    emitLoading(true);
    getProducts().then((value) {
      if (value.success) {
        log(value.items.toString());
      } else {
        log(value.error?.error ?? '');
      }
    }, onError: (e) {
      log(e.toString());
    }).whenComplete(() => emitLoading(false));
  }

  Future<PagingListResponse> getProducts() async {
    final responseEither = await _productRepository.getProducts(query: {});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<void> loadPosts() async {
    emitLoading(true);
    getPosts().then((value) {
      if (value.success) {
        log(value.items.toString());
      } else {
        log(value.error?.error ?? '');
      }
    }, onError: (e) {
      log(e.toString());
    }).whenComplete(() => emitLoading(false));
  }

  Future<PagingListResponse> getPosts() async {
    final responseEither = await _postRepository.getPosts(query: {});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<void> loadPostReactions() async {
    emitLoading(true);
    getPostReactions().then((value) {
      if (value.success) {
        log(value.items.toString());
      } else {
        log(value.error?.error ?? '');
      }
    }, onError: (e) {
      log(e.toString());
    }).whenComplete(() => emitLoading(false));
  }

  Future<PagingListResponse> getPostReactions() async {
    final responseEither = await _postRepository
        .getReactions(postId: '6293716970970725dc20b07c', query: {});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<void> loadComments() async {
    emitLoading(true);
    getComments().then((value) {
      if (value.success) {
        log(value.items.toString());
      } else {
        log(value.error?.error ?? '');
      }
    }, onError: (e) {
      log(e.toString());
    }).whenComplete(() => emitLoading(false));
  }

  Future<PagingListResponse> getComments() async {
    final responseEither = await _commentRepository.getComments(query: {});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<void> loadSearch() async {
    emitLoading(true);
    getSearch().then((value) {
      if (value.success) {
        log(value.item.toString());
      } else {
        log(value.error?.error ?? '');
      }
    }, onError: (e) {
      log(e.toString());
    }).whenComplete(() => emitLoading(false));
  }

  Future<SingleResponse> getSearch() async {
    final responseEither =
        await _searchRepository.search(query: 'la', searchType: SearchType.all);
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
