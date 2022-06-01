import 'package:dio/dio.dart';
import 'package:lovecook/core/base/base_response.dart';

import 'models.dart';

class SearchModel extends BaseResponse {
  final PagingListResponse<RecipeModel>? recipes;
  final PagingListResponse<PostModel>? posts;
  final PagingListResponse<User>? users;
  final PagingListResponse<ProductModel>? products;
  SearchModel({
    this.recipes,
    this.posts,
    this.users,
    this.products,
  });

  SearchModel copyWith({
    PagingListResponse<RecipeModel>? recipes,
    PagingListResponse<PostModel>? posts,
    PagingListResponse<User>? users,
    PagingListResponse<ProductModel>? products,
  }) {
    return SearchModel(
      recipes: recipes ?? this.recipes,
      posts: posts ?? this.posts,
      users: users ?? this.users,
      products: products ?? this.products,
    );
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return SearchModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'recipes': recipes,
      'posts': posts,
      'users': users,
      'products': products,
    };
  }

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      recipes: PagingListResponse<RecipeModel>.fromJson(
        Response(
            data: json['recipes'],
            requestOptions: RequestOptions(path: ''),
            statusCode: 200),
      ),
      posts: PagingListResponse<PostModel>.fromJson(
        Response(
            data: json['posts'],
            requestOptions: RequestOptions(path: ''),
            statusCode: 200),
      ),
      users: PagingListResponse<User>.fromJson(
        Response(
            data: json['users'],
            requestOptions: RequestOptions(path: ''),
            statusCode: 200),
      ),
      products: PagingListResponse<ProductModel>.fromJson(
        Response(
            data: json['products'],
            requestOptions: RequestOptions(path: ''),
            statusCode: 200),
      ),
    );
  }
  @override
  String toString() {
    return 'SearchModel(recipes: $recipes, posts: $posts, users: $users, products: $products)';
  }
}
