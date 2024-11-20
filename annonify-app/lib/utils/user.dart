import 'dart:convert';
import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class User {
  String? server = dotenv.env['uri'];
  final AvatarController avatarController = Get.find<AvatarController>();

  // Fetches avatar name from the server based on userId
  Future<String> getAvatarName(String userId) async {
    final url = Uri.parse('$server/$userId'); // Assuming endpoint for user info
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['avatar']; // Provide a fallback name
      } else {
        throw Exception('Failed to fetch avatar name');
      }
    } catch (error) {
      // Log the error and return a default avatar name
      print('Error fetching avatar name: $error');
      return 'default_avatar';
    }
  }
}
