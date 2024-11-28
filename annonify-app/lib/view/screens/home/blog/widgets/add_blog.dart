import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/controller/blog/blog_controller.dart';
import 'package:annonify/view/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBlogDialog extends StatelessWidget {
  const AddBlogDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    BlogController controller = Get.find<BlogController>();
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
                  "Add New Blog",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),
              BorderdTF(
                hint: "Blog Title",
                controller: controller.titleController,
              ),
              const SizedBox(height: 14),
              BorderdTF(
                hint: "Description",
                controller: controller.bodyController,
                maxLines: 3,
              ),
              const SizedBox(height: 14),
              Obx(
                () => controller.selectedImage.value != null
                    ? Image.file(
                        controller.selectedImage.value!,
                        height: 200,
                      )
                    : InkWell(
                        onTap: controller.pickImage,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                              color: themeController.highlightColor),
                          child: const Text("Choose Image"),
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.addBlog();
                },
                child: Obx(() {
                  return controller.isPosting.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Post Blog");
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
