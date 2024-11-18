import 'package:annonify/models/blog/comment_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostModel {
  final String? id;
  final String? title;
  final String? description;
  final String? image;
  final int likes;
  final List<CommentModel> comments;
  final DateTime? createdAt;

  PostModel({
    this.id,
    required this.title,
    required this.description,
    this.image,
    this.likes = 0,
    this.comments = const [],
    this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    String? server = dotenv.env['server'];

    return PostModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      image: '$server/${json['image']}',
      likes: json['likes'] ?? 0,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((comment) => CommentModel.fromJson(comment))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
