import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:annonify/models/assignment/assignment_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AssignmentController extends GetxController {
  RxList<Assignment> assignments = <Assignment>[].obs;

  //Text field controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  //Date Time Picker
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(selectedDate.value ?? DateTime.now()),
      );

      if (pickedTime != null) {
        // Combine the date and time
        selectedDate.value = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }

  //File Picker
  RxString filePath = "".obs;
  var selectedFile = Rxn<File>();

  Future<void> pickFile() async {
    try {
      // Pick a file
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      // If a file is picked, store the path
      if (result != null) {
        filePath.value = result.files.single.path ?? '';
        selectedFile.value = File(filePath.value);
      } else {
        // If no file is selected, you can set filePath to empty string or any default message
        filePath.value = "No file selected";
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAssignments();
  }

  String? uri = dotenv.env['uri'];
  String? server = dotenv.env['server'];

  Future<void> fetchAssignments() async {
    try {
      final url = Uri.parse('${uri}assignments');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> data = jsonDecode(response.body);
        assignments.assignAll(
            data.map((json) => Assignment.fromJson(json)).toList().reversed);
      } else {
        throw Exception('Failed to load assignments');
      }
    } catch (error) {
      print(error);
      Get.snackbar("Error", "Failed to fetch assignments.");
    }
  }

  final isUploading = false.obs;

  Future<void> createAssignment() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedDate.value == null) {
      Get.snackbar("Error", "Please fill all fields and upload a file");
      return;
    }

    try {
      isUploading.value = true;
      final url = Uri.parse('${uri}assignments');

      var request = http.MultipartRequest('POST', url);

      final Map<String, String> body = {
        "title": titleController.text,
        "description": descriptionController.text,
        "dueDate": selectedDate.value!.toIso8601String(),
        "professorId": "673482cfb9a43a6672046461",
      };

      request.fields.addAll(body);

      // Add the file as a part
      if (selectedFile.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'file', selectedFile.value!.path));
      }

      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        fetchAssignments();
        Get.back();
        scrollToTop();
        Get.snackbar("Success", "Assignment created successfully");
        clearFields();
      } else {
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: $responseBody");
        Get.snackbar("Error", "Failed to create assignment");
      }
    } catch (e) {
      print("Error submitting assignment: $e");
      Get.snackbar("Error", "An error occurred");
    } finally {
      isUploading.value = false; //
    }
  }

  Future<void> downloadFile(String filePath) async {
    try {
      final Dio dio = Dio();
      final String fileName = filePath.split('/').last;

      // Get the directory to save the downloaded file
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String savePath = '${appDir.path}/$fileName';

      // Replace `server` with your backend base URL
      final String fileUrl = '$server/$filePath';
      print(fileUrl);

      // Download the file
      await dio.download(
        fileUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print(
                'Downloading: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );
      print(savePath);
      Get.snackbar("Success", "File downloaded to $savePath");
    } catch (e) {
      print("Error downloading file: $e");
      Get.snackbar("Error", "Failed to download file");
    }
  }

  Future<void> submitAssignment(String assignmentId) async {
    isUploading.value = true;

    try {
      // Prepare the multipart request
      final Uri url = Uri.parse('$uri/assignments/submit');
      var request = http.MultipartRequest('POST', url);

      // Add form fields
      request.fields['assignmentId'] = assignmentId;
      request.fields['studentId'] = '673482cfb9a43a6672046461';

      // Add the file
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        selectedFile.value!.path,
      ));

      // Send the request
      var response = await request.send();

      // Handle response
      if (response.statusCode == 201) {
        // If successful, get the response body
        final responseBody = await response.stream.bytesToString();
        final data = jsonDecode(responseBody);
        clearFields();
        Get.snackbar('Success', 'Assignment submitted successfully!');
      } else {
        Get.snackbar('Error', 'Failed to submit assignment.');
      }
    } catch (e) {
      print('Error submitting assignment: $e');
      Get.snackbar(
          'Error', 'An error occurred while submitting the assignment.');
    } finally {
      isUploading.value = false;
    }
  }

  final ScrollController scrollController = ScrollController();

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    selectedDate.value = null;
    filePath.value = "";
  }
}
