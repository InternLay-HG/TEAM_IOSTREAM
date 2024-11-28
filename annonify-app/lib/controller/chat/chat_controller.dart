import 'package:annonify/services/auth_service.dart';
import 'package:annonify/services/chat_service.dart';
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

  final AuthService authService = Get.find<AuthService>();
  String? userId;

  @override
  Future<void> onInit() async {
    super.onInit();
    userId = (await authService.getUserId());
    print("chatcon:$userId");
  }

  void clearSearchQuery() {
    searchController.text = '';
  }

  void clearMessage() {
    messageController.text = '';
  }

  // Scroll to bottom of the chat
  final ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    if (scrollController.hasClients) {
      // print("scroll$userId");
      scrollController.animateTo(
        scrollController.position.extentTotal,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    messageController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
