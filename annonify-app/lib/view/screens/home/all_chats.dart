import 'package:annonify/models/group_model.dart';
import 'package:annonify/view/Widgets/ellipsis_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllChats extends StatelessWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Group> groups = [
      Group(
        name: 'House of Geeks',
        description:
            'House of Geeks is a Technical Society of Indian Institute of Information Technology Ranchi',
      ),
      Group(
        name: 'Sports Society',
        description: '',
      ),
      Group(
        name: 'Hostel Committee',
        description: '',
      ),
      Group(
        name: 'Mess Committee',
        description: '',
      ),
      Group(
        name: 'E-Cell',
        description: '',
      ),
      Group(
        name: 'Saaz',
        description: 'The music club of IIIT Ranchi',
      ),
      Group(
        name: 'RangBaaz',
        description: 'The drama club of IIIT Ranchi',
      ),
      Group(
        name: 'Kirti',
        description: '',
      ),
      Group(
        name: 'Confession Group',
        description: '',
      ),
      Group(
        name: '1st Year',
        description: 'The official group of first year students.',
      ),
      Group(
        name: '2nd Year',
        description: 'The official group of second year students.',
      ),
      Group(
        name: '3rd Year',
        description: 'The official group of third year students.',
      ),
      Group(
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
