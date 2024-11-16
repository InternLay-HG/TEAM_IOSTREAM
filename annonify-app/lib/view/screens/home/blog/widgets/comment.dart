import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommentCard extends StatelessWidget {
  final String content;

  const CommentCard({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find<ThemeController>();
    return Card(
      color: themeController.contentBG,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                _avatar(),
                const SizedBox(width: 10),
                Text(
                  "user",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 10),
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
