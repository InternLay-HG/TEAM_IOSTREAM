import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/utils/user.dart';
import 'package:annonify/view/widgets/MyAvatar.dart';
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
  final String userId;
  final String? nextUserId; // The userId of the next message (for comparison)

  const ReceiveMessage({
    super.key,
    required this.message,
    required this.userId,
    this.nextUserId,
  });

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (nextUserId != userId)
            CustomPaint(
              painter: Triangle(LightThemeColors.receiverBubbleColor),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: LightThemeColors.receiverBubbleColor,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(14),
                    bottomRight: const Radius.circular(14),
                    topRight: const Radius.circular(14),
                    bottomLeft: (nextUserId != userId)
                        ? Radius.zero
                        : const Radius.circular(14)),
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
      padding: const EdgeInsets.only(right: 50, left: 8, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Show avatar only if the next message is from a different user
          (nextUserId != userId)
              ? ChatAvatar(userId: userId)
              : const SizedBox(width: 40),
          const SizedBox(width: 10),
          messageTextGroup,
        ],
      ),
    );
  }
}

class SentMessage extends StatelessWidget {
  final String message;
  final String userId;
  final String? nextUserId; // The userId of the next message (for comparison)

  const SentMessage({
    super.key,
    required this.message,
    required this.userId,
    this.nextUserId,
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
              decoration: BoxDecoration(
                color: LightThemeColors.senderBubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  bottomLeft: const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomRight: (nextUserId != userId)
                      ? Radius.zero
                      : const Radius.circular(14),
                ),
              ),
              child: Text(
                message,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
          if (nextUserId != userId)
            CustomPaint(
              painter: Triangle(LightThemeColors.senderBubbleColor),
            ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 50, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          messageTextGroup,
          const SizedBox(width: 10),
          // Show avatar only if the next message is from a different user
          (nextUserId != userId)
              ? ChatAvatar(userId: userId)
              : const SizedBox(width: 40),
        ],
      ),
    );
  }
}
