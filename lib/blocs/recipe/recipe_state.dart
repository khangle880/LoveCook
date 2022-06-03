// import 'package:equatable/equatable.dart';
// import 'package:lovecook/data/data.dart';

// class RecipeState extends Equatable {
//   final List<RecipeModel>? recipes;
//   final bool? success;
//   final String? error;
//   CommentsState({
//     bool? success,
//     String? error,
//     RecipeState? state,
//     List<CommentModel>? comments,
//   })  : success = success ?? state?.success,
//         error = error ?? state?.error,
//         comments = comments ?? state?.comments;

//   @override
//   List<Object?> get props => [comments, success, error, pagination];
// }