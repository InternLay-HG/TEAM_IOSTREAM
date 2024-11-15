class PostModel {
  String? avatar;
  String name;
  String? image;
  String? postTitle;
  String? postBody;
  int likes;

  PostModel({
    this.avatar,
    required this.name,
    this.image,
    this.postTitle,
    this.postBody,
    this.likes = 0,
  });
}
