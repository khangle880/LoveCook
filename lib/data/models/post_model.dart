import '../../core/base/base_response.dart';
import '../enum.dart';

import 'models.dart';

class PostModel extends BaseResponse {
  final String? id;
  final User? creator;
  final List<String>? photoUrls;
  final String? videoUrl;
  final ViewRange? viewRange;
  final String? backgroundColor;
  final String? content;
  final List<String>? tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  PostModel({
    this.id,
    this.creator,
    this.photoUrls,
    this.videoUrl,
    this.viewRange,
    this.backgroundColor,
    this.content,
    this.tags,
    this.createdAt,
    this.updatedAt,
  });

  PostModel copyWith({
    String? id,
    User? creator,
    List<String>? photoUrls,
    String? videoUrl,
    ViewRange? viewRange,
    String? backgroundColor,
    String? content,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostModel(
        id: id ?? this.id,
        creator: creator ?? this.creator,
        photoUrls: photoUrls ?? this.photoUrls,
        videoUrl: videoUrl ?? this.videoUrl,
        viewRange: viewRange ?? this.viewRange,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        content: content ?? this.content,
        tags: tags ?? this.tags,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  @override
  String toString() {
    return 'PostModel(id: $id, creator: $creator, photoUrls: $photoUrls, videoUrl: $videoUrl, viewRange: $viewRange, backgroundColor: $backgroundColor, content: $content, tags: $tags)';
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return PostModel.fromJson(json) as T;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator': creator?.toJson(),
      'photoUrls': photoUrls,
      'videoUrl': videoUrl,
      'viewRange': viewRange?.shortString,
      'backgroundColor': backgroundColor,
      'content': content,
      'tags': tags,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'] ?? '',
        creator:
            json['creator'] != null ? User.fromJson(json['creator']) : null,
        photoUrls: List<String>.from(json['photoUrls']),
        videoUrl: json['videoUrl'],
        viewRange: json['viewRange'] != null
            ? enumFromString(ViewRange.values, json['viewRange'])
            : null,
        backgroundColor: json['backgroundColor'],
        content: json['content'],
        tags: List<String>.from(json['tags']),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]));
  }

  @override
  List<Object?> get props => [
        id,
        creator,
        photoUrls,
        videoUrl,
        viewRange,
        backgroundColor,
        content,
        tags,
        createdAt,
        updatedAt,
      ];
}
