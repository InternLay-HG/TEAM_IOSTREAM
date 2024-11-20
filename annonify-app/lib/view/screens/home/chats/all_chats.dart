import 'package:annonify/models/group_model.dart';
import 'package:annonify/view/Widgets/ellipsis_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllChats extends StatelessWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Group> groups = [
      Group(
        id: "673493b8e470a36c5dbcbc60",
        name: 'House of Geeks',
        description:
            'House of Geeks is a Technical Society of Indian Institute of Information Technology Ranchi',
      ),
      Group(
        id: "2",
        name: 'Sports Society',
        description: '',
      ),
      Group(
        id: "3",
        name: 'Hostel Committee',
        description: '',
      ),
      Group(
        id: '4',
        name: 'Mess Committee',
        description: '',
      ),
      Group(
        id: "5",
        name: 'E-Cell',
        description: '',
      ),
      Group(
        id: "7",
        name: 'Saaz',
        description: 'The music club of IIIT Ranchi',
      ),
      Group(
        id: "8",
        name: 'RangBaaz',
        description: 'The drama club of IIIT Ranchi',
      ),
      Group(
        id: "6",
        name: 'Kirti',
        description: '',
      ),
      Group(
        id: "9",
        name: 'Confession Group',
        description: '',
      ),
      Group(
        id: "10",
        name: '1st Year',
        description: 'The official group of first year students.',
      ),
      Group(
        id: "11",
        name: '2nd Year',
        description: 'The official group of second year students.',
      ),
      Group(
        id: "12",
        name: '3rd Year',
        description: 'The official group of third year students.',
      ),
      Group(
        id: "13",
        name: '4th Year',
        description: 'The official group of fourth year students.',
      ),
    ];

    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 83,
          child: ListTile(
            leading: SvgPicture.asset("assets/images/group_logo.svg"),
            title: EllipsisText(
              text: groups[index].name,
            ),
            subtitle: EllipsisText(text: groups[index].description),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Text("4 m"),
                // Icon(
                //   CupertinoIcons.pin,
                //   size: 15,
                // ),
              ],
            ),
            hoverColor: Colors.white,
            splashColor: Colors.white,
            onTap: () {
              Get.toNamed('/chat', arguments: groups[index]);
            },
          ),
        );
      },
    );
  }
}
