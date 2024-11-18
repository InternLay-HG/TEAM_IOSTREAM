import 'dart:io';

import 'package:annonify/view/screens/home/blog/blogs.dart';
import 'package:annonify/view/screens/home/chats/all_chats.dart';
import 'package:annonify/view/screens/home/links/links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //Tab Controller
  final currentIndex = 0.obs; // Observable variable for current index

  final screens = [
    const AllChats(),
    const Blogs(),
    const Links(),
  ];
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: screens.length);
    tabController.addListener(() {
      currentIndex.value =
          tabController.index; // Update currentIndex when TabController changes
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
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
