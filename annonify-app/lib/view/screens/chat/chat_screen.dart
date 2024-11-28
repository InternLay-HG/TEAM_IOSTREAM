import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/controller/chat/chat_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/models/group_model.dart';
import 'package:annonify/services/chat_service.dart';
import 'package:annonify/view/Widgets/ellipsis_text.dart';
import 'package:annonify/view/screens/chat/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _appBarAnimation;
  late Animation<Offset> _bodyAnimation;
  final Group group = Get.arguments;

  // final controller = Get.put(ChatController());
  final controller = Get.find<ChatController>();
  final ThemeController themeController = Get.find<ThemeController>();
  final SocketService _chatSocketService = Get.find<SocketService>();

  @override
  void initState() {
    super.initState();
    print("object:${controller.userId}");
    _chatSocketService.connectToSocket(controller.userId ?? "", group.id);
    _chatSocketService.joinGroup(group.id);

    // Add listener to scroll to bottom whenever messages are updated
    _chatSocketService.messages.listen((_) {
      controller.scrollToBottom();
    });
    controller.scrollToBottom();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _appBarAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Slide in from right for AppBar
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _bodyAnimation = Tween<Offset>(
      begin: const Offset(0, -0.8), // Slide down from top for Body
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // controller.dispose();
    super.dispose();
  }

  void _onPop(bool didPop, Object? result) {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final userId = controller.userId;
    return PopScope(
      onPopInvokedWithResult: _onPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: SlideTransition(
            position: _appBarAnimation,
            child: _buildAppBar(
              context,
              controller,
              themeController,
              _animationController,
              group,
            ),
          ),
        ),
        body: SlideTransition(
          position: _bodyAnimation,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      "assets/images/chat_bg.svg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    // Add chat messages or other content here
                    Obx(
                      () => ListView.builder(
                        controller: controller.scrollController,
                        itemCount: _chatSocketService.messages.length,
                        itemBuilder: (context, index) {
                          final message = _chatSocketService.messages[index];
                          final nextMessage =
                              index + 1 < _chatSocketService.messages.length
                                  ? _chatSocketService.messages[index + 1]
                                  : null;
                          final nextUserId = nextMessage?['user']
                              ['_id']; // Get the next message's userId

                          return (message['user']['_id'] == userId)
                              ? SentMessage(
                                  message: message['content'],
                                  userId: message['user']['_id'],
                                  nextUserId:
                                      nextUserId, // Pass the nextUserId to SentMessage
                                )
                              : ReceiveMessage(
                                  message: message['content'],
                                  userId: message['user']['_id'],
                                  nextUserId:
                                      nextUserId, // Pass the nextUserId to ReceiveMessage
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                decoration: BoxDecoration(
                  color: themeController.contentBG,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle attach file action
                      },
                      icon: const Icon(
                        Icons.attach_file,
                        color: DarkThemeColors.accentColor,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.displaySmall,
                        cursorColor: themeController.secondaryTextColor,
                        controller: controller.messageController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          hintText: "Type your message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: DarkThemeColors.accentColor),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (userId != null) {
                          _chatSocketService.sendMessage(
                              controller.messageController.text,
                              userId,
                              group.id);
                          controller.clearMessage();
                        } else
                          print("nulluser");
                      },
                      icon: const Icon(
                        Icons.send,
                        color: DarkThemeColors.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar _buildAppBar(
  BuildContext context,
  ChatController controller,
  ThemeController themeController,
  AnimationController animationController,
  Group group,
) {
  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: themeController.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
    ),
    leading: IconButton(
      onPressed: () {
        if (controller.isSearching.value) {
          controller.toggleSearch();
        } else {
          animationController.reverse();
          Get.back();
        }
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    ),
    title: Obx(
      () => (controller.isSearching.value)
          ? AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0),
                    end: const Offset(0, 0),
                  ).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: TextField(
                key: const ValueKey('searchBar'),
                controller: controller.searchController,
                cursorColor: themeController.secondaryTextColor,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: const Offset(0, 0),
                  ).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/chatDetails', arguments: group);
                },
                child: Row(
                  children: [
                    _avatar(),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EllipsisText(
                            text: group.name,
                            textStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                          EllipsisText(
                            text: group.description,
                            textStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ),
    actions: [
      Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return RotationTransition(
              turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: (controller.isSearching.value)
              ? IconButton(
                  key: const ValueKey('clearButton'),
                  onPressed: () {
                    controller.clearSearchQuery();
                  },
                  icon: const Icon(Icons.clear),
                )
              : IconButton(
                  onPressed: () {
                    // Handle search action
                    controller.toggleSearch();
                  },
                  icon: const Icon(Icons.search),
                ),
        ),
      ),
    ],
  );
}

Widget _avatar() {
  // return Obx(() {
  //   AvatarController avatarController = Get.find<AvatarController>();
  return CircleAvatar(
    backgroundColor: Colors.white,
    child:
        // avatarController.avatars[0].svgData != null
        //     ? SvgPicture.string(avatarController.avatars[0].svgData!):
        SvgPicture.asset("assets/images/group_logo.svg"),
  );
  // });
}
