import 'package:annonify/configs/Theme/dark_theme.dart';
import 'package:annonify/configs/Theme/light_theme.dart';
import 'package:annonify/configs/routes/app_router.dart';
import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/repositories/avatar_repo.dart';
import 'package:annonify/services/auth_service.dart';
import 'package:annonify/services/chat_service.dart';
import 'package:annonify/view/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'controller/chat/chat_controller.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  Get.put(AvatarController(AvatarRepository()));
  Get.put(SocketService());
  Get.put(AuthService());
  Get.put(ChatController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Annonify',
        themeMode: themeController.themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        getPages: AppRouter.routes,
        home: const SplashScreen(),
      );
    });
  }
}
