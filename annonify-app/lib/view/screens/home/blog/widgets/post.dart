
import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/controller/blog/blog_controller.dart';
import 'package:annonify/models/blog/post_model.dart';
import 'package:annonify/view/screens/home/blog/widgets/post_button.dart';
import 'package:annonify/view/screens/home/blog/widgets/post_image.dart';
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
      margin: const EdgeInsets.symmetric(vertical: 5),
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
                _avatar(),
                const SizedBox(width: 10),
                Text(
                  "User",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),

            //Post Image
            if (post.image != null) PostImage(post: post),

            // Post Title
            const SizedBox(height: 10),
            if (post.title != null)
              EllipsisText(
                text: post.title!,
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),

            //Post Description
            if (post.description != null)
              EllipsisText(
                text: post.description!,
                textStyle: Theme.of(context).textTheme.bodySmall,
              ),

            const SizedBox(height: 10),

            // Like and Comment Buttons
            Row(
              children: [
                PostButton(
                  onTap: () {
                    if (post.id != null) controller.like(post.id!);
                  },
                  icon: Icons.favorite_border,
                  text: post.likes.toString(),
                ),
                const SizedBox(width: 10),
                PostButton(
                  onTap: () {},
                  icon: Icons.mode_comment_outlined,
                  text: post.comments.length.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _avatar() {
  AvatarController avatarController = Get.find<AvatarController>();
  return CircleAvatar(
    maxRadius: 15,
    backgroundColor: Colors.white,
    child: avatarController.avatars[0].svgData != null
        ? SvgPicture.string(avatarController.avatars[0].svgData!)
        : SvgPicture.asset("assets/images/group_logo.svg"),
  );
}
