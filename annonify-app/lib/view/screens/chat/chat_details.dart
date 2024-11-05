import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/view/Widgets/ellipsis_text.dart';
import 'package:annonify/view/screens/chat/widgets/file_tile.dart';
import 'package:annonify/view/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatDetails extends StatelessWidget {
  const ChatDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return SafeArea(
      child: Scaffold(
        // appBar: _buildAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SliverPersistentDelegate(),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                decoration: BoxDecoration(
                  color: themeController.contentBG,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMedia(context),
                    const SizedBox(height: 10),
                    _buildDocuments(context),
                    const SizedBox(height: 10),
                    _buildLinks(context),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeaderHeight = 300;
  final double minHeaderHeight = kToolbarHeight;

  final double maxImageSize = 86;
  final double minImageSize = 40;

  SliverPersistentDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final size = MediaQuery.of(context).size;
    final percent = shrinkOffset / (maxHeaderHeight - 35);
    final percent2 = shrinkOffset / (maxHeaderHeight);
    final currentImageSize = (maxImageSize * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    final currentImagePosition = ((size.width * .1) * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 10,
            left: currentImagePosition + 50,
            child: SizedBox(
              width: (size.width - 50 - 25) * 0.7,
              child: Opacity(
                opacity: percent2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EllipsisText(
                      text: "House of Geeks",
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                    EllipsisText(
                      text:
                          "House of Geek is the technical society of Indian Institute of Information Technology, Ranchi. Lorem ipsum dolor si  amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
                      textStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: MediaQuery.of(context).viewPadding.top + 5,
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: MediaQuery.of(context).viewPadding.top + 5,
            child: Visibility(
              visible: percent2 > 0.7,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                ),
              ),
            ),
          ),
          Positioned(
            left: 30 + (15 * (percent2)),
            top: MediaQuery.of(context).viewPadding.top +
                (kToolbarHeight) * (1 - percent2),
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: (percent2 > 0.83)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/group_logo.svg",
                      width: currentImageSize,
                      height: currentImageSize,
                    ),
                    Visibility(
                      visible: (1 - percent2) > 0.9,
                      child: SizedBox(
                        width: size.width - 45 - 85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyIconButton(
                              icon: Icons.edit,
                              onTap: () {},
                            ),
                            MyIconButton(
                              icon: Icons.favorite_border,
                              onTap: () {},
                            ),
                            MyIconButton(
                              icon: Icons.notifications_off,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: (1 - percent2) > 0.9,
                  child: const SizedBox(height: 20),
                ),
                Visibility(
                  visible: (1 - percent2) > 0.9,
                  child: Expanded(
                    child: Container(
                      width: size.width - 45,
                      padding: const EdgeInsets.only(right: 25, bottom: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: (size.width - 50) * 0.6,
                                  child: Text(
                                    "House of Geeks - 1st Year",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                                Text(
                                  "6660 members",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "House of Geek is the technical society of Indian Institute of Information Technology, Ranchi. Lorem ipsum dolor si amet, consectetur adipiscing elit, sed do eiusmod tempuse of Geek is the technical society of Indian Institute of Information Technology, Ranchi. Lorem ipsum dolor si amet, or rem ipsum dolor si amet, or si amet, .",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderHeight;

  @override
  double get minExtent => minHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

Widget _buildMedia(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Photos and Videos",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "See All",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 200,
        child: Center(
          child: Text("No Photos or Videos"),
        ),
      ),
    ],
  );
}

Widget _buildDocuments(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Shared Documents",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "See All",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
      // const SizedBox(
      //   height: 200,
      //   child: Center(
      //     child: Text("No Shared Documents"),
      //   ),
      // ),
      ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return FileTile(
            title: "Introduction to UI UX",
          );
        },
      ),
    ],
  );
}

Widget _buildLinks(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Shared Links",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "See All",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
      // const SizedBox(
      //   height: 200,
      //   child: Center(
      //     child: Text("No Shared Links"),
      //   ),
      // ),
      ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return FileTile(
            link: true,
            title: "Codechef Starters",
            subTitle: "www.codechef.com",
          );
        },
      ),
    ],
  );
}
