import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/services/auth_service.dart';
import 'package:annonify/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyAvatar extends StatelessWidget {
  final String? name;

  const MyAvatar({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    AvatarController avatarController = Get.find<AvatarController>();
    final avatar = avatarController.getAvatarByName(name!);

    return CircleAvatar(
      backgroundColor: Colors.white,
      child: avatar.svgData != null
          ? SvgPicture.string(avatar.svgData!)
          : SvgPicture.asset("assets/images/group_logo.svg"),
    );
  }
}

class ChatAvatar extends StatefulWidget {
  final String? userId;

  const ChatAvatar({
    super.key,
    required this.userId,
  });

  @override
  State<ChatAvatar> createState() => _ChatAvatarState();
}

class _ChatAvatarState extends State<ChatAvatar> {
  AvatarController avatarController = Get.find<AvatarController>();
  final authService = Get.find<AuthService>();

  String? userAvatar;

  @override
  void initState() {
    super.initState();
    getAvatar();
  }

  // Fetch avatar name asynchronously
  Future<void> getAvatar() async {
    final avatarName = await User().getAvatarName(widget.userId!);
    setState(() {
      userAvatar = avatarName;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userAvatar == null) {
      // Show a loading indicator while avatar is being fetched
      return const CircularProgressIndicator();
    }

    final avatar = avatarController.getAvatarByName(userAvatar!);

    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: avatar.svgData != null
          ? SvgPicture.string(avatar.svgData!)
          : SvgPicture.asset("assets/images/group_logo.svg"),
    );
  }
}
