import '../../core/base/base_response.dart';
import 'models.dart';

class CommentModel extends BaseResponse {
  final String? id;
  final User? creator;
  final String? parentId;
  final String? postId;
  final List<String>? photoUrls;
  final String? videoUrl;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  CommentModel({
    this.id,
    this.creator,
    this.parentId,
    this.postId,
    this.photoUrls,
    this.videoUrl,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  CommentModel copyWith({
    String? id,
    User? creator,
    String? parentId,
    String? postId,
    List<String>? photoUrls,
    String? videoUrl,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CommentModel(
        id: id ?? this.id,
        creator: creator ?? this.creator,
        parentId: parentId ?? this.parentId,
        postId: postId ?? this.postId,
        photoUrls: photoUrls ?? this.photoUrls,
        videoUrl: videoUrl ?? this.videoUrl,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return CommentModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator': creator?.toJson(),
      'parentId': parentId,
      'postId': postId,
      'photoUrls': photoUrls,
      'videoUrl': videoUrl,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        id: json['id'] ?? '',
        creator:
            json['creator'] != null ? User.fromJson(json['creator']) : null,
        parentId: json['parentId'],
        postId: json['postId'],
        photoUrls: List<String>.from(json['photoUrls']),
        videoUrl: json['videoUrl'],
        content: json['content'],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]));
  }
  @override
  String toString() {
    return 'CommentModel(id: $id, creator: $creator, parentId: $parentId, postId: $postId, photoUrls: $photoUrls, videoUrl: $videoUrl, content: $content)';
  }

  @override
  List<Object?> get props => [
        id,
        creator,
        parentId,
        postId,
        photoUrls,
        videoUrl,
        content,
      ];
}
