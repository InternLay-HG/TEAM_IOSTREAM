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

  final SocketService _socketService = Get.find<SocketService>();

  @override
  void onInit() {
    super.onInit();
    _socketService.connectToSocket(
        '673482cfb9a43a6672046461', '673493b8e470a36c5dbcbc60');
    _socketService.joinGroup('673493b8e470a36c5dbcbc60');
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
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
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
