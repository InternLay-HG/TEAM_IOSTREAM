
import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/controller/blog/blog_controller.dart';
import 'package:annonify/models/blog/post_model.dart';
import 'package:annonify/view/screens/home/blog/widgets/comment.dart';
import 'package:annonify/view/screens/home/blog/widgets/post_image.dart';
import 'package:annonify/view/widgets/ellipsis_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DetailedBlog extends StatelessWidget {
  const DetailedBlog({super.key});

  @override
  Widget build(BuildContext context) {
    final PostModel post = Get.arguments;
    ThemeController themeController = Get.find<ThemeController>();
    BlogController controller = Get.find<BlogController>();
    int index = controller.posts.indexWhere((element) => element.id == post.id);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _postSection(context, post),
                      const SizedBox(height: 20),
                      _commentsSection(controller.posts[index]),
                    ],
                  ),
                ),
              ),
            ),
            _commentsField(context, controller, post),
          ],
        ),
      ),
    );
  }
}

Widget _postSection(BuildContext context, PostModel post) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (post.title != null)
        Text(
          post.title!,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      const SizedBox(height: 15),

      //Post Image
      if (post.image != null)
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: PostImage(post: post),
        ),

      const SizedBox(height: 15),

      //Post Description
      if (post.description != null)
        Text(
          post.description!,
          style: Theme.of(context).textTheme.displayMedium,
        ),
    ],
  );
}

Widget _commentsSection(PostModel post) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: post.comments.length,
    itemBuilder: (context, index) {
      return CommentCard(
        content: post.comments[index].content,
      );
    },
  );
}

Widget _commentsField(
    BuildContext context, BlogController controller, PostModel post) {
  ThemeController themeController = Get.find<ThemeController>();

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    decoration: BoxDecoration(
      color: themeController.contentBG,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            style: Theme.of(context).textTheme.displaySmall,
            cursorColor: themeController.secondaryTextColor,
            controller: controller.commentController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              hintText: "Type your comment",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: DarkThemeColors.accentColor),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            controller.addComment(post.id);
          },
          icon: const Icon(
            Icons.send,
            color: DarkThemeColors.accentColor,
          ),
        ),
      ],
    ),
  );
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    leading: InkWell(
      onTap: () {
        Get.back();
      },
      child: const Icon(Icons.arrow_back_ios_new),
    ),
    title: Row(
      children: [
        _avatar(),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EllipsisText(
                text: "House of Geeks - 1st Year",
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              EllipsisText(
                text:
                    "House of Geek is the technical society of Indian Institute of Information Technology, Ranchi. Lorem ipsum dolor si amet...",
                textStyle: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _avatar() {
  return Obx(() {
    AvatarController avatarController = Get.find<AvatarController>();
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: avatarController.avatars[0].svgData != null
          ? SvgPicture.string(avatarController.avatars[0].svgData!)
          : SvgPicture.asset("assets/images/group_logo.svg"),
    );
  });
}
