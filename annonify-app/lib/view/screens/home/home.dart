import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/app/search_bar_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/view/Screens/Home/all_chats.dart';
import 'package:annonify/view/Screens/Home/links.dart';
import 'package:annonify/view/Screens/Home/media.dart';
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
  late Animation<Offset> _appBarAnimation;
  late Animation<Offset> _bodyAnimation;
  late TabController _tabController;
  final SearchBarController _searchBarController =
      Get.put(SearchBarController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _appBarAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Slide in from right for AppBar
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

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
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    _animationController.reverse();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: _buildAppBar(context, _tabController, _searchBarController),
        body: SlideTransition(
          position: _bodyAnimation,
          child: Obx(
            () {
              final ThemeController themeController =
                  Get.find<ThemeController>();

              return Container(
                padding: const EdgeInsets.only(top: 40, left: 22, right: 22),
                decoration: BoxDecoration(
                  color: themeController.contentBG,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    AllChats(),
                    Media(),
                    Links(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

AppBar _buildAppBar(BuildContext context, TabController tabController,
    SearchBarController searchBarController) {
  final themeController = Get.find<ThemeController>();

  return AppBar(
    toolbarHeight: 64,
    title: Obx(
      () => searchBarController.isSearching.value
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
    ),
    leading: Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationTransition(
            turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
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
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Obx(
          () => AnimatedSwitcher(
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
                    child: ClipOval(
                      child: SvgPicture.asset(
                        "assets/images/group_logo.svg",
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    ],
    bottom: TabBar(
      padding: const EdgeInsets.symmetric(vertical: 10),
      controller: tabController,
      tabs: const [
        Text("All Chats"),
        Text("Media"),
        Text("Links"),
      ],
    ),
  );
}
