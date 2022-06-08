import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../extensions/extensions.dart';
import '../../utils/utils.dart';

abstract class BaseResponse extends Equatable {
  int statusCode;
  ErrorResponse? error;

  bool get success => statusCode == 200 || statusCode == 201;

  BaseResponse({this.statusCode = 0});

  external T fromJson<T extends BaseResponse>(Map<String, dynamic> json);

  toModel() {}
}

class SingleResponse<T extends BaseResponse> extends BaseResponse {
  T? item;

  SingleResponse(this.item) : super();

  @override
  bool get success => statusCode == 200 || statusCode == 201;

  SingleResponse.fromJson(Response response) {
    this.statusCode = response.statusCode ?? 0;

    if (response.data[0] != "{")
      response.data = "{\"value\":\"${response.data}\"}";
    final map = JsonUtils.getMap(response.data);
    if (success) {
      final result = GetIt.I.get<T>();

      item = result.fromJson<T>(map);
    } else {
      this.error = ErrorResponse.fromJson(map);
    }
  }

  @override
  List<Object?> get props => [item];
}

class ListResponse<T extends BaseResponse> extends BaseResponse {
  List<T>? items;

  ListResponse(this.items) : super();

  @override
  bool get success => statusCode == 200 || statusCode == 201;

  ListResponse.fromJson(Response response) {
    this.statusCode = response.statusCode ?? 0;

    if (success) {
      final list = JsonUtils.getMapList(response.data);
      final result = GetIt.I.get<T>();

      items = list.map((map) => result.fromJson<T>(map)).toList();
    } else {
      this.error = ErrorResponse.fromJson(JsonUtils.getMap(response.data));
      items = [];
    }
  }

  @override
  List<Object?> get props => [items];
}

class PagingListResponse<T extends BaseResponse> extends BaseResponse {
  late List<T> items;
  late Pagination pagination;

  PagingListResponse(this.items) : super();

  @override
  bool get success => statusCode == 200 || statusCode == 201;

  PagingListResponse.fromJson(Response response) {
    this.statusCode = response.statusCode ?? 0;

    final map = JsonUtils.getMap(response.data);
    if (success) {
      final list = JsonUtils.getMapList(map['results']);
      final result = GetIt.I.get<T>();

      pagination = Pagination.fromJson(map);
      items = list.map((map) => result.fromJson<T>(map)).toList();
    } else {
      this.error = ErrorResponse.fromJson(map);
      items = [];
    }
  }

  @override
  List<Object?> get props => [items, pagination];
}

class Pagination {
  final int page;
  final int limit;
  final int totalPages;
  final int totalResults;
  Pagination({
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  bool get canLoadMore => page < totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: int.tryParse(json['page'].toString()) ?? 0,
        limit: int.tryParse(json['limit'].toString()) ?? 0,
        totalPages: int.tryParse(json['totalPages'].toString()) ?? 0,
        totalResults: int.tryParse(json['totalResults'].toString()) ?? 0,
      );
}

class ErrorResponse {
  String errorMessage;
  String data;
  List<ErrorMessageResponse> errorMessageList;

  ErrorResponse({
    required this.errorMessageList,
    required this.errorMessage,
    required this.data,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    var errorList = <ErrorMessageResponse>[];
    var errorMessage = '';
    var data = '';

    if (json["message"] is List) {
      final message = List<dynamic>.from((json["message"] ?? []).map((x) => x));
      final firstMessage = message.firstOrDefault();
      if (firstMessage != null) {
        errorList = List<ErrorMessageResponse>.from(
          (firstMessage["message"] ?? []).map(
            (x) => ErrorMessageResponse.fromJson(x),
          ),
        );
      }
    } else if (json["message"] is String) {
      errorMessage = json["message"];
    }
    return ErrorResponse(
      errorMessageList: errorList,
      errorMessage: errorMessage,
      data: data,
    );
  }
}

class ErrorMessageResponse {
  String id;
  String message;

  ErrorMessageResponse({required this.id, required this.message});

  factory ErrorMessageResponse.fromJson(Map<String, dynamic> json) =>
      ErrorMessageResponse(
        id: json['errorMessage'],
        message: json['errorCode'],
      );
}
