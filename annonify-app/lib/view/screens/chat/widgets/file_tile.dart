import 'package:annonify/controller/app/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool link;

  const FileTile({
    super.key,
    required this.title,
    this.subTitle,
    this.link = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return ListTile(
      leading: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: themeController.secondaryTextColor,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: (link)
            ? Icon(
                Icons.link,
                color: themeController.highlightColor,
              )
            : Icon(
                Icons.folder_open,
                color: themeController.highlightColor,
              ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: (subTitle != null)
          ? Text(
              subTitle!,
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
    );
  }
}
