import 'dart:io';

import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/controller/blog/blog_controller.dart';
import 'package:annonify/models/blog/post_model.dart';
import 'package:annonify/view/screens/home/blog/widgets/post_button.dart';
import 'package:annonify/view/widgets/ellipsis_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Post extends StatelessWidget {
  final PostModel post;

  const Post({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final BlogController controller = Get.find<BlogController>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      color: themeController.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar and username
            Row(
              children: [
                _avatar(post.avatar),
                const SizedBox(width: 10),
                Text(
                  post.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),

            //Post Image
            if (post.image != null)
              Image.file(File(post.image!.path.toString())),

            // Post Title
            const SizedBox(height: 10),
            if (post.postTitle != null)
              Text(
                post.postTitle!,
                style: Theme.of(context).textTheme.titleMedium,
              ),

            //Post Description
            if (post.postBody != null)
              EllipsisText(
                text: post.postBody!,
                textStyle: Theme.of(context).textTheme.bodySmall,
              ),

            const SizedBox(height: 10),

            // Like and Comment Buttons
            Row(
              children: [
                PostButton(
                  onTap: () {
                    controller.like(post);
                  },
                  icon: Icons.favorite_border,
                  text: post.likes.toString(),
                ),
                const SizedBox(width: 10),
                PostButton(
                  onTap: () {},
                  icon: Icons.mode_comment_outlined,
                  text: (post.comments != null)
                      ? post.comments!.length.toString()
                      : "0",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _avatar(String? image) {
  return CircleAvatar(
    backgroundColor: Colors.white,
    child: image != null
        ? SvgPicture.string(image)
        : SvgPicture.asset("assets/images/group_logo.svg"),
  );
  // });
}
