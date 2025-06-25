class Comment {
  final String? id;
  final String reviewId;
  final String userId;
  final String? userName;
  final String? userImage;
  final String? parentId;
  final String content;
  final DateTime createdAt;

  Comment({
     this.id,
    required this.reviewId,
    required this.userId,
    this.userName,
    this.userImage,
    this.parentId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      reviewId: json['review_id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String?,
      userImage: json['user_image'] as String?,
      parentId: json['parent_id'] as String?,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'review_id': reviewId,
      'user_id': userId,
      'user_name': userName,
      'user_image': userImage,
      'parent_id': parentId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
