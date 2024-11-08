import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/chat/chat_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
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

  @override
  void initState() {
    super.initState();
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

    // Start animations when the screen is built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPop(bool didPop, Object? result) {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    final ThemeController themeController = Get.find<ThemeController>();

    return PopScope(
      onPopInvokedWithResult: _onPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: SlideTransition(
            position: _appBarAnimation,
            child: _buildAppBar(
              context,
              themeController.primaryColor,
              _animationController,
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
                    ListView(
                      children: const [
                        SentMessage(
                            message:
                                "nhasfjasd fgeuf gjdsas fjasd fgeufgj dsasfjas dfgeufgjd sasfj as dfge ufgjds sdfge ufgjdsa sfjasdfgeu fgjdsasfjmar  "),
                        SizedBox(height: 10),
                        ReceiveMessage(
                            message:
                                "hasfjasd fgeuf gjdsas fjasd fgeufgj dsasfjas dfgeufgjd sasfj as dfge ufgjds sdfge ufgjdsa sfjasdfgeu fgjdsasfjmar  "),
                      ],
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
                        // Handle send action
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
  Color primaryColor,
  AnimationController animationController,
) {
  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: primaryColor,
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
        animationController.reverse();
        Get.back();
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    ),
    title: GestureDetector(
      onTap: () {
        Get.toNamed('/chatDetails');
      },
      child: Row(
        children: [
          ClipOval(
            child: SvgPicture.asset(
              "assets/images/group_logo.svg",
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EllipsisText(
                  text: "House of Geeks - 1st Year",
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
                EllipsisText(
                  text:
                      "House of Geek is the technical society of Indian Institute of Information Technology, Ranchi. Lorem ipsum dolor si amet...",
                  textStyle: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          // Handle search action
        },
        icon: const Icon(Icons.search),
      ),
    ],
  );
}
