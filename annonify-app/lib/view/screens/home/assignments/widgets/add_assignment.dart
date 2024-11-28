import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/controller/assignment/assignment_controller.dart';
import 'package:annonify/view/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAssignment extends StatelessWidget {
  const AddAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    AssignmentController controller = Get.find<AssignmentController>();

    return Dialog(
      elevation: 20,
      shape: const RoundedRectangleBorder(),
      shadowColor: themeController.highlightColor,
      backgroundColor: themeController.contentBG,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: const Alignment(-1, 0),
                child: Text(
                  "Create New Assignment",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),
              BorderdTF(
                controller: controller.titleController,
                hint: "Title",
              ),
              const SizedBox(height: 14),
              BorderdTF(
                controller: controller.descriptionController,
                hint: "Description",
                maxLines: 3,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Due Date",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Row(
                    children: [
                      Obx(() {
                        final date = controller.selectedDate.value;
                        return Text(
                          date != null
                              ? date.toLocal().toString().substring(0, 16)
                              : "dd-mm-yy --:--",
                          style: Theme.of(context).textTheme.displaySmall,
                        );
                      }),
                      IconButton(
                        onPressed: () => controller.pickDate(context),
                        icon: const Icon(Icons.date_range),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: controller.pickFile,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
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
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {
                  controller.createAssignment();
                },
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(Colors.green),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return Text(!controller.isUploading.value
                          ? "Create Assignment"
                          : "Uploading...");
                    })
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
