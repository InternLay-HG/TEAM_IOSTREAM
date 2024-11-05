import 'package:annonify/view/Screens/Chat/chat_details.dart';
import 'package:annonify/view/Screens/Chat/chat_screen.dart';
import 'package:annonify/view/screens/auth/signIn/sign_in.dart';
import 'package:annonify/view/screens/auth/signup/sign_up.dart';
import 'package:annonify/view/screens/auth/signup/widgets/choose_avatar.dart';
import 'package:annonify/view/screens/home/home.dart';
import 'package:get/get.dart';

class AppRouter {
  static final routes = [
    GetPage(name: "/home", page: () => const HomePage()),
    GetPage(name: "/signup", page: () => const SignUpPage()),
    GetPage(name: "/signin", page: () => const SignInPage()),
    GetPage(name: "/chooseAvatar", page: () => const ChooseAvatar()),
    GetPage(name: "/chat", page: () => const ChatScreen()),
    GetPage(name: "/chatDetails", page: () => const ChatDetails()),
  ];
}
