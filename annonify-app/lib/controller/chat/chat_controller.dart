import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();

  final RxBool isSearching = false.obs;
  final RxString searchQuery = "".obs;
  final TextEditingController searchController = TextEditingController();

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) searchQuery.value = '';
  }

  void clearSearchQuery() {
    searchController.text = '';
  }
}
