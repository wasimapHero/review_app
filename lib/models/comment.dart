class Comment {
  final String id;
  final int reviewId;
  final String userId;
  final String? userName;
  final String? userImage;
  final String? parentId;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.reviewId,
    required this.userId,
     this.userName,
     this.userImage,
    this.parentId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      reviewId: map['review_id'],
      userId: map['user_id'],
      userName: map['user_name'],
      userImage: map['user_image'],
      parentId: map['parent_id'],
      content: map['content'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'review_id': reviewId,
      'user_id': userId,
      'parent_id': parentId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
