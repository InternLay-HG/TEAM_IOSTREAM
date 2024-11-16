import 'package:annonify/models/blog/post_model.dart';
import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  final PostModel post;

  const PostImage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      post.image!,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child; // Image has loaded
        } else {
          // Show a loading indicator while the image is loading
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        }
      },
      errorBuilder: (context, error, stackTrace) {
        // Display a fallback image or a widget on error
        return const Center(
          child: Column(
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
                size: 50,
              ),
              Text("Error loading image"),
            ],
          ),
        );
      },
    );
  }
}
