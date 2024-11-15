import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/controller/app/home_page_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/view/screens/home/blog/blogs.dart';
import 'package:annonify/view/screens/home/blog/widgets/add_blog.dart';
import 'package:annonify/view/screens/home/chats/all_chats.dart';
import 'package:annonify/view/screens/home/links/links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _bodyAnimation;
  final HomePageController _controller = Get.put(HomePageController());
  AvatarController avatarController = Get.find<AvatarController>();
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _bodyAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Slide down from top for Body
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
    return PopScope(
      onPopInvokedWithResult: _onPop,
      child: Obx(
        () => (avatarController.avatars.isEmpty)
            ? const Scaffold(body: Center(child: CircularProgressIndicator()))
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(120),
                  child: _buildAppBar(
                      context, _controller.tabController, _controller),
                ),
                body: SlideTransition(
                  position: _bodyAnimation,
                  child: Container(
                    // padding: const EdgeInsets.only(top: 40, left: 22, right: 22),
                    padding:
                        const EdgeInsets.only(top: 40, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: themeController.contentBG,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: TabBarView(
                      controller: _controller.tabController,
                      children: _controller.screens,
                    ),
                  ),
                ),
                floatingActionButton: (_controller.currentIndex.value == 1)
                    ? FloatingActionButton(
                        onPressed: () {
                          Get.dialog(AddBlogDialog());
                        },
                        child: const Icon(Icons.post_add),
                      )
                    : null,
              ),
      ),
    );
  }
}

Widget _buildAppBar(BuildContext context, TabController tabController,
    HomePageController searchBarController) {
  final themeController = Get.find<ThemeController>();

  return Obx(() => AppBar(
        // toolbarHeight: 64,
        title: searchBarController.isSearching.value
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
                  controller: searchBarController.controller,
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
                child: const Text(
                  "Annonify",
                  style: TextStyle(fontFamily: 'SankofaDisplay', fontSize: 28),
                ),
              ),
        leading: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return RotationTransition(
              turns: Tween<double>(begin: 0, end: 1.0).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: IconButton(
            key: ValueKey(searchBarController.isSearching.value),
            icon: Icon(
              searchBarController.isSearching.value
                  ? Icons.arrow_back_ios_new
                  : Icons.search,
              color: DarkThemeColors.accentColor,
            ),
            onPressed: () {
              searchBarController.toggleSearch();
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: searchBarController.isSearching.value
                  ? IconButton(
                      key: const ValueKey('clearButton'),
                      onPressed: () {
                        searchBarController.clearSearchQuery();
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : InkWell(
                      key: const ValueKey('logo'),
                      onTap: () {
                        themeController.toggleTheme();
                      },
                      child: _avatar(),
                    ),
            ),
          ),
        ],
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(vertical: 10),
          controller: tabController,
          tabs: const [
            Text("All Chats"),
            Text("Blogs"),
            Text("Links"),
          ],
        ),
      ));
}

Widget _avatar() {
  return Obx(() {
    AvatarController avatarController = Get.find<AvatarController>();
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: avatarController.avatars[0].svgData != null
          ? SvgPicture.string(avatarController.avatars[0].svgData!)
          : SvgPicture.asset("assets/images/group_logo.svg"),
    );
  });
}
