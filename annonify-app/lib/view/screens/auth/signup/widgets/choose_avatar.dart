import 'package:annonify/configs/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChooseAvatar extends StatelessWidget {
  const ChooseAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                "CHOOSE YOUR AVATAR",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: DarkThemeColors.accentColor,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing:
                        (MediaQuery.of(context).size.width - 50) * 0.04,
                    mainAxisSpacing:
                        (MediaQuery.of(context).size.width - 50) * 0.04,
                  ),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return ClipOval(
                      child: SvgPicture.asset(
                        "assets/images/group_logo.svg",
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: const Alignment(1, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                  child: const Text("Continue"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
