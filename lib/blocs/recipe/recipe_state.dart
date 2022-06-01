// import 'package:equatable/equatable.dart';


// class CommentsState extends Equatable {
//   final List<CommentModel>? comments;
//   final Pagination? pagination;
//   final bool? success;
//   final String? error;
//   CommentsState({
//     bool? success,
//     String? error,
//     CommentsState? state,
//     Pagination? pagination,
//     List<CommentModel>? comments,
//   })  : success = success ?? state?.success,
//         error = error ?? state?.error,
//         pagination = pagination ?? state?.pagination,
//         comments = comments ?? state?.comments;

//   @override
//   List<Object?> get props => [comments, success, error, pagination];
// }