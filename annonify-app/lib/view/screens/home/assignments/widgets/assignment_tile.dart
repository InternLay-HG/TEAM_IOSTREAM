import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/controller/assignment/assignment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignmentTile extends StatelessWidget {
  final String? id;
  final String title;
  final String description;
  final String dueDate;
  final String filePath;

  const AssignmentTile({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final controller = Get.find<AssignmentController>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: themeController.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 10),
            Text(
              "Due Date: ${dueDate.substring(0, 16)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                print(filePath);
                controller.downloadFile(filePath);
              },
              child: Text(
                "Download file",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: controller.pickFile,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration:
                        BoxDecoration(color: themeController.highlightColor),
                    child: Text(
                      "Upload File",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                // const Expanded(child: SizedBox()),
                Obx(() {
                  return Flexible(
                    child: Text(
                      controller.filePath.value.isNotEmpty
                          ? controller.filePath.value.split('/').last
                          : "No file selected",
                      style: Theme.of(context).textTheme.displaySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (id != null) controller.submitAssignment(id!);
              },
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(Colors.green),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Submit Assignment"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
