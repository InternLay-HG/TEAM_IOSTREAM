import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/controller/blog/blog_controller.dart';
import 'package:annonify/view/screens/home/blog/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Blogs extends StatelessWidget {
  const Blogs({super.key});

  @override
  Widget build(BuildContext context) {
    AvatarController avatarController = Get.find<AvatarController>();
    BlogController controller = Get.put(BlogController());
    return Obx(
      () => ListView.builder(
        itemCount: controller.posts.length,
        itemBuilder: (context, index) {
          return Post(
            post: controller.posts[index],
          );
        },
      ),
    );
  }
}
