import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/theme_controller.dart';
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
        appBar: _buildAppBar(_tabController),
        body: Container(
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
        ));
  }
}

AppBar _buildAppBar(TabController tabController) {
  final themeController = Get.find<ThemeController>();
  return AppBar(
    toolbarHeight: 64,
    title: const Text(
      "Annonify",
      style: TextStyle(fontFamily: 'SankofaDisplay', fontSize: 28),
    ),
    leading: IconButton(
      icon: const Icon(
        Icons.search,
        color: DarkThemeColors.accentColor,
      ),
      onPressed: () {},
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 14),
        child: InkWell(
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
