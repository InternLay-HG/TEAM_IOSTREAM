import 'package:annonify/controller/app/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostButton extends StatelessWidget {
  final IconData icon;
  final String? text;

  const PostButton({
    super.key,
    required this.icon,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(themeController.postButtonColor),
      ),
      onPressed: () {},
      label: Text(
        text!,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      icon: Icon(
        icon,
        color: themeController.textSubHeading,
      ),
    );
    //     Container(
    //   padding: const EdgeInsets.all(8),
    //   // margin: const EdgeInsets.all(10),
    //   decoration: BoxDecoration(
    //       color: themeController.postButtonColor, shape: BoxShape.circle),
    //   child: Row(
    //     children: [
    //       Icon(
    //         icon,
    //         color: themeController.textSubHeading,
    //       ),
    //       if (text != null)
    //         Text(
    //           text!,
    //           style: Theme.of(context).textTheme.bodySmall,
    //         ),
    //     ],
    //   ),
    // ),
  }
}
