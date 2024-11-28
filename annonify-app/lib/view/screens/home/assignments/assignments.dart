import 'package:annonify/controller/assignment/assignment_controller.dart';
import 'package:annonify/view/screens/home/assignments/widgets/assignment_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Assignments extends StatelessWidget {
  const Assignments({super.key});

  @override
  Widget build(BuildContext context) {
    AssignmentController controller = Get.put(AssignmentController());
    return Obx(
      () => ListView.builder(
        controller: controller.scrollController,
        itemCount: controller.assignments.length,
        itemBuilder: (context, index) {
          final assignment = controller.assignments[index];
          return AssignmentTile(
            id: assignment.id,
            title: assignment.title,
            description: assignment.description,
            dueDate: assignment.dueDate.toString(),
            filePath: assignment.file,
          );
        },
      ),
    );
  }
}
