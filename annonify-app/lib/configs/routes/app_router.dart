import 'package:annonify/view/Screens/Chat/chat_details.dart';
import 'package:annonify/view/Screens/Chat/chat_screen.dart';
import 'package:annonify/view/screens/auth/signIn/sign_in.dart';
import 'package:annonify/view/screens/auth/signup/sign_up.dart';
import 'package:annonify/view/screens/auth/signup/widgets/choose_avatar.dart';
import 'package:annonify/view/screens/home/home.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: "/home",
      page: () => const HomePage(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeftWithFade,
      curve: Curves.elasticInOut,
    ),
    GetPage(
      name: "/signup",
      page: () => const SignUpPage(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.size,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: "/signin",
      page: () => const SignInPage(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.size,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: "/chooseAvatar",
      page: () => const ChooseAvatar(),
      transitionDuration: const Duration(milliseconds: 400),
      transition: Transition.downToUp,
      curve: Curves.elasticInOut,
    ),
    GetPage(
      name: "/chat",
      page: () => const ChatScreen(),
      transitionDuration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: "/chatDetails",
      page: () => const ChatDetails(),
      transitionDuration: const Duration(milliseconds: 400),
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOut,
    ),
  ];
}
