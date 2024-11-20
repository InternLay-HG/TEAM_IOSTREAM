import 'package:annonify/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      final isLoggedIn = await AuthService().isAuthenticated();
      if (isLoggedIn) {
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/signin');
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
