import 'package:annonify/services/auth_service.dart';
import 'package:annonify/utils/user.dart';
import 'package:annonify/view/screens/home/assignments/assignments.dart';
import 'package:annonify/view/screens/home/blog/blogs.dart';
import 'package:annonify/view/screens/home/chats/all_chats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //Tab Controller
  final currentIndex = 0.obs; // Observable variable for current index

  final screens = [
    const AllChats(),
    const Blogs(),
    const Assignments(),
  ];
  late TabController tabController;

  final authService = Get.find<AuthService>();

  String? userAvatar;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: screens.length);
    tabController.addListener(() {
      currentIndex.value =
          tabController.index; // Update currentIndex when TabController changes
    });
    getAvatar();
  }

  Future<void> getAvatar() async {
    if (authService.userId != null) {
      userAvatar = await User().getAvatarName(authService.userId!);
    } else {
      print('User ID is null; cannot fetch avatar.');
      userAvatar = 'default_avatar';
    }
  }

  //Search Controller
  final RxBool isSearching = false.obs;
  final RxString searchQuery = "".obs;
  final TextEditingController controller = TextEditingController();

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) searchQuery.value = '';
  }

  void clearSearchQuery() {
    controller.text = '';
  }
}
