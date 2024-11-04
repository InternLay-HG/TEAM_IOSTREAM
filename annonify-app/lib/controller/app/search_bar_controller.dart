import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchBarController extends GetxController {
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
