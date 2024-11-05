import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/view/Screens/Chat/chat_screen.dart';
import 'package:annonify/view/Widgets/ellipsis_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllChats extends StatelessWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 83,
          child: ListTile(
            leading: SvgPicture.asset("assets/images/group_logo.svg"),
            title: const EllipsisText(
              text: "House of Geeks - 1st Year",
            ),
            subtitle: const EllipsisText(
                text:
                    "This is a very long text that may overflow if it does not fit within the given "),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("4 m"),
                Icon(
                  CupertinoIcons.pin,
                  size: 15,
                ),
              ],
            ),
            hoverColor: Colors.white,
            splashColor: Colors.white,
            onTap: () {
              Get.toNamed('/chat');
            },
          ),
        );
      },
    );
  }
}
