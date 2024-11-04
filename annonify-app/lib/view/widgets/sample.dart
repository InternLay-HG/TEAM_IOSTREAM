import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SampleImage extends StatelessWidget {
  final double height;

  const SampleImage({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height,
        child: Stack(
          children: [
            Transform.scale(
              scale: 2,
              child: SvgPicture.asset(
                "assets/images/bg.svg",
              ),
            ),
            Positioned(
              top: -150,
              left: 100,
              child: Transform.rotate(
                angle: 31,
                child: Transform.scale(
                  scale: 0.8,
                  child: SvgPicture.asset(
                    "assets/images/app.svg",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
