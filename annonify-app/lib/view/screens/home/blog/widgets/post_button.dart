import 'package:annonify/controller/app/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostButton extends StatelessWidget {
  final IconData icon;
  final String? text;
  final VoidCallback onTap;

  const PostButton({
    super.key,
    required this.icon,
    this.text = "",
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(themeController.postButtonColor),
      ),
      onPressed: onTap,
      label: Text(
        text!,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      icon: Icon(
        icon,
        color: themeController.textSubHeading,
      ),
    );
  }
}
