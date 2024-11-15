import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/models/blog/post_model.dart';
import 'package:annonify/view/Widgets/ellipsis_text.dart';
import 'package:annonify/view/screens/home/blog/widgets/post.dart';
import 'package:annonify/view/screens/home/blog/widgets/post_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Blogs extends StatelessWidget {
  const Blogs({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    AvatarController avatarController = Get.find<AvatarController>();

    final List<PostModel> posts = [
      PostModel(
        avatar: avatarController.avatars[0].svgData,
        name: "house of Geeks",
        postTitle: "Happy Diwali to all IIITians",
        postBody:
            "While we’re busy debugging code and breaking things in production, Diwali arrives to remind us that not all lights are errors! 💡🎇 Let’s celebrate this festival with fewer bugs and more brightness (literally). May your code run without exceptions, and your projects compile with 0 warnings!  Happy Diwali from the sleep-deprived but ever-enthusiastic House of Geeks",
      ),
      PostModel(
        avatar: avatarController.avatars[0].svgData,
        name: "house of Geeks",
        postTitle: "Happy Diwali to all IIITians",
        postBody:
            "While we’re busy debugging code and breaking things in production, Diwali arrives to remind us that not all lights are errors! 💡🎇 Let’s celebrate this festival with fewer bugs and more brightness (literally). May your code run without exceptions, and your projects compile with 0 warnings!  Happy Diwali from the sleep-deprived but ever-enthusiastic House of Geeks",
      )
    ];

    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Post(
            post: posts[index],
          );
        });
  }
}
