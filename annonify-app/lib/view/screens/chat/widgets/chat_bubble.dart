import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Triangle extends CustomPainter {
  final Color bgColor;

  Triangle(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.moveTo(0, -10); // Peak of the triangle pointing up
    path.lineTo(-5, 0); // Bottom-left corner of the triangle
    path.lineTo(5, 0); // Bottom-right corner of the triangle

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ReceiveMessage extends StatelessWidget {
  final String message;

  const ReceiveMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final AvatarController avatarController = Get.find<AvatarController>();

    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomPaint(
            painter: Triangle(LightThemeColors.receiverBubbleColor),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: LightThemeColors.receiverBubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Text(
                message,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 50, left: 18, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _avatar(avatarController),
          const SizedBox(width: 10),
          messageTextGroup,
        ],
      ),
    );
  }
}

class SentMessage extends StatelessWidget {
  final String message;

  const SentMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final AvatarController avatarController = Get.find<AvatarController>();

    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: LightThemeColors.senderBubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Text(
                message,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
          CustomPaint(
            painter: Triangle(LightThemeColors.senderBubbleColor),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 18.0, left: 50, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          messageTextGroup,
          const SizedBox(width: 10),
          _avatar(avatarController),
        ],
      ),
    );
  }
}

Widget _avatar(AvatarController avatarController) {
  return Obx(
    () => Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
          color: LightThemeColors.contentBG,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          )),
      child: avatarController.avatars[0].svgData != null
          ? SvgPicture.string(avatarController.avatars[0].svgData!)
          : SvgPicture.asset("assets/images/group_logo.svg"),
    ),
  );
}
