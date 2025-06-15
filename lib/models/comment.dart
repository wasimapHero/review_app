class Comment {
  final int id;
  final String text;
  final List<Comment> replies;

  Comment({required this.id, required this.text, this.replies = const []});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      text: json['text'],
      replies: [],
    );
  }
}