import 'dart:io';
import 'comment_model.dart';

class PostModel {
  String? avatar;
  String name;
  File? image;
  String? postTitle;
  String? postBody;
  int likes;
  List<Comment>? comments;

  PostModel({
    this.avatar,
    required this.name,
    this.image,
    this.postTitle,
    this.postBody,
    this.likes = 0,
    this.comments,
  });
}
