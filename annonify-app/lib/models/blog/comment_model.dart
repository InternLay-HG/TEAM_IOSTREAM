class CommentModel {
  final String id;
  final String content;
  final String postId;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.content,
    required this.postId,
    required this.createdAt,
  });

  // Factory method to create a CommentModel from JSON data
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      content: json['content'],
      postId: json['postId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Method to convert a CommentModel to JSON format for API requests
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'postId': postId,
    };
  }
}
