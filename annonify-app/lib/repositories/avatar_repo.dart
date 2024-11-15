import 'package:annonify/models/avatar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AvatarRepository {
  final String? baseUrl = dotenv.env['avatarApi'];

  // List of avatar names
  final List<String> avatarNames = [
    "Brian",
    "Kimberly",
    "Kingston",
    "Easton",
    "Brooklynn",
    "Oliver",
    "Maria",
    "Sarah",
    "Avery",
    "Emery",
    "Sara",
    "Ryan",
    "Chase",
    "Eden",
    "Sadie",
    "Robert",
  ];

  // In-memory cache for avatars
  final Map<String, Avatar> _avatarsCache = {};

  // Fetch and cache avatars
  Future<void> fetchAndCacheAvatars() async {
    for (var name in avatarNames) {
      final avatar = Avatar(name: name, imageUrl: "$baseUrl$name");
      avatar.svgData = await _fetchImageData(avatar.imageUrl);

      // Fetch image data

      // Cache the avatar
      _avatarsCache[name] = avatar;
    }
  }

  // Private method to fetch image data from the API
  Future<String?> _fetchImageData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("Error fetching image data: $e");
    }
    return null;
  }

  // Retrieve an avatar by name
  Avatar? getAvatarByName(String name) {
    return _avatarsCache[name];
  }

  // Get all avatars
  List<Avatar> getAllAvatars() {
    return _avatarsCache.values.toList();
  }
}
