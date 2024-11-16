import 'package:annonify/controller/blog/blog_controller.dart';
import 'package:annonify/models/blog/post_model.dart';
import 'package:annonify/view/screens/home/blog/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Blogs extends StatelessWidget {
  const Blogs({super.key});

  @override
  Widget build(BuildContext context) {
    BlogController controller = Get.put(BlogController());
    return Obx(
      () => ListView.builder(
        itemCount: controller.posts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed('/detailedBlog', arguments: controller.posts[index]);
            },
            child: Post(
              post: controller.posts[index],
            ),
          );
        },
      ),
    );
  }
}
